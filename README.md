<h1>Indexing of extracted information</h1>

<p>This repository contains all files used in the task of indexation of extracted information of pubmed abstracts sentences about the anti-cancer activity of polyphenols, using the R language.  The files are organized in Individual and Cross indexations, and Results.</p>

<h2>Individual and Cross indexations</h2>
<ul>
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/indexing-information-extracted-gh.R'>indexing-information-extracted-gh.R</a>: R script for individual and cross indexation of extracted information from pubmed abstracts about polyphenols anticancer activity, using inverted index.</li>  
  <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/functions.R'>functions.R</a>: R script with auxiliar functions needed to execute the indexing-information-extracted-gh.R script.</li>
   <li><a href='https://drive.google.com/file/d/1ZxQOrWO0SXXDvnnz4yIwlIhWNvw_uDVH/view'>db_total_project.db</a>:  SQLite Database needed to execute the indexing-information-extracted-gh.R script</li>  
      <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/tree/main/entities-recognized'>entities-recognized</a>: folder with files resulted of NER task in information extraction with the <strong>named entities (polyphenols, cancers and genes) recognized on pubmed abstracts </strong> about polyphenols anticancer activity. These files are needed to execute the indexing-information-extracted-gh.R script.</li>  
      <li><a href='https://github.com/ramongsilva/Indexing-of-extracted-information/blob/main/Rule_associations_recognized.rar'>Rule_associations_recognized.rar</a>: compacted file with the pubmed abstract sentences about polyphenol anticancer activity,  with at least one rule from rules dictionary recognized. This file is needed to execute the indexing-information-extracted-gh.R script.</li> 
  
</ul>



<h2>Results</h2>
<ul>

   <li><a href='https://github.com/ramongsilva/Information-extraction-from-pubmed-abstracts-sentences-about-polyphenols-anticancer-activity/tree/main/ner-frequency'>ner-frequency</a>: folder with frequency of entities about polyphenols, cancers and/or genes recognized in pubmed abstracts about polyphenol anticancer activity.</li>

</ul>




