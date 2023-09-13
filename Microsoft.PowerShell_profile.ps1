# Activate local venv in .venv
New-Alias -Force venvup .\.venv\Scripts\activate


# class to get all valid repository names in Repos/
Class RepoNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $RepositoryPaths = 'C:/Users/ldubies/Repos/'
        $RepositoryNames = ForEach ($RepoPath in $RepositoryPaths) {
            If (Test-Path $RepoPath) {
                (Get-ChildItem $RepoPath).BaseName
            }
        }
        return [string[]] $RepositoryNames
    }
}

# change into Repos dir or directly into a repository
function CD-Into-Repo {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$false)]
		[ValidateSet([RepoNames])]
		[String]$repository
	)
	if($PSBoundParameters.ContainsKey('repository')) {
		cd ('C:/Users/ldubies/Repos/' + $repository)		
	} else {
		cd 'C:/Users/ldubies/Repos/'
	}
}
New-Alias -force cdr CD-Into-Repo

