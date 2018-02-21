#!/bin/bash

files="tests/test-*.xpp"

TOPLEVEL="./top.native"

Check() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`
    reffile=`echo $1 | sed 's/.xpp$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo "Testing ${basename}..."

    $TOPLEVEL < $1 > ${basename}.out

    if diff -bB ${basename}.out ${reffile}.out > ${basename}.diff
    then
        echo "test succeeded"
    else
        echo "test failed"
    fi
    rm -f ${basename}.out ${basename}.diff
}

for file in $files
do
    case $file in
        *test-*)
            Check $file
            ;;
        *fail-*)
            Check $file
            ;;
        *)
            echo "unknown file type $file"
            ;;
    esac
done
