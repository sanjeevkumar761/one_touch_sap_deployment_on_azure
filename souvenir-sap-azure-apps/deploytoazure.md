# Deploy Souvenir Apps for SAP on Azure
*You agree to the dislaimer mentioned at the bottom of this page, when you proceed further with the details and steps given below.*

This creates infrastructure on Microsoft Azure and installs SAP HANA, ASCS and CI instances for S4HANA1909.     
It takes about 120-150 minutes for full deployment process to complete. Please follow the steps mentioned below:    

## Getting ready:  
1. Create Service Principal using Azure Cloud Shell /AZ CLI with command "az ad sp create-for-rbac". Save details as you'll need those later.    
If you use exitsing Service Principal, please make sure to copy appId and password/secret correctly.  
2. Create a reource group (with all lowercase characters in name, no special characters), create a Vnet (with 10.0.0.0/16 address space, in same region as resource group, all lowercase characters in vNet name), then create two subnets - one for SAP workload (with address space 10.0.0.0/24) and second for Azure Bastion (if you need Azure Bastion, else select 'no'). The Azure Bastion subnet must be named "AzureBastionSubnet" and This subnet must be at least /27 or larger e.g., 10.0.1.0/27 . If you need public IP address for jumpboxlinux, then select 'yes' (as is the default value) for jumpboxlinux. 

## To deploy Souvenir Apps for SAP on Azure, Click the button below:  

While deploying to Azure, make sure to select existing resource group, vNet and subNet (for SAP workload) which you would have created as mentioned in above section. 

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://ms.portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fdev.azure.com%2Fsanjeku%2Fsouvenir%2F_apis%2FsourceProviders%2F_git%2Ffilecontents%3Frepository%3Dsouvenir-sap-azure-apps%26commitOrBranch%3Dmaster%26api-version%3D5.0-preview.1%26path%3D%252Fazure-deploy-init%252Fazuredeploy.json)  

Altrenatively, yon can initiate the deployment using Azure CLI. The command is:   
az deployment group create --resource-group <resource group name> --template-uri <path to souvenir azuredploy.json which is  https://raw.githubusercontent.com/sanjeevkumar761/one_touch_sap_deployment_on_azure/master/s4hana-infra-and-sw-e/azuredeploy.json >  --parameters vNetNewOrExisting=existing virtualNetworkName=<vnet name> subnetName=<subnet name> vmName=jumpboxlinux servicePrincipalAppId=<appId> servicePrincipalPassword=<password>

## How to check installation progress:   
1\) Wait for initial deployment to complete in Azure portal. You'll see the message "Your deployment is complete" in Azure portal. It deploys a jumpbox on Azure  
2\) Go to your Resource Group in Azure portal, locate the VM named "jumpboxlinux" and look for its Public IP address  
3\) *Wait for about 10 minutes* for installation monitoring layer inside jumpboxlinux VM to be ready \(It prepares automatically in background\)   
4\) Now, you can check installation progress on URL http://\<public IP of your jumpboxlinux VM\>:3000  \(you need to refresh the page manually to check progress until the Deployment progress reaches 100% which takes about 40-50 minutes)  
5\) You can check detailed installation logs on URL http://\<public IP of your jumpboxlinux VM\>:9001  

## Connect using SAP GUI:        
1\) Logon to Windows jumpbox (installed automatically as part of the installation process)    
2\) Download file "sapgui-download-extract.ps1" from here https://raw.githubusercontent.com/sanjeevkumar761/one_touch_sap_deployment_on_azure/master/s4hana-infra-and-sw/scripts/sapgui-download-extract.ps1   (This step will take about 10-15 minutes)  
3\) Open Powershell and cd into directory "C:\Users\juser"  
4\) Run powershell script by typing on command line "sapgui-download-extract.ps1" and hit Enter  
5\) Wait for SAP GUI zip file for download and extract SAP GUI software. It will start SAP GUI installer    
6\) Click Next, Select "SAP GUI for Windows....", click Next and wait for SAP GUI installation to complete  
7\) Click Close to complete SAP GUI installation  
8\) Double click SAP GUI Logon shortcut on Desktop, Click Next and Create new connection entry in SAP GUI with these details:    
Description: S4HANA  
System ID: S40  
Instance Number: 00  
Application Server: 10.0.0.7  
9\) Click Finish and click Logon   
10\) Now you can logon to S4HANA system by entering user details.  

## Connect to HANA DB and confirm it is up and running:      
1\) SSH into jumpboxlinx VM with its Public IP address using Putty or other SSH tool ( user: juser, password: Welcome@123 )   
2\) Switch to root by using command "sudo su"  
3\) SSH into HANA DB VM using command "ssh demo@hanadb" (accept key fingerprint of HANA DB VM when it prompts, by typing yes)  
4\) Inside HANA DB VM, switch to HANA admin user by using command "sudo su - hn1adm"  
5\) Check status of HANA DB processes by using command "sapcontrol -nr 00 -function GetProcessList". You should be able to notice that status of all HANA DB processes is GREEN.  

## How to snooze (stop/start) HANA DB VM and jumpbox VM:      
1\) To stop HANA DB, SSH to HANA DB VM, stop HANA processes by using command "sapcontrol -nr 00 -Function Stop"  
2\) Stop HANA DB VM from Azure portal  
3\) Stop jumpboxlinux VM from Azure portal  
4\) To start HANA DB next time, start jumpboxlinux VM from Azure portal  
5\) SSH into jumpboxlinux and then SSH into HANA DB VM  
6\) Switch to HANA admin user by using command "sudo su - hn1adm" and run command "sapcontrol -nr 00 -Function Start" .  

## Advanced - How to check detailed installation trace:     
1\) You can login to jumpbox VM as soon as it is shows Running state in Azure portal  
2\) You can switch to root by using "sudo su" and change directory to waagent using "cd /var/lib/waagent/custom-script/download/0"  
3\) Now you can check "stdout" and "stderr" files.  




## IMPORTANT DISCLAIMER    
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  

This source code is just an example and it does not represent any software or product or service from my employer Microsoft. It is not an official Microsoft artifact or product and it is not endorsed in any way by Microsoft. You should exercise your own judgement and prudence before using it. There is no one who is actively maintaining or supporting this project.  
