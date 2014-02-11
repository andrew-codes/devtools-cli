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