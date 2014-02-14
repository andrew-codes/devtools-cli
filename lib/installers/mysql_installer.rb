require_relative '../chocolatey'

class MySqlInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('mysql').for(platform)
    @chocolately_installer.isntall('mysql.workbench').for(platform)
  end

  private
  @chocolately_installer
end