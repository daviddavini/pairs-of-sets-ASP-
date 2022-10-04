for file in solutions/*.txt; do
    [[ $(grep -c -e "^0 1" $file) -eq 0 ]] && echo "Pattern not found in $file"
done
