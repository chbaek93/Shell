#!/bin/tcsh

# -- By chb@mz.co.kr -- #
# -- On Feb 12, 2018 -- #
#

set Folders = ( a b c )

foreach i ($Folders)
        mkdir ./$i
        touch ./$i/README
        echo "$i" > ./$i/README
end

foreach j ($Folders)
        aws s3 cp ./$j s3://codedeploy/DevOps/$j  --recursive --profile default
end

exit;
set Ports = ( 1 2 3)
