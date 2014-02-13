require_relative 'chocolately_software_installer'

class MySqlInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('mysql', platform)
    @chocolately_installer.install_for('mysql.workbench', platform)
  end

  private
  @chocolately_installer
end