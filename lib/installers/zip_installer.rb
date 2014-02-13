require_relative 'chocolately_software_installer'

class ZipInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('7zip', platform)
  end

  private
  @chocolately_installer
end