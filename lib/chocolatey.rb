require_relative 'power_shell'
require_relative 'installers/chocolately_software_installer'

class Chocolatey
  @@not_installed = true

  def initialize()
    if @@not_installed
      PowerShell.run("iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))")
      @@not_installed = false
    end
  end

  def install(software)
    ChocolateySoftwareInstaller.new software
  end
end