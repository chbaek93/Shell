#!/bin/sh 


# -- chb@mz.co.kr -- # 

for i in (`ls ./startup_*`); do ./$i && sleep 10; done 

