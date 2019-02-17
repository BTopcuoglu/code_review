
count="$(ls -1 data/temp/ | wc -l)"
while [ $count != 600 ]; do sleep 1m; done
