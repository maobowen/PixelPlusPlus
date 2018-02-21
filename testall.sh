#!/bin/bash

files="tests/test-*.xpp tests/fail-*.xpp"

TOPLEVEL="./toplevel.native"

Check() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`
    reffile=`echo $1 | sed 's/.xpp$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo "Testing ${basename}..."

    $TOPLEVEL $1 > ${basename}.out

    if diff -bB ${basename}.out ${reffile}.out > ${basename}.diff
    then
        echo "test succeeded"
    else
        echo "test failed"
    fi
    rm -f ${basename}.out ${basename}.diff
}

CheckFail() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`
    reffile=`echo $1 | sed 's/.xpp$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo "Testing ${basename}..."

    $TOPLEVEL $1 2> ${basename}.err

    if diff -bB ${basename}.err ${reffile}.err > ${basename}.diff
    then
        echo "test succeeded"
    else
        echo "test failed"
    fi  
    rm -f ${basename}.err ${basename}.diff
}

for file in $files
do
    case $file in
        *test-*)
            Check $file
            ;;
        *fail-*)
            CheckFail $file
            ;;
        *)
            echo "unknown file type $file"
            ;;
    esac
done
