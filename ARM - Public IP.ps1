
<# Public IP Address #>


# Variables - Public IP

$publicIpShortName = "qweasdzxc"
$publicIpSuffix = "-ip"
$publicIpName = "${publicIpShortName}${publicIpSuffix}"
$dnsPrefix  = "qweasdzxc$(Get-Random)"
#$dnsPrefix  = "qweasdzxc$(Get-Random)"


<# Create Public IP Address, if it does not exist #>

Get-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName -ErrorVariable isIPExist -ErrorAction SilentlyContinue `


If ($isIPExist) 
{
    Write-Output "Public IP does not exist"
    
    Write-Verbose "Creating new Public IP: {$publicIpName}"


    $publicIp = New-AzureRmPublicIpAddress `
                -Name $publicIpName `
                -ResourceGroupName $rgName `
                -Location $location `
                -AllocationMethod 'Static' `
                -DomainNameLabel $dnsPrefix  `
                -Tag $tags
                
# -AllocationMethod 'Static' `  ## 'Static' 'Dynamic'
} 
Else 
{
    Write-Output "Public IP exist"

    Write-Verbose "Fetching Public IP: {$publicIpName}"


    $publicIp = Get-AzureRmPublicIpAddress `
                -Name $publicIpName `
                -ResourceGroupName $rgName
}




Write-Verbose "Get list of Public IPs"

Write-Output "Public IP"


Get-AzureRmPublicIpAddress -ResourceGroupName $rgName `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap




<#

Get-AzureRmPublicIpAddress `
    | Select-Object Name, ResourceGroupName, Location `
    | Format-Table -AutoSize -Wrap -GroupBy ResourceGroupName

#>





<#

https://docs.microsoft.com/en-us/powershell/module/azurerm.network/new-azurermpublicipaddress?view=azurermps-6.13.0
https://docs.microsoft.com/en-us/powershell/module/azurerm.network/get-azurermpublicipaddress?view=azurermps-6.13.0

#>


