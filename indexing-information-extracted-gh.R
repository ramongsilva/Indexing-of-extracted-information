##################################################################################################
# Indexation of pubmed abstracts with extracted information for: unique entities (individual indexation) 
# and entities associations (cross indexation)
# Author: Ramon Gustavo Teodoro Marques da Silva - ramongsilva@yahoo.com.br

#Import libraries
library(plyr) 
library(DBI)
library(RMySQL)
library(RCurl)
library(RSQLite)
library(stringr)
library(XML)
library(rJava)
library(qdap)
library(reshape)
library(reshape2)
library(tm)
library(data.table)


#Setting the folder with files 
setwd("folder-project/")
source("functions.R")


#############################################################################################
# Retrieving of data in SQLite database
# Retrieving the  textual corpus with pubmed abstracts classified about cancer activity
drv = dbDriver("SQLite")
con = dbConnect(drv,dbname="db_total_project.db")
sql_articles <- str_c("SELECT * FROM articles_ensemble",sep="")	
res_articles <- dbSendQuery(con, sql_articles)
df_articles_positives <- fetch(res_articles, n = -1)
dbDisconnect(con)
df_articles_positives$med2 = (df_articles_positives$SVM_PROB + df_articles_positives$FORESTS_PROB + df_articles_positives$MAXENTROPY_PROB) / 3
df_articles = df_articles_positives
newdata <- df_articles_positives[order(-df_articles_positives$med),] 
rownames(newdata) = c(1:nrow(newdata))
lista_articles = newdata[,1]


#############################################################################################
# Retrieving datafames with named entity and rules associations recognized in Information Extraction step
setwd("folder-project/entities-recognized/")
df_entities01_2000 = fread(file = 'df_entities01_2000.tsv')
df_entities2001_5000 = fread(file = 'df_entities2001_5000.tsv')
df_entities5001_8000 = fread(file = 'df_entities5001_8000.tsv')
df_entities8001_9000 = fread(file = 'df_entities8001_9000.tsv')
df_entities9001_10000 = fread(file = 'df_entities9001_10000.tsv')
df_entities10001_11000 = fread(file = 'df_entities10001_11000.tsv')
df_entities11001_14000 = fread(file = 'df_entities11001_14000.tsv')
df_entities14001_15000 = fread(file = 'df_entities14001_15000.tsv')
df_entities15001_16000 = fread(file = 'df_entities15001_16000.tsv')
df_entities16001_17000 = fread(file = 'df_entities16001_17000.tsv')
df_entities17001_18000 = fread(file = 'df_entities17001_18000.tsv')
df_entities18001_21000 = fread(file = 'df_entities18001_21000.tsv')
df_entities21001_23000 = fread(file = 'df_entities21001_23000.tsv')
df_entities23001_26000 = fread(file = 'df_entities23001_26000.tsv')
df_entities_n_encontradas = fread(file = 'df_entities_n_encontradas.tsv')
df_entities_total = rbind(df_entities01_2000,df_entities2001_5000,df_entities5001_8000,df_entities8001_9000,df_entities9001_10000,df_entities10001_11000,df_entities11001_14000,df_entities14001_15000,df_entities15001_16000,df_entities16001_17000,df_entities17001_18000,df_entities18001_21000,df_entities21001_23000,df_entities23001_26000,df_entities_n_encontradas)
setwd("folder-project/")
df_articles_rules = read.table(file = 'Rule_associations_recognized.tsv', stringsAsFactors = FALSE, sep = '\t', fill = TRUE)


#############################################################################################
# Selecting entities about polyphenols, cancers and genes recognized in the pubmed abstracts
# sentences with at least one rule association recognized, for indexation

# Entities about polyphenols recognized in the pubmed abstracts
df_entities_index_polifenol = df_entities_total[(df_entities_total$entity_type == 'chemical_entity_e' | df_entities_total$entity_type == 'chemical_entity_p' ),]
# Entities about polyphenols recognized in the pubmed abstracts, but in sentences with at least one rule association recognized
df_entities_index_polifenol = df_entities_index_polifenol[(df_entities_index_polifenol$entity_pmid %in% df_articles_rules$pmid),]

