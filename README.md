### Overview

	project
	|- README         		# the top level description of content (this doc)
	|- CONTRIBUTING    		# instructions for how to contribute to your project
	|- LICENSE         		# the license for this project
	|
	|- data/           		# Primary data, are not changed once created
	| |- temp/     			# For 7 models, each data-split .csv file generated from .pbs files saved here
	| |- process/     		# Concatenated .csv files that have outputs of 7 models saved here
	| |- baxter.0.03.subsample.shared      	# subsampled mothur generated file with OTUs from Marc Sze's analysis
	| |- metadata.tsv     		        # metadata with clinical information from Marc Sze's analysis 		
	|- code/          			# any programmatic code
	| |- learning/    			# generalization performance of model
	| |- testing/     			# building final model
	|
	|- results/        			# all output from workflows and analyses
	| |- tables/      			# tables and .Rmd code of the tables to be rendered with kable in R
	| |- figures/     			# graphs, likely designated for manuscript figures
	|
	|- Makefile	 # Reproduce model pipeline and figures



### How to regenerate Figure 1 where we look at 2 model performances (Linear L1 and L2 SVM) to predict CRC in Baxter dataset.

#### Dependencies and locations for R code
* R version 3.5.0 
* Caret package is used as the wrapper for all models.
	- Before running on FLUX, make sure to load module r-biomed-libs/3.5.0 which has caret loaded already.
	- Caret download takes long.
* Run from project directory on HPC.
* The files mentioned above at process/ from Marc Sze's analysis: https://github.com/SchlossLab/Sze_CRCMetaAnalysis_mBio_2018

#### Run the following code to clone git repository.
```
git clone https://github.com/BTopcuoglu/code_review
```

#### The Makefile will reproduce Figure 1.
```
qsub make_target.pbs
```


