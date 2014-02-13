require_relative 'chocolately_software_installer'

class SublimeText3Installer
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('SublimeText3', platform)
  end

  private
  @chocolately_installer
end