# Entities about cancers recognized in the pubmed abstracts
df_entities_index_cancer = df_entities_total[(df_entities_total$entity_type == 'cancer_type_entity_cell' | df_entities_total$entity_type == 'cancer_type_entity_e' | df_entities_total$entity_type == 'cancer_type_entity_p'),]
# Entities about cancers recognized in the pubmed abstracts, but in sentences with at least one rule association recognized
df_entities_index_cancer = df_entities_index_cancer[(df_entities_index_cancer$entity_pmid %in% df_articles_rules$pmid),]

# Entities about HGNC genes recognized in the pubmed abstracts
df_entities_index_gene_hgnc = df_entities_total[(df_entities_total$entity_type == 'gene_hgnc_entity'),]
# Entities about HGNC genes recognized in the pubmed abstracts, but in sentences with at least one rule association recognized
df_entities_index_gene_hgnc = df_entities_index_gene_hgnc[(df_entities_index_gene_hgnc$entity_pmid %in% df_articles_rules$pmid),]
# Entities about genes recognized in the pubmed abstracts
df_entities_index_gene = df_entities_total[(df_entities_total$entity_type == 'gene_entity'),]
# Entities about genes recognized in the pubmed abstracts, but in sentences with at least one rule association recognized
df_entities_index_gene = df_entities_index_gene[(df_entities_index_gene$entity_pmid %in% df_articles_rules$pmid),]
# Total entities about genes recognized in the pubmed abstracts
df_entities_index_gene_total = df_entities_total[(df_entities_total$entity_type == 'gene_entity' | df_entities_total$entity_type == 'gene_hgnc_entity' ),]
# Total entities about genes recognized in the pubmed abstracts, but in sentences with at least one rule association recognized
df_entities_index_gene_total = df_entities_index_gene_total[(df_entities_index_gene_total$entity_pmid %in% df_articles_rules$pmid),]

####################################################################################################
####################################################################################################
#                           START OF INDIVIDUAL INDEXATION
####################################################################################################
####################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about polyphenols entities
polifenols = unique(df_entities_index_polifenol$term_id)
poli_names = unique(df_entities_index_polifenol$db_term)
a = 0
lst_total_ocorrence = list()
lst_articles_entitie = list()
lst_unique_ocorrences = list()
lst_poli_names = list()
lst_polifenols = list()
lst_pmids = list()
for(i in 1:length(polifenols)){
  lst_articles_entitie = df_entities_index_polifenol[df_entities_index_polifenol$term_id == polifenols[i],]
  lst_articles_entitie = lst_articles_entitie$entity_pmid
  a = a + 1
  lst_total_ocorrence[a] = length(lst_articles_entitie)
  lst_articles_entitie = unique(lst_articles_entitie)
  lst_unique_ocorrences[a] = length(lst_articles_entitie)
  lst_poli_names[a] = poli_names[i]
  lst_polifenols[a] = polifenols[i]
  lst_pmids[a] = paste(lst_articles_entitie, collapse = ',')
  cat('\n Nome = ',polifenols[i])
}
# Preparing dataframe with pubmed abstracts indexed for polyphenols entities
df_polyphenol_individual_indexation = data.frame(poliphenol = unlist(lst_poli_names), id_term = unlist(lst_polifenols), total_ocorrence = unlist(lst_total_ocorrence), unique_ocorrence = unlist(lst_unique_ocorrences), pmids = unlist(lst_pmids), stringsAsFactors = FALSE)
df_polyphenol_individual_indexation = df_polyphenol_individual_indexation[order(-df_polyphenol_individual_indexation$unique_ocorrence),]
df_polyphenol_individual_indexation$ration = df_polyphenol_individual_indexation$unique_ocorrence / df_polyphenol_individual_indexation$total_ocorrence
rownames(df_polyphenol_individual_indexation) = 1:nrow(df_polyphenol_individual_indexation)

