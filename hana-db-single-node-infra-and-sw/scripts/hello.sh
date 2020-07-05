cd /home/juser
sudo su
git clone https://sanjeku@dev.azure.com/sanjeku/sap-infra-devops/_git/souvenir
cat /dev/zero | ssh-keygen -q -N "" > /dev/null
echo 'test log' >> /home/juser/terraform.log
echo 'test log' >> /home/juser/ansible.log
echo 'test log' >> /home/juser/terraformpas.log
echo 'test log' >> /home/juser/ansiblepas.log
apt-get update
apt-get upgrade -y
apt-get install npm -y && npm i frontail -g 
export ANSIBLE_HOST_KEY_CHECKING=False
sleep 1m
frontail -d /var/lib/waagent/custom-script/download/0/stdout /home/juser/ansible.log /home/juser/terraformpas.log
npm install /home/juser/souvenir/s4hana-nodejs/ && node /home/juser/souvenir/s4hana-nodejs/index.js $5 $6 2>&1 | tee -a /home/juser/ansible.log &
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y
apt install python-pip -y
pip install azure
pip install msrestazure
pip install msrest
pip install azure-storage
echo '[hanadb]' >> /etc/ansible/hosts
echo '10.0.0.6 ansible_user=demo ansible_ssh_private_key_file=/root/.ssh/id_rsa' >> /etc/ansible/hosts
echo '[pas]' >> /etc/ansible/hosts
echo '10.0.0.7 ansible_user=demo ansible_ssh_private_key_file=/root/.ssh/id_rsa' >> /etc/ansible/hosts
apt-get install unzip -y
wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip
apt install unzip
unzip terraform_0.12.28_linux_amd64.zip
mv terraform /usr/local/bin/
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
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
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
apt-get install axel
axel https://softsap.blob.core.windows.net/sapsoft/IMDB_SERVER20_047_0-80002031.SAR
az login --service-principal --username $2 --password $3 --tenant $4
az deployment group create  --resource-group $5 --template-uri "https://raw.githubusercontent.com/sanjeevkumar761/one_touch_sap_deployment_on_azure/master/hana-db-single-node-infra-and-sw/jumpbox-windows-deploy.json" --parameters adminUsername='juser' adminPassword='Welcome@123' windowsOSVersion='2016-Datacenter' vmSize='Standard_D2_v3' location=$6 vNetName='sapvnetonetouchdeployment'
cd souvenir/scenarios/hana-single-node-full
rm -f terraform.tfvars
cp ./dev/terraform/terraform.tfvars .
terraform init
terraform apply -var net_rg_name=$5 -var az_resource_group=$5 -var az_region=$6 -var az_domain_name=$5 -auto-approve
ls
