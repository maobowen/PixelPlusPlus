#!/bin/bash

basedir="extended_tests"
files="extended-*.xpp"

TOPLEVEL="./toplevel.native"
LLC="llc"
CC="gcc"
CXX="g++"
CFLAGS="-std=c99 -Wall"
CXXFLAGS="-std=c++11 -Wall"
HASH="sha256sum"

CheckPass() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`

    echo "Testing ${basename}..."

    # Build Pixel++ program
    ../${TOPLEVEL} $1 > ${basename}.ll
    ${LLC} ${basename}.ll > ${basename}.s
    ${CC} ${CFLAGS} -o ${basename} ${basename}.s builtin.s load.o -lm
    ./${basename} > ${basename}.xpp.out

    # Testing
    if [[ -f ${basename}.out ]]; then  # If the comparison file exists
        if diff -bB ${basename}.xpp.out ${basename}.out > ${basename}.diff; then
            echo "Positive test passed. The output matches."
        else
            echo "Positive test failed. The output does not match."
            diff -bB ${basename}.xpp.out ${basename}.out
        fi
        # Clean up
        rm -f ${basename}.diff
    else
        # Build verification program
        ${CXX} ${CXXFLAGS} ${basename}-v.cpp -o ${basename}-v
        ./${basename}-v
        # Compare two images
        hash1=`${HASH} ${basename}.png | cut -d\  -f1`
        hash2=`${HASH} ${basename}-v.png | cut -d\  -f1`
        if [ ${hash1} == ${hash2} ]; then
           echo "Positive test passed. Images are identical."
        else
           echo "Positive test failed. Images are different."
           ${HASH} ${basename}.png ${basename}-v.png
        fi
        # Clean up
        rm -f ${basename}-v ${basename}-v.png
    fi

    # Clean up
    rm -f ${basename}.ll ${basename}.s ${basename} ${basename}.xpp.out
}

CheckFail() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`

    echo "Testing ${basename}..."

    # Build Pixel++ program

    ../${TOPLEVEL} $1 2> ${basename}.xpp.err

    if diff -bB ${basename}.xpp.err ${basename}.err > ${basename}.diff; then
        echo "Negative test passed. The expected error messages are generated."
    else
        echo "Negative test failed. The expected error messages are not generated."
    fi  
    rm -f ${basename}.xpp.err ${basename}.diff
}

cd ${basedir}
# Build built-in and C libraries
../builtin/${TOPLEVEL} -c2 ../builtin/builtin.xpp > builtin.ll
${LLC} builtin.ll > builtin.s
${CC} ${CFLAGS} -c ../load.c
# Start testing
for file in $files
do
    case $file in
        *extended*pos*)
            CheckPass $file
            ;;
        *extended*neg*)
            CheckFail $file
            ;;
        *)
            echo "unknown file type $file"
            ;;
    esac
done
