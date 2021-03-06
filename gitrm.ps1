function Remove-MergedRemoteBranches {
    <#
.SYNOPSIS
Helper script for removing merged remote branches
 
.DESCRIPTION
This script will remove all remote branches which were already merged to the current branch
 
.PARAMETER Branches
Collection of excluded from removing branches
 
.EXAMPLE
.\Remove-MergedRemoteBranches.ps1
Removes all merged remote branches except default branches: master, develop, HEAD
 
.EXAMPLE
.\Remove-MergedRemoteBranches.ps1 -Branches naster,feature1
Removes all merged remote branches except specified branches: master, feature1
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string[]]$Branches = @("main", "develop", "HEAD")
    )

    process {
        . $PSScriptRoot\Get-MergedRemoteBranchces.ps1 -Branches $Branches | % {
            $i = $_.IndexOf("/")
            $origin = $_.Substring(0, $i)
            $branch = $_.Substring($i + 1)
            Write-Host "$origin -> $branch"
            git push $origin --delete $branch
        }
    }
}
Remove-MergedRemoteBranches()
