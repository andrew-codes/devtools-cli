require_relative 'chocolately_software_installer'

class RavenDbInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('ravendb', platform)
  end

  private
  @chocolately_installer
end