require_relative 'chocolately_software_installer'

class NodejsInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('nodejs').for(platform)
    ChocolatelySoftwareInstaller.new('nodejs.commandline').for(platform)
  end
end