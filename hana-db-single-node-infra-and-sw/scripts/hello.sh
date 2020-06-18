cd /home/juser
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
sudo apt install python-pip -y
pip install azure
pip install msrestazure
pip install msrest
pip install azure-storage
sudo apt-get install unzip -y
wget https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip
sudo apt install unzip
unzip terraform_0.12.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
AZURE_SUBSCRIPTION_ID=$1
AZURE_CLIENT_ID=$2
AZURE_SECRET=$3
AZURE_TENANT=$4
ARM_SUBSCRIPTION_ID=$1
ARM_CLIENT_ID=$2
ARM_CLIENT_SECRET=$3
ARM_TENANT_ID=$4
echo "export AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}\nexport AZURE_CLIENT_ID=${AZURE_CLIENT_ID}\nexport AZURE_SECRET=${AZURE_SECRET}\nexport AZURE_TENANT=${AZURE_TENANT}\nexport ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}\nexport ARM_CLIENT_ID=${ARM_CLIENT_ID}\nexport ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET}\nexport ARM_TENANT_ID=${ARM_TENANT_ID}\nexport TF_LOG=TRACE\nexport TF_LOG_PATH=/home/juser/terraform.log" >> azurecreds.sh
$(cat ./azurecreds.sh)
cd souvenir/scenarios/hana-single-node-full
frontail /home/juser/terraform.log /home/juser/ansible.log -d
git pull
rm -f terraform.tfvars
cp ./dev/terraform/terraform.tfvars .
sudo su
terraform apply -var net_rg_name=$5 -var az_resource_group=$5 -auto-approve
ls
