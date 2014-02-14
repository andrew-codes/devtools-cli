require_relative 'chocolately_software_installer'

class VisualStudio2012Installer
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new
  end

  def for(platform)
    @chocolately_installer.install_for('VisualStudio2013Ultimate', platform)
    @chocolately_installer.install_for('ReSharper', platform)
    @chocolately_installer.install_for('dotPeek', platform)
  end

  private
  @chocolately_installer
end