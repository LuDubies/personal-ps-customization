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

# class to get all valid repository names in SVN/
Class WorkingCopyNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $RepositoryPaths = 'C:/SVN/'
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

# change into SVN dir or directly into a repository
function CD-Into-SVN {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$false)]
		[ValidateSet([WorkingCopyNames])]
		[String]$repository
	)
	if($PSBoundParameters.ContainsKey('repository')) {
		cd ('C:/SVN/' + $repository)		
	} else {
		cd 'C:/SVN/'
	}
}
New-Alias -force cds CD-Into-SVN

# use ctrl+d to apply one word of PSReadLine intellisense
Set-PSReadLineKeyHandler -Chord "Ctrl+d" -Function ForwardWord

##################### git aliases ######################

function gitstatus {git status}
New-Alias -force gs gitstatus

function gitpushforcewithlease {git push --force-with-lease}
New-Alias -force gpf gitpushforcewithlease
