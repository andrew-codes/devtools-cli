require_relative 'chocolately_software_installer'

class GitInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('git', platform)
    @chocolately_installer.install_for('poshgit', platform)
  end

  private
  @chocolately_installer
end