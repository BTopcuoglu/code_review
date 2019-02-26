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

#### 1. Log-in to your FLUX account and navigate to your TURBO directory.

#### 2. Load your dependencies 
- Load module R version 3.5.0 
```
module load R/3.5.0
```
- We will need ```tidyverse``` and ```caret``` packages to be able to run all the models.

- Load module r-biomed-libs/3.5.0: 
	- We do this because Caret package is used as the wrapper for all models.
	- r-biomed-libs module has Caret downloaded.
	- Native install of Caret takes too long.
```
module load r-biomed-libs/3.5.0
```
	
#### 3. Fork and clone the forked repository.

- On the upper right of this web-page you'll see a fork option. Click and fork this repo to your Github account.
- Now you need a copy locally, so find the “SSH clone URL” in the right hand column and use that to clone locally using a terminal:

```
git clone *fork URL*
```
3.1. We will run everything from project directory on FLUX. Navigate to the forked project directory:

```
cd code_review
```

3.2. You need to set up a new remote that points to the original project so that you can grab any changes and bring them into your local copy.

```
git remote add upstream https://github.com/BTopcuoglu/code_review
```
You now have two remotes for this project on disk:

Origin which points to your GitHub fork of the project. You can read and write to this remote.
Upstream which points to the main project’s GitHub repository. You can only read from this remote.

3.3. Now that you have the source code start by:

```
$ git checkout master
$ git pull upstream master && git push origin master
$ git checkout -b reproduce/test
```

#### 4. Let's see if we can reproduce Figure 1.

```
qsub make_target.pbs
```
#### 5. Successful?
Were you able to generate ```results/figures/Figure_1.pdf```:

If not or if you see something that will make the code better:

1. Make changes as you see fit.
2. Commit your changes.
3. Push the changes by:
```
git push -u origin reproduce/test
```
This will create the branch on your GitHub project. The -u flag links this branch with the remote one, so that in the future, you can simply type git push origin.

Swap back to the browser and navigate to your fork of the project and you’ll see that your new branch is listed at the top with a handy “Compare & pull request” button. Go ahead and press the button! Describe changes and create pull request. 

#### 6. I will review and accept or decline changes.






