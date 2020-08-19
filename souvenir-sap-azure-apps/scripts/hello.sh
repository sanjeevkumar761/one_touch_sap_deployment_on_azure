sudo su
usermod -aG sudo juser
sudo su - juser
cd /home/juser
chown juser /home/juser
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
sudo install minikube /usr/local/bin/
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt install conntrack
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
#sudo usermod -aG docker $USER && newgrp docker
sudo minikube start --driver=none
sudo minikube status
wget https://get.helm.sh/helm-v3.3.0-rc.1-linux-amd64.tar.gz
tar -zxvf helm-v3.3.0-rc.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client
sudo apt-get update && sudo apt-get -y install socat
sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash



sudo kubectl create namespace kubeapps
sudo su

az acr login --name souveniracr --username $2 --password $3 
docker pull souveniracr.azurecr.io/kubeapps/dashboard

export HELM_EXPERIMENTAL_OCI=1
echo $3 | helm registry login souveniracr.azurecr.io \
  --username $2 \
  --password-stdin

helm chart pull souveniracr.azurecr.io/helm/kubeapps:v1
helm chart export souveniracr.azurecr.io/helm/kubeapps:v1 \
  --destination ./install

cd install
helm dependency update kubeapps
sudo helm install kubeapps --namespace kubeapps ./kubeapps --set useHelm3=true

sudo kubectl create namespace sap-azure-apps
az acr login --name souveniracr --username $2 --password $3 
docker pull souveniracr.azurecr.io/souvenir/onetouchsapdeployment:latest
export HELM_EXPERIMENTAL_OCI=1
echo $3 | helm registry login souveniracr.azurecr.io \
  --username $2 \
  --password-stdin
helm chart pull souveniracr.azurecr.io/helm/one-touch-sap-deployment:v1
helm chart export souveniracr.azurecr.io/helm/one-touch-sap-deployment:v1 \
  --destination ./install
cd install
sudo helm install one-touch-sap-deployment --namespace sap-azure-apps ./one-touch-sap-deployment --set useHelm3=true

sudo su

# helm chart pull souveniracr.azurecr.io/helm/kubeapps:v1
# helm chart export souveniracr.azurecr.io/helm/kubeapps:v1 \
#  --destination ./install

# sudo helm repo add bitnami https://charts.bitnami.com/bitnami

# cd install
sudo kubectl create serviceaccount kubeapps-operator
sudo kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator


cd /home/juser
sudo apt install -y npm 
git clone https://sanjeku@dev.azure.com/sanjeku/souvenir/_git/souvenir-sap-azure-apps
cd souvenir-sap-azure-apps
cd k8s-login-helper 
npm install
sudo su
export HOST=0.0.0.0
sudo node index.js &

sleep 2m
sudo kubectl port-forward -n kubeapps svc/kubeapps 8080:80 --address 0.0.0.0 &
sleep 1m
sudo kubectl port-forward -n sap-azure-apps svc/one-touch-sap-deployment 8081:3000 --address 0.0.0.0 &

#sudo rm /var/lib/apt/lists/lock
#sudo rm /var/cache/apt/archives/lock
#sudo rm /var/lib/dpkg/lock*
