
count="$(ls -1 data/temp/best_hp_results_L1_Linear_SVM_* | wc -l)"
while [ $count != 100 ]; do sleep 1; done
