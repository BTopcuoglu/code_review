### Overview

	project
	|- README         		# the top level description of content (this doc)
	|- CONTRIBUTING    		# instructions for how to contribute to your project
	|- LICENSE         		# the license for this project
	|
	|- data/           		# Primary data, are not changed once created
	| |- temp/     			# For 2 models, each data-split .csv file generated from .pbs files saved here(n=600) 
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



### How to regenerate Figure 1
- In Figure 1 we want to plot the generalization and prediction performances of 2 CRC models.
- We are comparing classification methods L2-regularized Logistic Regression and L2-regularized Linear Support Vector Machine.
- The features we use in the classification models are OTU abundances and FIT results.
- The labels we predict are SRN or nomal. (The patient has screen-relevant neoplasias or not.)
	- We get the OTU abundances, FIT results and Colonoscopy diagnosis from Marc's Meta study using the script ```code/learning/load_datasets.batch``` (We will do this with the Makefile so no worries about it now).
- We are expecting to generate a boxplot comparing the cross-validation and testing performances of both models.

#### 1. Log-in to your FLUX account and navigate to your TORQUE directory.

#### 2. Load your dependencies 
- Load module R version 3.5.0 
```
module load R/3.5.0
```

- Load module r-biomed-libs/3.5.0: 
	- We do this because Caret package is used as the wrapper for all models.
	- r-biomed-libs module has Caret downloaded.
	- Native install of Caret takes too long.
```
module load r-biomed-libs/3.5.0
```
	
#### 3. Run the following code to clone git repository.
```
git clone https://github.com/BTopcuoglu/code_review
```
1. We will run everything from project directory on FLUX. Navigate to project directory:

```
cd code_review
```

2. Change the ```#PBS -M begumtop@umich.edu``` part in all the ```.pbs``` files to your own email.

#### 4. The Makefile will reproduce Figure 1.
```
qsub make_target.pbs
```

#### 5. Successful?
If you were able to generate ```results/figures/Figure_1.pdf```:

1. Please first review the Makefile.
2. Then please review the scripts in the code/learning directory.
3. Please also take a look at the .pbs files.