####################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about cancers entities
cancers = unique(df_entities_index_cancer$term_id)
cancer_names = unique(df_entities_index_cancer$db_term)
a = 0
lst_total_ocorrence = list()
lst_articles_entitie = list()
lst_unique_ocorrences = list()
lst_cancer_names = list()
lst_cancers = list()
lst_pmids = list()
for(i in 1:length(cancers)){
  lst_articles_entitie = df_entities_index_cancer[df_entities_index_cancer$term_id == cancers[i],]
  lst_articles_entitie = lst_articles_entitie$entity_pmid
  a = a + 1
  lst_total_ocorrence[a] = length(lst_articles_entitie)
  lst_articles_entitie = unique(lst_articles_entitie)
  lst_unique_ocorrences[a] = length(lst_articles_entitie)
  lst_cancer_names[a] = cancer_names[i]
  lst_cancers[a] = cancers[i]
  lst_pmids[a] = paste(lst_articles_entitie, collapse = ',')
  cat('\n Nome = ',cancers[i])
}
# Preparing dataframe with pubmed abstracts indexed for cancers entities
df_cancers_individual_indexation = data.frame(cancer = unlist(lst_cancer_names), id_term = unlist(lst_cancers), total_ocorrence = unlist(lst_total_ocorrence), unique_ocorrence = unlist(lst_unique_ocorrences), pmids = unlist(lst_pmids), stringsAsFactors = FALSE)
df_cancers_individual_indexation = df_cancers_individual_indexation[order(-df_cancers_individual_indexation$unique_ocorrence),]
df_cancers_individual_indexation$ration = df_cancers_individual_indexation$unique_ocorrence / df_cancers_individual_indexation$total_ocorrence
df_cancers_individual_indexation = df_cancers_individual_indexation[-1,]
rownames(df_cancers_individual_indexation) = 1:nrow(df_cancers_individual_indexation)

####################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about Entrez genes entities
drv = dbDriver("SQLite")
con = dbConnect(drv,dbname="db_total_project.db")
sql_articles <- str_c("SELECT * FROM gene_terms",sep="")	
cat('\n = ',sql_articles)
res_articles <- dbSendQuery(con, sql_articles)
df_gene_terms <- fetch(res_articles, n = -1)
dbDisconnect(con)
genes = unique(df_entities_index_gene$term_id)
a = 0
lst_total_ocorrence = list()
lst_articles_entitie = list()
lst_unique_ocorrences = list()
lst_gene_names = list()
lst_genes = list()
lst_pmids = list()
for(i in 1:length(genes)){
  lst_articles_entitie = df_entities_index_gene[df_entities_index_gene$term_id == genes[i],]
  lst_articles_entitie = lst_articles_entitie$entity_pmid
  a = a + 1
  lst_total_ocorrence[a] = length(lst_articles_entitie)
  lst_articles_entitie = unique(lst_articles_entitie)
  lst_unique_ocorrences[a] = length(lst_articles_entitie)
  lst_gene_names[a] = df_gene_terms[df_gene_terms$idterm_descritor == genes[i],][2]
  lst_genes[a] = genes[i]
  lst_pmids[a] = paste(lst_articles_entitie, collapse = ',')
  cat('\n Nome = ',genes[i])
}
# Preparing dataframe with pubmed abstracts indexed for Entrez genes entities
df_index_genes = data.frame(gene = unlist(lst_gene_names), id_term = unlist(lst_genes), total_ocorrence = unlist(lst_total_ocorrence), unique_ocorrence = unlist(lst_unique_ocorrences), pmids = unlist(lst_pmids), stringsAsFactors = FALSE)
df_index_genes = df_index_genes[order(-df_index_genes$unique_ocorrence),]
df_index_genes$ration = df_index_genes$unique_ocorrence / df_index_genes$total_ocorrence
rownames(df_index_genes) = 1:nrow(df_index_genes)

