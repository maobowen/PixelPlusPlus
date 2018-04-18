#!/bin/bash

basedir="extended_tests"
files="extended-*.xpp"

TOPLEVEL="./toplevel.native"
LLC="llc"
CLANG="clang"

CheckPass() {
    basename=`echo $1 | sed 's/.*\\///
                             s/.xpp//'`
    reffile=`echo $1 | sed 's/.xpp$//'`

    echo "Testing ${basename}..."

    # Build the program
    ../${TOPLEVEL} $1 > ${basename}.ll
    ${LLC} ${basename}.ll > ${basename}.s
    gcc -o ${basename} ${basename}.s builtin.s load.o -lm
    ./${basename} > ${basename}.out

    # Testing

    # Clean up
    rm -f ${basename}.ll ${basename}.s ${basename} ${basename}.out
}

cd ${basedir}
# Build built-in and C libraries
../builtin/${TOPLEVEL} -c2 ../builtin/builtin.xpp > builtin.ll
${LLC} builtin.ll > builtin.s
gcc -std=c99 -c ../load.c
# Start testing
for file in $files
do
    case $file in
        *extended*pos*)
            CheckPass $file
            ;;
        *)
            echo "unknown file type $file"
            ;;
    esac
done
