#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On Mar 07, 2018 -- # 

foreach i (`cat dir.txt`)
	echo $i | awk -F"/" '{print $NF}'
end


#!/bin/sh 

for i in `cat dir.txt`;
do
	echo ${i##*/}
done 
