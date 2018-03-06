#!/bin/tcsh 

# -- By chb@mz.co.kr -- # 
# -- On Mar 01, 2018 -- # 

set Users = ( ... )
set Profile = 'default'
set Region = 'ap-northeast-2'
set Group = 'Developer'
set TargetBucket = 'myTarget'

set count = 1
foreach user ( $Users )
	aws iam create-user --user-name $user --profile $Profile --region $Region
	aws iam add-user-to-group --group-name $Group --user-name $user --profile $Profile --region $Region
	aws s3 cp ./README s3://$TargetBucket/Developer/$user/ --profile $Profile --region $Region
	echo $count, $user
	@ count += 1
	sleep 1 
#	aws iam create-access-key --user-name $user --profile $Profile --region $Region | jq '.SecretAccessKey .AccessKeyId' 
	aws iam create-access-key --user-name $user --profile $Profile | jq '{SecretAccessKey: .AccessKey.SecretAccessKey, AccessKeyId : .AccessKey.AccessKeyId}' > $user-key 
	@ count +=1
end 
