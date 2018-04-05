#!/bin/bash

files="tests/test-helloworld-*.xpp"

TOPLEVEL="./toplevel.native"

Check() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`
    reffile=`echo $1 | sed 's/.xpp$//'`
    basedir="`echo $1 | sed 's/\/[^\/]*$//'`/."

    echo "Testing ${basename}..."

    $TOPLEVEL -l $1 > ${reffile}.ll
    /usr/local/Cellar/llvm/6.0.0/bin/clang -Wall ${reffile}.ll -o ${reffile}
    ./${reffile} > ${basename}.out 

    if diff -bB ${basename}.out ${reffile}.out > ${basename}.diff
    then
        echo "Test passed."
    else
        echo "Test failed."
        diff -bB ${basename}.out ${reffile}.out
    fi
    rm -f ${reffile}.ll ${reffile} ${basename}.out ${basename}.diff
}

for file in $files
do
    case $file in
        *test-helloworld-*)
            Check $file
            ;;
        *)
            echo "unknown file type $file"
            ;;
    esac
done
