
count="$(ls -1 data/temp/ | wc -l)"
while [ $count != 200 ]; do sleep 1; done
