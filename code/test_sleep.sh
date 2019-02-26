while :; do
    count="$(ls -1 data/temp/ | wc -l)"
    echo "$count";
    if [ "$count" == 31 ]; then
        break
    fi;
    sleep 5s;
done
