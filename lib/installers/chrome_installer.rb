require_relative 'chocolately_software_installer'

class ChromeInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('GoogleChrome', platform)
  end

  private
  @chocolately_installer
end