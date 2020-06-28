Deploy HANA DB Single Node to Azure:  

**Step 1. Getting ready:**   
Create Service Principal using Azure Cloud Shell /AZ CLI with command "az ad sp create-for-rbac". Save details as you'll need those later.

**Step 2. Click the button below:**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://ms.portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsanjeevkumar761%2Fone_touch_sap_deployment_on_azure%2Fmaster%2Fhana-db-single-node-infra-and-sw%2Fazuredeploy.json)

**Step 3. How to check installation progress:**   
1) Wait for initial deployment to complete in Azure portal. You'll see the message "Your deployment is complete" in Azure portal  
2) Go to your Resource Group in Azure portal, locate the VM named "jumpboxlinux" and look for its Public IP address  
3) Wait for about 10 minutes for installation monitoring layer inside jumpboxlinux VM to be ready  
4) Now, you can check installation progress on http://\< public IP of your jumpboxlinux VM\>:3000  
5) You can check detailed installation logs on http:// public IP of your jumpboxlinux VM:9001  

**Advanced - How to login to jumpbox VM :**   
1) You can login to jumpbox VM as soon as it is ready ( user: juser, password: Welcome@123 )  
2) You can switch to root by using "sudo su" and change directory to waagent using "cd /var/lib/waagent/custom-script/download/0"  
3) Now you can check "stdout" and "stderr" files.  
