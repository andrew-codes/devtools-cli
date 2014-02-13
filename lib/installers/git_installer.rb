require_relative 'chocolately_software_installer'

class GitInstaller
  def initialize
    @chocolately_installer = ChocolatelySoftwareInstaller.new 'git'
  end

  def install_for(platform)
    @chocolately_installer.install_for(platform)
  end
end