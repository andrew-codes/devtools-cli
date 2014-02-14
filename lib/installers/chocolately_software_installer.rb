require_relative 'chocolately_software_installer'

class ChocolatelySoftwareInstaller
  def initialize(software)
    @software = software
  end

  def for(platform)
    if platform == :windows
      if @@not_installed
        PowerShell.run("iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))")
        @@not_installed = false
      end
      PowerShell.run("cinst #{@software}")
    end
  end

  private
  @software
  @@not_installed = true
end