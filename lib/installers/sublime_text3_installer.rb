require_relative 'chocolately_software_installer'

class SublimeText3Installer
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new 'SublimeText3'
  end

  def install_for(platform)
    @chocolately_installer.install_for(platform)
  end
end