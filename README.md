<h1>Indexing of Extracted Information</h1>

<p>This repository contains files and information about the <strong> step 3 of Kaphta Architecture: Indexing of Extracted Information</strong>. In this stage, PubMed abstracts  with extracted information (<a href='https://github.com/ramongsilva/Information-extraction-from-pubmed-abstracts-sentences-on-polyphenols-anticancer-activity'>Information Extraction step</a>) are indexed. There are 2 indexations, using the R language: Individual and Cross indexations. The individual indexations are for entities about polyphenols, cancer and genes, and cross indexations are for polyphenol-cancer and polyphenol-gene entity associations. The following are listed the files and results of this stage.
  </p>

<h2>Individual and Cross indexations</h2>
<ul>
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/indexing-information-extracted-gh.R'>indexing-information-extracted-gh.R</a>: R script for individual and cross indexation of extracted information from pubmed abstracts about polyphenols anticancer activity, using inverted index.</li>  
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/functions.R'>functions.R</a>: R script with auxiliar functions needed to execute the indexing-information-extracted-gh.R script.</li>
   <li><a href='https://drive.google.com/file/d/1ZxQOrWO0SXXDvnnz4yIwlIhWNvw_uDVH/view'>db_total_project.db</a>:  SQLite Database needed to execute the indexing-information-extracted-gh.R script</li>  
      <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/tree/main/entities-recognized'>entities-recognized</a>: folder with files resulted of NER task in information extraction with the <strong>named entities (polyphenols, cancers and genes) recognized on pubmed abstracts </strong> about polyphenols anticancer activity. These files are needed to execute the indexing-information-extracted-gh.R script.</li>  
      <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/Rule_associations_recognized.rar'>Rule_associations_recognized.rar</a>: compacted file with the pubmed abstract sentences about polyphenol anticancer activity,  with at least one rule from rules dictionary recognized. This file is needed to execute the indexing-information-extracted-gh.R script.</li> 
  
</ul>



<h2>Results</h2>
<p>Bellow, are presented files from results folder, with the results of individual and cross indexation of pubmed abstracts.</p>
<h3>Individual indexation</h3>
<ul>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_polyphenol_individual_indexation.tsv'>df_polyphenol_individual_indexation.tsv</a>: tsv file containing data frame with indexed pubmed abstracts for <strong> polyphenols entities </strong>.</li>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cancers_individual_indexation.tsv'>df_cancers_individual_indexation.tsv</a>: tsv file containing data frame with indexed pubmed abstracts for <strong> cancers entities </strong>.</li>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_genes_individual_indexation.tsv'>df_genes_individual_indexation.tsv</a>: tsv file containing data frame with indexed pubmed abstracts for <strong> genes entities </strong>.</li>
</ul>
<h3>Cross indexation</h3>
<ul>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_polyphenol_cancer_association.tsv'>df_cross_indexation_polyphenol_cancer_association.tsv</a>: tsv file containing dataframe with indexed pubmed abstracts for <strong> polyphenol-cancer entities associations </strong>.</li>
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_cancer_polyphenol_association.tsv'>df_cross_indexation_cancer_polyphenol_association.tsv</a>: tsv file containing dataframe with indexed pubmed abstracts for <strong> cancer-polyphenol entities associations </strong>.</li>
    <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_gene_polyphenol_association.tsv'>df_cross_indexation_gene_polyphenol_association.tsv</a>: tsv file containing dataframe with indexed pubmed abstracts for <strong> gene-polyphenol entities associations </strong>.</li>

 <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_polyphenol_cancer_association_frequency.tsv'>df_cross_indexation_polyphenol_cancer_association_frequency.tsv</a>: tsv file containing dataframe with <strong> total of cancers indexed for each polyphenol</strong>.</li>
 <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_cancer_polyphenol_association_frequency.tsv'>df_cross_indexation_cancer_polyphenol_association_frequency.tsv</a>: tsv file containing dataframe with <strong> total of polyphenols indexed for each cancer</strong>.</li>
 <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_gene_polyphenol_association_frequency.tsv'>df_cross_indexation_gene_polyphenol_association_frequency.tsv</a>: tsv file containing dataframe with <strong> total of polyphenols indexed for each gene</strong>.</li>
</ul>





