<h1>Indexing of Extracted Information</h1>

<p>This repository contains files and information about <strong> step 3 of Kaphta Architecture: Indexing of Extracted Information</strong>. In this stage, PubMed abstracts  with extracted information (<a href='https://github.com/ramongsilva/Information-extraction-from-pubmed-abstracts-sentences-on-polyphenols-anticancer-activity'>Information Extraction step</a>) are indexed. There are 2 indexations, using the R language: Individual and Cross indexations. The individual indexations are for entities about polyphenols, cancer and genes, and the cross indexations are for polyphenol-cancer and polyphenol-gene entity associations. The following are listed the files and results of this stage.
  </p>

<h2>Individual and Cross indexations</h2>
<ul>
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/indexing-information-extracted-gh.R'>indexing-information-extracted-gh.R</a>: R script for individual and cross indexation of extracted information from PubMed abstracts about polyphenols anticancer activity, using the inverted index.</li>  
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/functions.R'>functions.R</a>: script with auxiliary functions. Save this file in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script.</li>
<li><a href='https://drive.google.com/file/d/1lQRdff2YpagowcLcdVSF5z2AO5tdwOIS/view?usp=sharing' target='_blank'>db_total_project.db</a>:  SQLite Database needed to execute all R scripts of kaphta architecture steps. This database contains tables with the<strong> Entity dictionary, Total PubMed abstracts textual corpus, and Pubmed abstracts classified as positive in text classification</strong>. Save this file in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script.</li>
  
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/tree/main/entities-recognized'>entities-recognized</a>: folder with files resulted of NER task, containing extracted information about named entities (polyphenols, cancers and genes) recognized on PubMed abstracts  in the previous stage (<a href='https://github.com/ramongsilva/Information-extraction-from-pubmed-abstracts-sentences-on-polyphenols-anticancer-activity'>Information Extraction step</a>). Save this folder with the files in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script, on the indexation task.</li>  
    <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/Rule_associations_recognized.rar'>Rule_associations_recognized.rar</a>: compacted file resulted of AR task in the previous stage (<a href='https://github.com/ramongsilva/Information-extraction-from-pubmed-abstracts-sentences-on-polyphenols-anticancer-activity'>Information Extraction step</a>), containing the PubMed abstract sentences with at least one rule from rules dictionary recognized. Save this file in the same folder of indexing-information-extracted-gh.R script, because it is needed to execute this script, on indexation tasks.</li>
  
  
</ul>



<h2>Results</h2>
<p>Bellow are presented files from the <a href='https://github.com/ramongsilva/Indexing-of-extracted-information/tree/main/results'>results folder</a>, with the results for individual and cross indexation of PubMed abstracts.</p>
<h3>Individual indexation</h3>
<ul>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_polyphenol_individual_indexation.tsv'>df_polyphenol_individual_indexation.tsv</a>: tsv file containing data frame with indexed PubMed abstracts for <strong> polyphenol entities </strong>.</li>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cancers_individual_indexation.tsv'>df_cancers_individual_indexation.tsv</a>: tsv file containing data frame with indexed PubMed abstracts for <strong> cancer entities </strong>.</li>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_genes_individual_indexation.tsv'>df_genes_individual_indexation.tsv</a>: tsv file containing data frame with indexed PubMed abstracts for <strong> gene entities </strong>.</li>
</ul>
<h3>Cross indexation</h3>
<ul>
   <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_polyphenol_cancer_association.tsv'>df_cross_indexation_polyphenol_cancer_association.tsv</a>: tsv file containing dataframe with indexed PubMed abstracts for <strong> polyphenol-cancer entity associations </strong>.</li>
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_cancer_polyphenol_association.tsv'>df_cross_indexation_cancer_polyphenol_association.tsv</a>: tsv file containing dataframe with indexed PubMed abstracts for <strong> cancer-polyphenol entity associations </strong>.</li>
    <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_gene_polyphenol_association.tsv'>df_cross_indexation_gene_polyphenol_association.tsv</a>: tsv file containing dataframe with indexed PubMed abstracts for <strong> gene-polyphenol entity associations </strong>.</li>
 <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_polyphenol_cancer_association_frequency.tsv'>df_cross_indexation_polyphenol_cancer_association_frequency.tsv</a>: tsv file containing dataframe with <strong> total of cancers indexed for each polyphenol</strong>.</li>
 <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_cancer_polyphenol_association_frequency.tsv'>df_cross_indexation_cancer_polyphenol_association_frequency.tsv</a>: tsv file containing dataframe with <strong> total of polyphenols indexed for each cancer</strong>.</li>
 <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/results/df_cross_indexation_gene_polyphenol_association_frequency.tsv'>df_cross_indexation_gene_polyphenol_association_frequency.tsv</a>: tsv file containing dataframe with <strong> total of polyphenols indexed for each gene</strong>.</li>
</ul>





