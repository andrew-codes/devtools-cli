require_relative 'chocolately_software_installer'

class NodejsInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new 'nodejs'
  end

  def for(platform)
    @chocolately_installer.install_for(platform)
  end
end