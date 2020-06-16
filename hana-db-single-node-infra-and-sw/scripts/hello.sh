cd /home/sanjeevkumar761
AZURE_SUBSCRIPTION_ID=$1
AZURE_CLIENT_ID=$2
AZURE_SECRET=$3
AZURE_TENANT=$4
ARM_SUBSCRIPTION_ID=$1
ARM_CLIENT_ID=$2
ARM_CLIENT_SECRET=$3
ARM_TENANT_ID=$4
echo "export AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}\nexport AZURE_CLIENT_ID=${AZURE_CLIENT_ID}\nexport AZURE_SECRET=${AZURE_SECRET}\nexport AZURE_TENANT=${AZURE_TENANT}\nexport ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}\nexport ARM_CLIENT_ID=${ARM_CLIENT_ID}\nexport ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET}\nexport ARM_TENANT_ID=${ARM_TENANT_ID}\nexport TF_LOG=TRACE" >> azurecreds.sh
$(cat ./azurecreds.sh)
cd souvenir/scenarios/hana-single-node-full
git pull
rm terraform.tfvars
cp ./dev/terraform/terraform.tfvars .
terraform apply -var net_rg_name=$5 -var az_resource_group=$5 -auto-approve &
ls
ansible-playbook hana-single-node-full.yml --extra-vars 10.0.0.6 &
ls