####################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about HGNC genes entities
genes = unique(df_entities_index_gene_hgnc$term_id)
gene_names = unique(df_entities_index_gene_hgnc$db_term)
a = 0
lst_total_ocorrence = list()
lst_articles_entitie = list()
lst_unique_ocorrences = list()
lst_gene_names = list()
lst_genes = list()
lst_pmids = list()
for(i in 1:length(genes)){
  lst_articles_entitie = df_entities_index_gene_hgnc[df_entities_index_gene_hgnc$term_id == genes[i],]
  lst_articles_entitie = lst_articles_entitie$entity_pmid
  a = a + 1
  lst_total_ocorrence[a] = length(lst_articles_entitie)
  lst_articles_entitie = unique(lst_articles_entitie)
  lst_unique_ocorrences[a] = length(lst_articles_entitie)
  lst_gene_names[a] = gene_names[i]
  lst_genes[a] = genes[i]
  lst_pmids[a] = paste(lst_articles_entitie, collapse = ',')
  cat('\n Nome = ',genes[i])
}
# Preparing dataframe with pubmed abstracts indexed for HGNC genes entities
df_index_genes_hgnc = data.frame(gene = unlist(lst_gene_names), id_term = unlist(lst_genes), total_ocorrence = unlist(lst_total_ocorrence), unique_ocorrence = unlist(lst_unique_ocorrences), pmids = unlist(lst_pmids), stringsAsFactors = FALSE)
df_index_genes_hgnc = df_index_genes_hgnc[order(-df_index_genes_hgnc$unique_ocorrence),]
df_index_genes_hgnc$ration = df_index_genes_hgnc$unique_ocorrence / df_index_genes_hgnc$total_ocorrence
rownames(df_index_genes_hgnc) = 1:nrow(df_index_genes_hgnc)

###################################################################################
# Crossing dataframes with pubmed abstracts indexed for Entrez genes and HGNC genes entities
# Final processing and indexation of pubmed abstracts with extracted information about genes entities
lst_genes = list()
lst_id_term = list()
lst_id_term_hgnc = list()
lst_total_ocorrence = list()
lst_unique_ocorrences = list()
lst_pmids = list()
c = 1
erro = 0
for(i in 1:nrow(df_index_genes_hgnc)){
  if(df_index_genes_hgnc$gene[i] %in% df_index_genes$gene){
    for(x in 1:nrow(df_index_genes)){
      if(df_index_genes_hgnc$gene[i] == df_index_genes$gene[x]){
        lst_genes[c] = df_index_genes_hgnc$gene[i]
        lst_id_term_hgnc[c] = df_index_genes_hgnc$id_term[i]
        lst_id_term[c] = df_index_genes$id_term[x]
        #lst_pmids[c] = unique
        lst_pmids[c] = toString(unique(unlist(list(unlist(str_split(df_index_genes$pmids[x], ',')),unlist(str_split(df_index_genes_hgnc$pmids[i], ','))))))
        lst_total_ocorrence[c] = df_index_genes_hgnc$total_ocorrence[i] + df_index_genes$total_ocorrence[x]
        lst_unique_ocorrences[c] = length(unique(unlist(strsplit(unlist(str_c(df_index_genes_hgnc$pmids[i],",",df_index_genes$pmids[x])), ','))))
        c = c+1
        cat('\n C = ',c)
      }else{
        erro = erro + 1
      }
    }
  }else{
    lst_genes[c] = df_index_genes_hgnc$gene[i]
    lst_id_term_hgnc[c] = df_index_genes_hgnc$id_term[i]
    lst_id_term[c] = '-'
    lst_pmids[c] = unlist(df_index_genes_hgnc$pmids[i])
    lst_total_ocorrence[c] = df_index_genes_hgnc$total_ocorrence[i]
    lst_unique_ocorrences[c] = df_index_genes_hgnc$unique_ocorrence[i]
    c = c+1
    cat('\n C = ',c)
  }
}
# Preparing final dataframe with pubmed abstracts indexed for genes entities
df_genes_individual_indexation = data.frame(genes = unlist(lst_genes), id_term_hgnc = unlist(lst_id_term_hgnc), id_term = unlist(lst_id_term), total_ocorrence = unlist(lst_total_ocorrence), unique_ocorrence = unlist(lst_unique_ocorrences), pmids = unlist(lst_pmids), stringsAsFactors = FALSE)
df_genes_individual_indexation = df_genes_individual_indexation[order(-df_genes_individual_indexation$unique_ocorrence),]
df_genes_individual_indexation$ration = df_genes_individual_indexation$unique_ocorrence / df_genes_individual_indexation$total_ocorrence
rownames(df_genes_individual_indexation) = 1:nrow(df_genes_individual_indexation)



