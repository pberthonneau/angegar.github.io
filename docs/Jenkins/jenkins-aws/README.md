# Run AWS CLI from jenkins

## Introduction
As said in the [jenkins](https://github.dxc.com/lgil3/tutorials/tree/master/jenkins?_pjax=%23js-repo-pjax-container) tutorial, our Jenkins setup is voluntarily kept simple and minimize. It implies that to work with AWS you will have to use a docker container.

We recommend to use the mesophere one (**mesosphere/aws-cli**) as it is based on linux alpine which the smallest linux distribution.

## Problem statement
How to pass the AWS credentials to our aws cli container in a secure way.

1. In Jenkins, navigate to your organization 
2. Click on the button create credentials (bottom of the left menu)
3. Click on Folder > Global credentials
4. Click on **Add credentials** on the left menu
5. Select the type **Secret text**
6. In ID and Description enter AWS_ACCESS_KEY_ID
7. In secret, copy paste your AWS access key
8. Redo the steps from (4) for AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION