Import-Module "$($($PSScriptRoot))/Policy.Utils.psm1" -Force

Describe "Testing Storage Azure Policies" {
    BeforeEach {
        # Suppress unused variable warning caused by Pester scoping.
        # See also: https://pester.dev/docs/usage/setup-and-teardown#scoping
        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUserDeclaredVarsMoreThanAssignments', '', Scope = 'Function')]
        
        # Create a dedicated resource group for each test case
        $ResourceGroup = New-AzResourceGroup -Name (New-Guid).Guid -Location "northeurope"
    }

    # Context "When storage account is created" -Tag storage-account-create {
    #     It "Should audit public network access (Policy: Audit-StorageAccount-PublicNetworkAccess)" {
    #         # Create storage account
    #         $storageAccountName = -join ((97..122) | Get-Random -Count 15 | % {[char]$_})

    #         New-AzStorageAccount `
    #             -ResourceGroupName $ResourceGroup.ResourceGroupName `
    #             -AccountName $storageAccountName `
    #             -Location $ResourceGroup.Location `
    #             -SkuName Standard_GRS

    #         # Trigger compliance scan for resource group and wait for completion
    #         $ResourceGroup | Complete-PolicyComplianceScan 

    #         # Verify that storage account is incompliant
    #         Get-AzStorageAccount -ResourceGroupName $ResourceGroup.ResourceGroupName -Name $storageAccountName
    #         | Get-PolicyComplianceStateFromAssignment -PolicyAssignmentName "Audit-StorageAccount-PublicNetworkAccess"
    #         | Should -BeFalse
    #     }
    # }

    AfterEach {
        Remove-AzResourceGroup -Name $ResourceGroup.ResourceGroupName -Force
    }
}

