require_relative '../powershell'

class Chocolatey
  @@not_installed = true

  def initialize()
    if @@not_installed
      PowerShell.run("iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))")
      @@not_installed = false
    end
  end

  def install(software)
    PowerShell.run("cinst #{software}")
  end
end