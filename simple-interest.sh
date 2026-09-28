#!/bin/bash
# ==========================================================
# Simple Interest Calculator in Bash
# Formula: Simple Interest = (Principal * Rate * Time) / 100
# ==========================================================

echo "========================================="
echo "        Simple Interest Calculator       "
echo "========================================="

# 1. Take user input
echo "Enter the principal:"
read p
echo "Enter rate of interest per year:"
read r
echo "Enter time period in years:"
read t

# 2. Input validation: check for valid positive numbers
number_regex='^[0-9]+(\.[0-9]+)?$'
if ! [[ "$p" =~ $number_regex ]] || \
   ! [[ "$r" =~ $number_regex ]] || \
   ! [[ "$t" =~ $number_regex ]]; then
    echo "Error: Invalid input. Please enter positive numbers only."
    exit 1
fi

# 3. Calculate Simple Interest using bc (with integer fallback)
if command -v bc >/dev/null 2>&1; then
    s=$(echo "scale=2; ($p * $r * $t) / 100" | bc)
    total=$(echo "scale=2; $p + $s" | bc)
else
    p_int=${p%.*}
    r_int=${r%.*}
    t_int=${t%.*}
    s=$(( (p_int * r_int * t_int) / 100 ))
    total=$(( p_int + s ))
fi

# 4. Display results
echo "-----------------------------------------"
echo "The simple interest is: $s"
echo "The total amount is: $total"
echo "========================================="
