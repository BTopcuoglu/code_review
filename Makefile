REFS = data/references
FIGS = results/figures
TABLES = results/tables
PROC = data/process
FINAL = submission/
CODE = code/learning

print-%:
	@echo '$*=$($*)'

################################################################################
#
# Part 1: Retrieve the subsampled shared file and metadata files that Marc Sze
# published in https://github.com/SchlossLab/Sze_CRCMetaAnalysis_mBio_2018
#
#	Copy from Github
#
################################################################################

data/baxter.0.03.subsample.shared\
data/metadata.tsv	:	code/learning/load_datasets.batch
	bash code/learning/load_datasets.batch

################################################################################
#
# Part 2: Model analysis in R
#
#	Run scripts to perform all the models on the dataset and generate AUC values
#
################################################################################


$(PROC)/best_hp_results_L2_Logistic_Regression_%.csv	:	data/baxter.0.03.subsample.shared\
														data/metadata.tsv\
														$(CODE)/generateAUCs.R\
														$(CODE)/model_pipeline.R\
														$(CODE)/model_interpret.R\
														$(CODE)/main.R\
														$(CODE)/model_selection.R
			Rscript code/learning/main.R $* "L2_Logistic_Regression"


$(PROC)/best_hp_results_L2_Linear_SVM_%.csv	:	data/baxter.0.03.subsample.shared\
														data/metadata.tsv\
														$(CODE)/generateAUCs.R\
														$(CODE)/model_pipeline.R\
														$(CODE)/model_interpret.R\
														$(CODE)/main.R\
														$(CODE)/model_selection.R
			Rscript code/learning/main.R $* "L2_Linear_SVM"



SEEDS=$(shell seq 0 99)

L2_LOGISTIC_REGRESSION_REPS=$(foreach S,$(SEEDS),$(PROC)/best_hp_results_L2_Logistic_Regression_$(S).csv)

L2_LINEAR_SVM_REPS=$(foreach S,$(SEEDS),$(PROC)/best_hp_results_L2_Linear_SVM_$(S).csv)


# the following two rules would work. you could simplify them down to a single rule, if you used
# file names that were easier to parse. for example, i created directories that were like called
# something like l2_logistic_regression. Then all the files in there would be input to the cat
# function. that type of structure change would require changing the rules up above. take a look at
# what i've already changed and then i'd be happy to work with you on another refactoring
# iteration. i think this might be relevant if only becuase you're going to have a bunch of
# modeling methods and it seems slightly silly to have an equal number of rules that all do the
# same thing. not exactly dry...
$(PROC)/combined_all_imp_features_results_L2_Logistic_Regression.csv\
$(PROC)/combined_all_hp_results_L2_Logistic_Regression.csv\
$(PROC)/combined_best_hp_results_L2_Logistic_Regression.csv :  $(L2_LOGISTIC_REGRESSION_REPS) code/cat_csv_files.sh
	bash code/cat_csv_files.sh

$(PROC)/combined_all_imp_features_results_L2_Linear_SVM.csv\
$(PROC)/combined_all_hp_results_L2_Linear_SVM.csv\
$(PROC)/combined_best_hp_results_L2_Linear_SVM.csv : $(L2_LINEAR_SVM_REPS) code/cat_csv_files.sh
	bash code/cat_csv_files.sh





################################################################################
#
# Part 3: Figure and table generation
#
#	Run scripts to generate figures and tables
#
################################################################################

# Figure 1 shows the generalization performance of all the models tested.
$(FIGS)/Figure_1.pdf :	$(CODE)/functions.R\
						$(CODE)/Figure1.R\
						$(PROC)/combined_best_hp_results_L2_Logistic_Regression.csv\
						$(PROC)/combined_best_hp_results_L2_Linear_SVM.csv
	Rscript $(CODE)/Figure1.R
