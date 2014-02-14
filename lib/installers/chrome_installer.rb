require_relative '../chocolatey'

class ChromeInstaller
  def initialize
    @chocolately_installer =  Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('GoogleChrome').for(platform)
  end

  private
  @chocolately_installer
end