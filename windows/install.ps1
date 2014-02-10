write-host 'Installing Chocolatey'
iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))

function Install-Package {
param(
    [string] $package,
    [string] $packageName = ''
)
    if ($packageName -eq '') {
        $packageName = $package
    }
    write-host "Installing $($packageName)"
    cinst $package
}


# Tools
install-package('7zip') 
install-package('git')
install-package('diffmerge')
install-package('poshgit')
install-package('autohostkey_l')
install-package('nuget.commandline') 

# Languages
install-package('nodejs')
install-package('nodejs.commandline')
install-package('ruby')
install-package('ruby.devkit')

# IDEs
install-package('SublimeText3')
install-package('SublimeText3.PowershellAlias')
install-package('VisualStudio2013Ultimate')
install-package('VisualStudio2012Ultimate')
install-package('resharper')
install-package('dotpeek')
install-package('WebStorm')
install-package('RubyMine')

# Browsers
install-package('FireFox')
install-package('GoogleChrome')

# Frameworks/Libraries

install-package('psake')
install-package('yeoman')


# Ruby updates and some default gems; rake and bundler
gem update --system
gem install rake
gem install bundler