####################################################################################################
#                              RESULTS OF INDIVIDUAL INDEXATION
####################################################################################################


# individual-polyphenols-indexation is the file with 
# Number of unique indexations for polyphenols
nrow(df_polyphenol_individual_indexation)
# Final dataframe with pubmed abstracts indexed for polyphenols entities
View(df_polyphenol_individual_indexation)

# Number of unique indexations for cancers 
nrow(df_cancers_individual_indexation)
# Final dataframe with pubmed abstracts indexed for polyphenols entities
View(df_cancers_individual_indexation)

# Number of unique indexations for genes
nrow(df_genes_individual_indexation)
# Final dataframe with pubmed abstracts indexed for total of genes entities
View(df_genes_individual_indexation)




####################################################################################################
####################################################################################################
#               START OF CROSS INDEXATION FOR POLYPHENOL-CANCER ASSOCIATIONS
####################################################################################################
####################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about polyphenols-cancer 
# entities associations
df_index_p = df_polyphenol_individual_indexation
lst_polifenol = list()
lst_cancer = list()
lst_id_polifenol = list()
lst_id_cancer = list()
lst_quant = list()
lst_pmid = list()
c = 0
for(i in 1:nrow(df_index_p)){
  id_polifenol = df_index_p$id_term[i];
  for(x in 1:nrow(df_cancers_individual_indexation)){
    id_cancer = df_cancers_individual_indexation$id_term[x];
    polyphenols_articles = unlist(strsplit(df_index_p[df_index_p$id_term == id_polifenol,]$pmids,','))
    cancers_articles = unlist(strsplit(df_cancers_individual_indexation[df_cancers_individual_indexation$id_term == id_cancer,]$pmids,',')) 
    polyphenols_articles = unlist(polyphenols_articles)
    cancers_articles = unlist(cancers_articles)
    # Intersecting pubmed abstracts with the same entities about the polyphenol and cancer
    articles_intersect = intersect(polyphenols_articles, cancers_articles)
    if(length(articles_intersect) > 0){
      cat('\n\n Cancer = ',df_cancers_individual_indexation$cancer[x])
      cat('\n Polifenol = ',df_index_p$poliphenol[i])
      lst_polifenol[c] = df_index_p$poliphenol[i]
      lst_id_polifenol[c] = df_index_p$id_term[i]
      lst_cancer[c] = df_cancers_individual_indexation$cancer[x]
      lst_id_cancer[c] = df_cancers_individual_indexation$id_term[x]
      lst_quant[c] = length(articles_intersect);
      articles_intersect = paste0(unlist(strsplit(articles_intersect, " ")), collapse = ',') 
      lst_pmid[c] = articles_intersect
      cat('\n Artigos = ',articles_intersect)
      c = c + 1
    }
  }
}
# Preparing final dataframe with pubmed abstracts indexed for polyphenol-cancer entities associations
df_cross_indexation_polyphenol_cancer_association = data.frame(id_polifenol = unlist(lst_id_polifenol), polifenol = unlist(lst_polifenol), id_cancer = unlist(lst_id_cancer), cancer = unlist(lst_cancer), quant = unlist(lst_quant), pmids = unlist(lst_pmid), stringsAsFactors = FALSE)
# Preparing final dataframe with frequency of cancers indexed for each polyphenol
df_cross_indexation_polyphenol_cancer_association_frequency = as.data.frame(table(df_cross_indexation_polyphenol_cancer_association[,c(2)]))
df_cross_indexation_polyphenol_cancer_association_frequency = df_cross_indexation_polyphenol_cancer_association_frequency[order(-df_cross_indexation_polyphenol_cancer_association_frequency$Freq),]
rownames(df_cross_indexation_polyphenol_cancer_association_frequency) = c(1:nrow(df_cross_indexation_polyphenol_cancer_association_frequency))

