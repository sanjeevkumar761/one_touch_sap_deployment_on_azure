cd /home/juser
sudo su
apt install npm -y
npm i frontail -g
frontail -d /home/juser/terraform.log /home/juser/ansible.log
npm install /home/juser/souvenir/nodejs/
node /home/juser/souvenir/nodejs/index.js 2>&1 | tee -a /home/juser/ansible.log &
echo '[hanadb]' >> /etc/ansible/hosts
echo '10.0.0.6 ansible_user=demo' >> /etc/ansible/hosts
ssh-keyscan -H 10.0.0.6 >> ~/.ssh/known_hosts
cat /dev/zero | ssh-keygen -q -N "" > /dev/null
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 
apt-get update
apt-get upgrade -y
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y
apt install python-pip -y
pip install azure
pip install msrestazure
pip install msrest
pip install azure-storage
apt-get install unzip -y
wget https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip
apt install unzip
unzip terraform_0.12.7_linux_amd64.zip
mv terraform /usr/local/bin/
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
git clone https://sanjeku@dev.azure.com/sanjeku/sap-infra-devops/_git/souvenir
cd souvenir/scenarios/hana-single-node-full
rm -f terraform.tfvars
cp ./dev/terraform/terraform.tfvars .
terraform init
terraform apply -var net_rg_name=$5 -var az_resource_group=$5 -auto-approve
ls
