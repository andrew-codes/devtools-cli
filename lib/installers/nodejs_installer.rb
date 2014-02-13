require_relative 'chocolately_software_installer'

class NodejsInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('nodejs', platform)
    @chocolately_installer.install_for('nodejs.commandline', platform)
  end

  private
  @chocolately_installer
end