#################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about cancer-polyphenols
# entities associations
df_index_p = df_cancers_individual_indexation
lst_polifenol = list()
lst_cancer = list()
lst_id_polifenol = list()
lst_id_cancer = list()
lst_quant = list()
lst_pmid = list()
c = 0
for(x in 1:nrow(df_index_p)){
  id_cancer = df_index_p$id_term[x];
  for(i in 1:nrow(df_polyphenol_individual_indexation)){
    id_polifenol = df_polyphenol_individual_indexation$id_term[i];
    polyphenols_articles = unlist(strsplit(df_polyphenol_individual_indexation[df_polyphenol_individual_indexation$id_term == id_polifenol,]$pmids,','))
    cancers_articles = unlist(strsplit(df_index_p[df_index_p$id_term == id_cancer,]$pmids,',')) 
    polyphenols_articles = unlist(polyphenols_articles)
    cancers_articles = unlist(cancers_articles)
    # Intersecting pubmed abstracts with the same entities about the polyphenol and cancer
    articles_intersect = intersect(polyphenols_articles, cancers_articles)
    if(length(articles_intersect) > 0){
      cat('\n\n Cancer = ',df_index_p$cancer[x])
      cat('\n Polifenol = ',df_polyphenol_individual_indexation$poliphenol[i])
      lst_polifenol[c] = df_polyphenol_individual_indexation$poliphenol[i]
      lst_id_polifenol[c] = df_polyphenol_individual_indexation$id_term[i]
      lst_cancer[c] = df_index_p$cancer[x]
      lst_id_cancer[c] = df_index_p$id_term[x]
      lst_quant[c] = length(articles_intersect);
      articles_intersect = paste0(unlist(strsplit(articles_intersect, " ")), collapse = ',') 
      lst_pmid[c] = articles_intersect
      cat('\n Artigos = ',articles_intersect)
      c = c + 1
    }
  }
}
df_cross_indexation_cancer_polyphenol_association = data.frame(id_polifenol = unlist(lst_id_polifenol), polifenol = unlist(lst_polifenol), id_cancer = unlist(lst_id_cancer), cancer = unlist(lst_cancer), quant = unlist(lst_quant), pmids = unlist(lst_pmid), stringsAsFactors = FALSE)
# Preparing final dataframe with frequency of polyphenols indexed for each cancer
df_cross_indexation_cancer_polyphenol_association_frequency = as.data.frame(table(df_cross_indexation_cancer_polyphenol_association[,c(4)]))
df_cross_indexation_cancer_polyphenol_association_frequency = df_cross_indexation_cancer_polyphenol_association_frequency[order(-df_cross_indexation_cancer_polyphenol_association_frequency$Freq),]
rownames(df_cross_indexation_cancer_polyphenol_association_frequency) = c(1:nrow(df_cross_indexation_cancer_polyphenol_association_frequency))


