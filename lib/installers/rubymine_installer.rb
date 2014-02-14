require_relative 'chocolately_software_installer'

class RubyMineInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('RubyMine').for(platform)
  end
end