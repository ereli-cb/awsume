#!/bin/bash
#Author: Michael Barney, Trek10 Intern
#Date: June 2, 2017
#AWSume - a bash script to assume an AWS IAM role from the command-line

AWSUMEPY_LOCATION="./awsume.py"

unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_SECURITY_TOKEN
unset AWS_ACCESS_KEY_ID
unset AWS_REGION
unset AWS_DEFAULT_REGION

#grab the environment variables from the python script
read AWSUME_VALID AWSUME_SECRET_ACCESS_KEY AWSUME_SECURITY_TOKEN AWSUME_ACCESS_KEY_ID AWSUME_REGION <<< $(awsumepy "$@")

#set the environment variables
if [ "$AWSUME_VALID" = "True" ]; then
    export AWS_SECRET_ACCESS_KEY=$AWSUME_SECRET_ACCESS_KEY
    export AWS_SESSION_TOKEN=$AWSUME_SECURITY_TOKEN
    export AWS_SECURITY_TOKEN=$AWSUME_SECURITY_TOKEN
    export AWS_ACCESS_KEY_ID=$AWSUME_ACCESS_KEY_ID

    if [ ! "$AWSUME_REGION" = "None" ]; then
        export AWS_REGION=$AWSUME_REGION
        export AWS_DEFAULT_REGION=$AWSUME_REGION
    fi

    #if enabled, show the exact commands to use in order to assume the role we just assumed
    for AWSUME_var in "$@"
    do
        if [[ "$AWSUME_var" == "-s"* ]]; then
            echo export AWS_SECRET_ACCESS_KEY=$AWSUME_SECRET_ACCESS_KEY
            echo export AWS_SESSION_TOKEN=$AWSUME_SECURITY_TOKEN
            echo export AWS_SECURITY_TOKEN=$AWSUME_SECURITY_TOKEN
            echo export AWS_ACCESS_KEY_ID=$AWSUME_ACCESS_KEY_ID
            if [ ! "$AWSUME_REGION" = "None" ]; then
                echo export AWS_REGION=$AWSUME_REGION
                echo export AWS_DEFAULT_REGION=$AWSUME_REGION
            fi
        fi
    done
fi