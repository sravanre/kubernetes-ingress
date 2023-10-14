#!/bin/bash

# setting the project name here, I know that the name of the project is playground
gcloud config set project `gcloud projects list | grep -i playground | grep -v NAME| awk '{print $2}'`
# Enable the kubernetes-engine api
gcloud services enable container.googleapis.com
#clone the repository 
git clone https://github.com/sravanre/kubernetes-ingress
# change the directory for the terraform folder to identify the .tf files
cd ~/kubernetes-ingress/gke-terraform-cluster
# get the project id, could be different for different user
gcloud config get-value project > /var/tmp/newfile
#update it on the go with sed utility
sed -i "s/NEW_Project_ID/$(cat /var/tmp/newfile)/g" ~/kubernetes-ingress/gke-terraform-cluster/terraform.tfvars

# spin the cluster up with terraform
terraform init
terraform plan 
terraform apply --auto-approve

# this will update the kubeconfig in the current bash shell settings
# this should be run from the terraform folder where the state file is present
gcloud container clusters get-credentials `terraform output -raw kubernetes_cluster_name` --region us-central1 --project `terraform output -raw project_id`