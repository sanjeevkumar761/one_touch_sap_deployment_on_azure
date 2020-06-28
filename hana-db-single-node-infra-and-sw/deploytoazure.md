Deploy HANA DB Single Node to Azure:  

**1. Getting ready:**   
Create Service Principal using Azure Cloud Shell /AZ CLI with command "az ad sp create-for-rbac". Save details as you'll need those later.

**2. Click the button below:**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://ms.portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsanjeevkumar761%2Fone_touch_sap_deployment_on_azure%2Fmaster%2Fhana-db-single-node-infra-and-sw%2Fazuredeploy.json)

**3. How to check installation progress:**   
a. Wait for initial deployment to complete in Azure portal. You'll see the message "Your deployment is complete" in Azure portal
b. Go to your Resource Group in Azure portal, locate the VM named "jumpboxlinux" and look for its Public IP address
c. Wait for about 10 minutes for installation monitoring layer inside jumboxlinux VM to be ready
d. Now, you can check installation progress on http://<public IP of your jumpbox VM>:3000
e. You can check detailed installation logs on http://<public IP of your jumpbox VM>:9001

**4. Advanced - How to login to jumpbox VM :**   
a. You can login to jumpbox VM as soon as it is ready ( user: juser, password: Welcome@123 )
b. You can switch to root by using "sudo su" and change directory to waagent using "cd /var/lib/waagent/custom-script/download/0"
c. Now you can check "stdout" and "stderr" files.
