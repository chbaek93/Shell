#!/bin/tcsh

# -- By chb@mz.co.kr -- #
# -- On Feb 13, 2018 -- #

# --
set Instances = ( lounge lounge2 audio mystory )

set Ports = ( 1 2 3 4 5 )
# -- Make a List for Directory -- #
# -- set Directorys = `ls -al | grep "^d" | awk '{print $9}'| grep -v "^\.\|^\.."`
set SamplePath       = `pwd`/Samples
set SourcePath       = `pwd`/Sources
set DestinationPath  = `pwd`/Destinations

set ApplicationStart    = $SamplePath'/ApplicationStart'
set ApplicationStop     = $SamplePath'/ApplicationStop'
set AppSpec             = $SamplePath'/appspec.yml'
set BeforeInstall       = $SamplePath'/BeforeInstall'
set Install             = $SamplePath'/Install'
set Permission          = $SamplePath'/Permission'
set ValidateService     = $SamplePath'/ValidateService'

set count = 1
foreach Inst ($Instances);
        mkdir -p $DestinationPath/$Inst
        echo Step $count : $Inst
        cd $SourcePath/$Inst
        tar czfp $Inst.tgz *
        mv $Inst.tgz $DestinationPath/$Inst/

        cd $DestinationPath/$Inst/
        sed "s/INSTANCE/$Inst/g" $ApplicationStart > $DestinationPath/$Inst/ApplicationStart
        sed "s/INSTANCE/$Inst/g" $ApplicationStop > $DestinationPath/$Inst/ApplicationStop
        sed "s/INSTANCE/$Inst/g" $AppSpec > $DestinationPath/$Inst/appspec.yml
        cat $BeforeInstall > $DestinationPath/$Inst/BeforeInstall
        cat $Install > $DestinationPath/$Inst/Install
        cat $Permission > $DestinationPath/$Inst/Permission
        sed "s/PORT/$Ports[$count]/" $ValidateService > $DestinationPath/$Inst/ValidateService

        tar czfp ../All/$Inst.tgz *
        aws s3 cp ../All/$Inst.tgz s3://qas-bookclub-codedeploy/Developer/$Inst/

        if ( $count == 1) then
                exit;
        endif
        @ count = $count + 1
end
