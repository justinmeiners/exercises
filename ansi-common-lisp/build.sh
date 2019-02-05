#!/bin/bash

FILE=$1
EXE=$(basename ${FILE} | cut -d. -f1)

echo ${FILE}
echo ${EXE}

sbcl --no-userinit --load ${FILE} --eval "(sb-ext:save-lisp-and-die \"${EXE}\" :toplevel 'main :executable t :compression 9)"
