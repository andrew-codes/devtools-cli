require_relative '../chocolatey'

class ChocolatelySoftwareInstaller
  def initialize(software)
    if @@not_installed
      PowerShell.run("iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))")
    end
    @software = software
  end

  def for(platform)
    if platform == :windows
      PowerShell.run("cinst #{@software}")
    end
  end

  private
  @software
  @@not_installed = true
end