n=1

while true; do
    if [ ! -f "solutions/solutions_$n.txt" ]; then
        echo "Running for n=$n"
        ./runner.sh $n
    fi
    n=$((n + 1))
done
