Deploy HANA DB Single Node to Azure (creates infrastructure on Microsoft Azure and installs SAP HANA DB software). It takes about 45-60 minutes for full deployment process to complete. Please follow the steps mentioned below:    

**Step 1. Getting ready:**   
Create Service Principal using Azure Cloud Shell /AZ CLI with command "az ad sp create-for-rbac". Save details as you'll need those later.

**Step 2. Click the button below:**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://ms.portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsanjeevkumar761%2Fone_touch_sap_deployment_on_azure%2Fmaster%2Fhana-db-single-node-infra-and-sw%2Fazuredeploy.json)

**Step 3. How to check installation progress:**   
1\) Wait for initial deployment to complete in Azure portal. You'll see the message "Your deployment is complete" in Azure portal. It deploys a jumpbox on Azure  
2\) Go to your Resource Group in Azure portal, locate the VM named "jumpboxlinux" and look for its Public IP address  
3\) *Wait for about 10 minutes* for installation monitoring layer inside jumpboxlinux VM to be ready  
4\) Now, you can check installation progress on http://\<public IP of your jumpboxlinux VM\>:3000  \(you need to refresh the page manually to check progress until the Deployment progress reaches 100%\)  
5\) You can check detailed installation logs on http://\<public IP of your jumpboxlinux VM\>:9001  

**Step 4. Confirm HANA DB is up and running:**    
1\) SSH into jumpboxlinx VM with its Public IP address using Putty or other SSH tool ( user: juser, password: Welcome@123 )   
2\) Switch to root by using command "sudo su"  
3\) SSH into HANA DB VM using command "ssh demo@hanadb" (accept key fingerprint of HANA DB VM when it prompts, by typing yes)  
4\) Inside HANA DB VM, switch to HANA admin user by using command "sudo su - hn1adm"  
5\) Check status of HANA DB processes by using command "sapcontrol -nr 00 -Function GetProcessList". You should be able to notice that status of all HANA DB processes is GREEN.  

**Advanced - How to check detailed installation trace:**   
1\) You can login to jumpbox VM as soon as it is shows Running state in Azure portal ( user: juser, password: Welcome@123 )  
2\) You can switch to root by using "sudo su" and change directory to waagent using "cd /var/lib/waagent/custom-script/download/0"  
3\) Now you can check "stdout" and "stderr" files.  
