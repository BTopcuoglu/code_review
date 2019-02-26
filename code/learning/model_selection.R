# Author: Begum Topcuoglu
# Date: 2019-01-14
######################################################################
# Description:
# This function defines:
#     1. Tuning budget as a grid for the classification methods chosen
#     2. Cross-validation method (how many repeats and folds)
#     3. Caret name for the classification method chosen
######################################################################

######################################################################
# Dependencies and Outputs:
#    Filenames to put to function:
#       1. "L2_Logistic_Regression"
#       2. "L2_Linear_SVM"


# Usage:
# Call as source when using the function. The function is:
#   tuning_grid()

# Output:
#  List of:
#     1. Tuning budget as a grid the classification methods chosen
#     2. Cross-validation method
#     3. Caret name for the classification method chosen
######################################################################


######################################################################
#------------------------- DEFINE FUNCTION -------------------#
######################################################################
tuning_grid <- function(model){

#   Cross-validation method
#       5-fold
#       100 internal repeats to pick the best hp
#       Train the model with final hp decision to use model to predict
#       Return 2class summary and save predictions to calculate cvROC
  cv <- trainControl(method="repeatedcv",
                     repeats = 1,
                     number=5,
                     returnResamp="final",
                     classProbs=TRUE,
                     summaryFunction=twoClassSummary,
                     indexFinal=NULL,
                     savePredictions = TRUE)
  # Grid and caret method defined for each classification models
  if(model=="L2_Logistic_Regression") {
    grid <-  expand.grid(cost = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1),
                         loss = "L2_dual",
                         epsilon = 0.1)
    method <- "regLogistic"
  }
  else if (model=="L2_Linear_SVM"){
    grid <- expand.grid(C = c(0.1, 0.12, 0.13, 0.14, 0.15, 0.16, 0.2, 0.3, 1))
    method <- "svmLinear"
  }
  else {
    print("Model not available")
  }
  # Return:
  #     1. the hyper-parameter grid to tune
  #     2. the caret function to train with
  #     3, cv method
  params <- list(grid, method, cv)
  return(params)
}
