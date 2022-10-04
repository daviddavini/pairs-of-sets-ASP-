#!/opt/homebrew/bin/bash

n=$1

k=$(clingo core.lp aux.lp find_k.lp --const n=$n |
    grep "Answer: " |
    tail -1 |
    cut -d " " -f 2)

get_set() {
    answer_file=$2
    cat $answer_file |
        # Filter for the "in_set_a" fields (print fields on lines)
        awk -v tag="$1" '{ 
        for (i=1;i<=NF;i++) {
            if ($i ~ tag) { print $i }
        }
        print ""
    }' |
        # Remove the "in_set_a" prefix
        sed 's/.*(\(.*\))/\1/' |
        # Turn lines back into fields
        awk '/./ { printf "%s ",$0 } /^$/ { print "  " }'
}

clingo core.lp aux.lp fixed_k.lp --const n=$n --const k=$((k - 1)) --models 0 |
    # Get the lines after "Answer"
    awk 'f{print;f=0} /Answer: /{f=1}' >answers.txt

# get_set in_set_a answers.txt |
#     sort_fields >answers_A.txt

get_set in_set_b answers.txt >answers_A.txt
get_set in_set_b answers.txt >answers_B.txt
(
    echo "set A    set B"
    paste -d " " -- <(get_set in_set_a answers.txt) <(get_set in_set_b answers.txt) |
        sort -n
) | tee "solutions/solutions_$n.txt.tmp"

mv "solutions/solutions_$n.txt.tmp" "solutions/solutions_$n.txt"
