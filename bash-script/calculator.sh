#!/bin/bash
declare -i number1
declare -i number2
declare -i total

echo "What's your favourite number?"
read number1

echo "What number do you really hate?"
read number2

total=$number1*$number2

echo "Aha! They equal $total."

if test $number1 != $number2; then
    echo "Not the same numbers."
else
    echo "The same numbers."
fi

exit 0