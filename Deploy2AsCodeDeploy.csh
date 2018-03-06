#!/bin/tcsh

# -- By chb@mz.co.kr -- # 
# -- On Feb 08, 2018 -- # 
# -- Comments : This is a argument version. 

set ApplicationNames = ( DevWeb DevWas DevApp )
set BucketName = 'dev-source'
set S3Location = 's3://'$BucketName'/DevOps'
set Region = 'ap-northeast-2'
set Key = 'DevOps'
set Profile = 'default'
set DeployType = 'AllAtOnce'

if ( $#argv == 0 ) then 
    echo 
    echo "  You need two more arguements !!"
    echo 
    echo "  Usage : $argv[0] [r|s|l] [2nd args] "
    echo "   - ex) $0 r bodp"
    exit;
else if ( $#argv == 1 ) then 
    echo You need one more arguement !!
    exit;
else if ( $#argv == 2 ) then 
    set Choice = `echo $argv[1] | tr '[A-Z]' '[a-z]'`
    if ( $Choice == 'r' ) then 
        set AppName = $ApplicationNames[1]
    else if ( $Choice == 's' ) then 
        set AppName = $ApplicationNames[2]
    else if ( $Choice == 'l' ) then 
        set AppName = $ApplicationNames[3]
    else 
        echo 'don\'t make sense !!'
        exit;
    endif 
else if ( $#argv >= 3 ) then 
    echo "Usage : $argv[0] [r|s|l] [2nd argv] "
    echo " - EX) $0 r bodp "
    exit;
endif 

echo $AppName , Key : $Key/$argv[2]/$argv[2].tgz 
# -- Run Codedeploy -- # 
aws deploy create-deployment --application-name $AppName \
    --deployment-config-name CodeDeployDefault.$DeployType \
    --deployment-group-name $AppName \
    --file-exists-behavior OVERWRITE \
    --description "My demo deployment"  \
    --s3-location bucket=$BucketName,bundleType=tgz,key=$Key/$argv[2]/$argv[2].tgz --region $Region --profile $Profile

# -- set aws deploy get-deployment --deployment-id d-MMQUF19SP  --profile Qas --region ap-northeast-2 | jq ".deploymentInfo.status" -r