####################################################################################################
#               START OF CROSS INDEXATION FOR POLYPHENOL-GENE ASSOCIATIONS
####################################################################################################
# Processing and indexation of pubmed abstracts with extracted information about polyphenol-gene
# entities associations
df_index_p = df_genes_individual_indexation
lst_polifenol = list()
lst_cancer = list()
lst_id_polifenol = list()
lst_id_cancer = list()
lst_quant = list()
lst_pmid = list()
c = 0
for(x in 1:nrow(df_index_p)){
  id_gene = df_index_p$id_term_hgnc[x];
  for(i in 1:nrow(df_polyphenol_individual_indexation)){
    id_polifenol = df_polyphenol_individual_indexation$id_term[i];
    polyphenols_articles = unlist(strsplit(df_polyphenol_individual_indexation[df_polyphenol_individual_indexation$id_term == id_polifenol,]$pmids,','))
    cancers_articles = unlist(strsplit(df_index_p[df_index_p$id_term_hgnc == id_gene,]$pmids,',')) 
    polyphenols_articles = unlist(polyphenols_articles)
    cancers_articles = unlist(cancers_articles)
    # Intersecting pubmed abstracts with the same entities about the polyphenol and gene
    articles_intersect = intersect(polyphenols_articles, cancers_articles)
    if(length(articles_intersect) > 0){
      cat('\n\n Gene = ',df_index_p$genes[x])
      cat('\n Polifenol = ',df_polyphenol_individual_indexation$poliphenol[i])
      lst_polifenol[c] = df_polyphenol_individual_indexation$poliphenol[i]
      lst_id_polifenol[c] = df_polyphenol_individual_indexation$id_term[i]
      lst_cancer[c] = df_index_p$genes[x]
      lst_id_cancer[c] = df_index_p$id_term_hgnc[x]
      lst_quant[c] = length(articles_intersect);
      articles_intersect = paste0(unlist(strsplit(articles_intersect, " ")), collapse = ',') 
      lst_pmid[c] = articles_intersect
      cat('\n Artigos = ',articles_intersect)
      c = c + 1
    }
  }
}
# Preparing final dataframe with pubmed abstracts indexed for polyphenol-gene entities associations
df_cross_indexation_gene_polyphenol_association = data.frame(id_polifenol = unlist(lst_id_polifenol), polifenol = unlist(lst_polifenol), id_gene = unlist(lst_id_cancer), gene = unlist(lst_cancer), quant = unlist(lst_quant), pmids = unlist(lst_pmid), stringsAsFactors = FALSE)
df_cross_indexation_gene_polyphenol_association = df_cross_indexation_gene_polyphenol_association[order(as.character(df_cross_indexation_gene_polyphenol_association$polifenol)),]
# Preparing final dataframe with frequency of genes indexed for each polyphenol
df_cross_indexation_gene_polyphenol_association_frequency = as.data.frame(table(df_cross_indexation_gene_polyphenol_association[,c(4)]))
df_cross_indexation_gene_polyphenol_association_frequency = df_cross_indexation_gene_polyphenol_association_frequency[order(-df_cross_indexation_gene_polyphenol_association_frequency$Freq),]
rownames(df_cross_indexation_gene_polyphenol_association_frequency) = c(1:nrow(df_cross_indexation_gene_polyphenol_association_frequency))



####################################################################################################
#                              RESULTS OF CROSS INDEXATION
####################################################################################################

# Number of polyphenol-cancer entities associations indexed
nrow(df_cross_indexation_polyphenol_cancer_association)
# Final dataframe with pubmed abstracts indexed for polyphenol-cancer entities associations
View(df_cross_indexation_polyphenol_cancer_association)
# Dataframe with total of cancers indexed for each polyphenol
View(df_cross_indexation_polyphenol_cancer_association_frequency)
# Summary of Dataframe with total of cancers indexed for each polyphenol
summary(df_cross_indexation_polyphenol_cancer_association_frequency)
quantile(df_cross_indexation_polyphenol_cancer_association_frequency$Freq, probs = seq(0, 1, 0.05))
# Dataframe with total of polyphenols indexed for each cancer
View(df_cross_indexation_cancer_polyphenol_association_frequency)
# Summary of Dataframe with total of polyphenols indexed for each cancer
summary(df_cross_indexation_cancer_polyphenol_association_frequency)
quantile(df_cross_indexation_cancer_polyphenol_association_frequency$Freq, probs = seq(0, 1, 0.05))


# Number of polyphenol-gene entities associations indexed
nrow(df_cross_indexation_gene_polyphenol_association)
# Final dataframe with pubmed abstracts indexed for polyphenol-gene entities associations
View(df_cross_indexation_gene_polyphenol_association)
# Dataframe with total of polyphenols indexed for each gene
View(df_cross_indexation_gene_polyphenol_association_frequency)
# Summary of Dataframe with total of polyphenols indexed for each gene
summary(df_cross_indexation_gene_polyphenol_association_frequency)
quantile(df_cross_indexation_gene_polyphenol_association_frequency$Freq, probs = seq(0, 1, 0.05))

