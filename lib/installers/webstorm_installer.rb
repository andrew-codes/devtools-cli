require_relative 'chocolately_software_installer'

class WebStormInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('WebStorm', platform)
  end

  private
  @chocolately_installer
end