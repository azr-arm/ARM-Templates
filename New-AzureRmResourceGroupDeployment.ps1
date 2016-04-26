
Install-Module AzureRM

Login-AzureRmAccount

# Variables
$LocName = "West Europe"
$rgName = "MyDeploymentRG04"
$deploymentName = "MyDeployment"
$templatePath = "C:\GitHub\ARM-Templates\101-vm-simple-windows\azuredeploy.json"

# New Azure Resource Group
New-AzureRmResourceGroup -Name $rgName -Location $LocName

# Create a deployment using inline parameters

New-AzureRmResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateFile $templatePath `
    -newStorageAccountName "MyDeployStorageACC" `
    -location $LocName `
    -adminUsername "Charbel" `
    -dnsLabelPrefix "chmydepl1"

# Create a deployment using a parameter object

$parameters = @{"newStorageAccountName"="MyDeployStorageACC"; `
"location"="West Europe";"adminUsername"="Charbel";"dnsLabelPrefix"="chmydepl2"}

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
    -TemplateParameterFile $parameterFilePath

# Create a deployment using an online template

$templateURI = "https://raw.githubusercontent.com/azr-arm/ARM-Templates/master/101-vm-simple-windows/azuredeploy.json"

New-AzureRmResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateUri $templateURI `
    -TemplateParameterFile $parameterFilePath

# Get and Remove AzureRm Resource Group

Get-AzureRmResourceGroup | Remove-AzureRmResourceGroup -Force

Remove-AzureRmResourceGroup -Name $rgName -Force



