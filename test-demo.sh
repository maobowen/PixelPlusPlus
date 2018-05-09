#!/bin/bash

# Author: Bowen (bm2734)

basedir="demo"
files="demo-*.xpp"

TOPLEVEL="./toplevel.native"
LLC="llc"
CC="gcc"
CXX="g++"
CFLAGS="-std=c99 -no-pie -Wall"
CXXFLAGS="-std=c++11 -Wall"
HASH="shasum -a 256"

Check() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`

    echo "Testing ${basename}..."

    # Build Pixel++ program
    ../${TOPLEVEL} $1 > ${basename}.ll
    ${LLC} ${basename}.ll > ${basename}.s
    ${CC} ${CFLAGS} ${basename}.s stdlib.s load.o -lm -o ${basename}
    ./${basename} > ${basename}.xpp.out

    # Build verification program
    ${CXX} ${CXXFLAGS} ${basename}-v.cpp xppstdlib.cpp -o ${basename}-v
    ./${basename}-v

    # Testing
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

    # Clean up
    rm -f ${basename}.ll ${basename}.s ${basename} ${basename}.xpp.out
}

cd ${basedir}
# Build built-in and C libraries
../stdlib/${TOPLEVEL} -c2 ../stdlib/stdlib.xpp > stdlib.ll
${LLC} stdlib.ll > stdlib.s
${CC} ${CFLAGS} -c ../load.c
# Start testing
for file in $files
do
    case $file in
        *demo-*)
            Check $file
            ;;
        *)
            echo "unknown file type $file"
            ;;
    esac
done
