#!/bin/tcsh

# -- By chb@mz.co.kr -- # 
# -- On Feb 08, 2018 -- # 

# -- Define some Env Variables -- # 
set ApplicationName = 'Prd-Web'
set DeployGroupName = 'Prd-Web-Group'
set BucketName = 'prd-sources'
set S3Location = 's3://prd-web-bucket...'
set Pwd = `pwd`
set SourceDir = $Pwd/'mysource'
set SourceName = 'mysource.tgz'
set Region = 'ap-northeast-2'
set Key = 'DevOps'
set Profile = 'default'
set DeployType = 'AllAtOnce'
# -- set DeployType = 'OneAtATime'

# -- Compressing the Package -- # 
rm -f $SourceDir/$SourceName
cd $SourceDir
tar czfp $SourceName *

# -- Uploading the Package -- # 
aws s3 rm $S3Location/$SourceName --profile $Profile
aws s3 cp $SourceDir/$SourceName $S3Location/$SourceName --region $Region --profile $Profile

# -- CodeDeploy Source Code Package -- # 
aws deploy create-deployment --application-name $ApplicationName \
    --deployment-config-name CodeDeployDefault.OneAtATime \
    --deployment-group-name $DeployGroupName \
    --file-exists-behavior OVERWRITE \
    --description "My demo deployment"  \
    --s3-location bucket=$BucketName,bundleType=tgz,key=$Key/$SourceName --region $Region --profile $Profile
   
