
count="$(ls -1 data/temp/ | wc -l)"

while :; do
    clear;
    if $count = 60; then
        break
    fi;
    sleep 1;
done
