require_relative 'chocolately_software_installer'

class NodejsInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new 'nodejs'
  end

  def install_for(platform)
    @chocolately_installer.install_for(platform)
  end
end