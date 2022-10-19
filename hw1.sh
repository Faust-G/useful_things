if [ $# -gt 1 ] || [ $# -eq 0 ]
then
    echo "Usage ./hw1.sh MAXPOINTS"
    exit 1
fi
echo "Maximum score $1" 
path_res=$(pwd)/expected.txt
touch result_student.txt
path_sd=$(pwd)/result_student.txt
touch result_diff.txt
path_df=$(pwd)/result_diff.txt
cd students
for f in *
do
    echo "Processing $f ..."
    cd "$f"
    declare -i res=0
    if [ -f "task1.sh" ]
    then
        source task1.sh >  "$path_sd"
        diff --ignore-all-space "$path_res" "$path_sd" > "$path_df"
        while IFS="" read -r i || [ -n "$i" ]
        do
            if [ ${i::1} == ">" ] || [ ${i::1} == "<" ]
            then
                res+=1
            fi
        done < "$path_df"
        if [ $res -eq 0 ]
        then
            echo "$f has correct output"
        else
            echo "$f has incorrect output ($res lines do not match)"
        fi
        declare -i scores=$(($1-5*res)) # work -?
        if [ $scores -lt 0 ]
        then
            scores=0
        fi
        echo "$f has earned a score of $scores / $1"
    else 
       echo "$f did not turn in the assignment"
    fi
    echo -e
    cd ..
done
rm "$path_sd"
rm "$path_df"
