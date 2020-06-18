Deploy HANA DB Single Node to Azure 

**1. Getting ready:** Create Service Principal using Azure Cloud Shell /AZ CLI with command "az ad sp create-for-rbac". Save details as you'll need those later.

**2. Click the button below (only East US region supported currently):**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://ms.portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsanjeevkumar761%2Fone_touch_sap_deployment_on_azure%2Fmaster%2Fhana-db-single-node-infra-and-sw%2Fazuredeploy.json)

**3. How to check installation progress :** 
1. You can login to jumpbox VM as soon as it is ready ( user: juser, password: Welcome@123 )
2. You can check installation logs on http:// public IP of your jumpbox VM:9001

