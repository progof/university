> results.txt  # Очистка файла
for n in $(seq 10 100 1000); do
    ./main $n >> results.txt
done
