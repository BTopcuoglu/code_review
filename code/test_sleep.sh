
count="$(ls -1 data/temp/ | wc -l)"

while :; do
    clear;
    if echo $count = 600; then
        break
    fi;
    sleep 1;
done
