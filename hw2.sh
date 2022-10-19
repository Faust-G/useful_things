
mkdir -p  "./datasets/txt/" "./datasets/csv/"

d_csv=$(pwd)/datasets/csv

cd "./datasets/txt/"
echo "import sys" > to_csv.py
echo "from libsvm2csv import convert" >> to_csv.py
echo "convert(f'a{sys.argv[1]}a', sys.argv[2] + ' ' + sys.argv[3])" >> to_csv.py

process(){
    echo "a$1a is downloading"
    wget -q https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/a$1a
    echo "a$1a downloaded and now is reading"
    python3 to_csv.py $1 $d_csv/a$1a.csv
    echo "a$1a is read"
}

for i in $(seq 1 9)
do
    process $i &
done

wait
rm to_csv.py
echo "all files downloaded"

