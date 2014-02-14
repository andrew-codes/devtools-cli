require_relative 'chocolately_software_installer'

class SublimeText3Installer
  def for(platform)
    ChocolatelySoftwareInstaller.new('SublimeText3').for(platform)
  end
end