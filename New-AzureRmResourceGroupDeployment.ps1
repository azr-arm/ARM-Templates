
Install-Module AzureRM

Login-AzureRmAccount

$LocName = "West Europe"
$rgName = "MyDeploymentRG"
$deploymentName = "MyDeployment"
$templatePath = "C:\GitHub\ARM-Templates\101-vm-simple-windows\azuredeploy.json"

New-AzureRmResourceGroup -Name $rgName -Location $LocName

# Create a deployment using inline parameters

New-AzureRmResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateFile $templatePath `
    -newStorageAccountName "MyDeployStorageACC" `
    -location $LocName `
    -adminUsername "Charbel" `
    -dnsNameForPublicIP "Chmydepl1"

# Create a deployment using a parameter object

$parameters = @{"newStorageAccountName"="MyDeployStorageACC";"location"="West Europe";"adminUsername"="Charbel";"dnsNameForPublicIP"="Chmydepl2"}

New-AzureRmResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateFile $templatePath `
    -TemplateParameterObject $parameters

# Create a deployment using a parameter file

$parameterFilePath = "C:\GitHub\ARM-Templates\101-vm-simple-windows\azuredeploy.parameters.json"

New-AzureRmResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateFile $templatePath `
    -TemplateParameterObject $parameterFilePath

# Create a deployment using an online template

New-AzureRmResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateFile https://raw.githubusercontent.com/azr-arm/ARM-Templates/master/101-vm-simple-windows/azuredeploy.json `
    -TemplateParameterObject $parameterFilePath

# Get and Remove AzureRm Resource Group

Get-AzureRmResourceGroup -Name $rgName | Remove-AzureRmResourceGroup -Force

Remove-AzureRmResourceGroup -Name $rgName -Force



