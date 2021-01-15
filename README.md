<h1>Indexing of Extracted Information</h1>

<p>This repository contains files and information about the <strong> step 3 of Kaphta Architecture: Indexing of Extracted Information</strong>. In this stage, PubMed abstracts  with extracted information (<a href='https://github.com/ramongsilva/Information-extraction-from-pubmed-abstracts-sentences-on-polyphenols-anticancer-activity'>Information Extraction step</a>) are indexed. There are 2 indexations, using the R language: Individual and Cross indexations. The individual indexations are for entities about polyphenols, cancer and genes, and the cross indexations are for polyphenol-cancer and polyphenol-gene entity associations. The following are listed the files and results of this stage.
  </p>

<h2>Individual and Cross indexations</h2>
<ul>
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/indexing-information-extracted-gh.R'>indexing-information-extracted-gh.R</a>: R script for individual and cross indexation of extracted information from pubmed abstracts about polyphenols anticancer activity, using inverted index.</li>  
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/functions.R'>functions.R</a>: script with auxiliar functions. Save this file in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script.</li>
<li><a href='https://drive.google.com/file/d/1lQRdff2YpagowcLcdVSF5z2AO5tdwOIS/view?usp=sharing' target='_blank'>db_total_project.db</a>:  SQLite Database needed to execute all R scripts of kaphta architecture steps. This database contains tables with the<strong> Entity dictionary, Total PubMed abstracts textual corpus, and Pubmed abstracts classified as positive in text classification</strong>. Save this file in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script.</li>
  
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/tree/main/entities-recognized'>entities-recognized</a>: folder with files resulted of NER task in information extraction with the <strong>named entities (polyphenols, cancers and genes) recognized on PubMed abstracts classified as positive in the previous stage </strong>(<a href='https://github.com/ramongsilva/Text-classification-of-pubmed-abstracts-on-polyphenols-anticancer-activity'>Text Classification step</a>). Save this folder with the files in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script, on indexation task.</li>  
    <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/Rule_associations_recognized.rar'>Rule_associations_recognized.rar</a>: compacted file resulted of AR task containing the PubMed abstract sentences with at least one rule from rules dictionary recognized. Save this file in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script, on indexation task.</li>
  
  
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





