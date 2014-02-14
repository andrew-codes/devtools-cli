require_relative 'chocolately_software_installer'

class ChromeInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('GoogleChrome').for(platform)
  end
end