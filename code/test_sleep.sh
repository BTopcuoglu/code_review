
count="$(ls -1 data/temp/ | wc -l)"
while [ $count != 100 ]; do sleep 1; done
