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
install-package('ruby.debkit')

# IDEs
install-package('SublimeText3')
install-package('VisualStudio2013Ultimate')
install-package('VisualStudio2012Ultimate')
install-package('resharper')
install-package('dotpeek')
install-package('WebStorm')
install-package('RubyMine')

# Browsers
install-package('FireFox')
install-package('GoogleChrome')

# nodejs
install-package('yeoman')


#perform ruby updates and get gems
gem update --system
gem install rake
gem install bundler