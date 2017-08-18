#!/bin/bash

./make_nlp.sh DFW-PR-ROLLUP-01 AZ-PR-STANDARD-1 PROD NLP BIG &>dfw-pr-rollup-01.out &
./make_nlp.sh DFW-PR-ROLLUP-02 AZ-PR-STANDARD-2 PROD NLP BIG &>dfw-pr-rollup-02.out &
./make_nlp.sh DFW-PR-ROLLUP-03 AZ-PR-STANDARD-1 PROD NLP BIG &>dfw-pr-rollup-03.out &
./make_nlp.sh DFW-PR-ROLLUP-04 AZ-PR-STANDARD-2 PROD NLP BIG &>dfw-pr-rollup-04.out &


