# Set execution policy
set-executionpolicy Unrestricted

write-host 'Installing Chocolatey'
iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))

function Install-Package {
param(
    [string] $package
)
    write-host "Installing $($package)"
    cinst $package
    if (test-path -Path "./$($package)/configure.ps1")
    {
        . "$($package)/configure.ps1"
    }
}