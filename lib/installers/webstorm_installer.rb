require_relative 'chocolately_software_installer'

class WebStormInstaller
   def for(platform)
    ChocolatelySoftwareInstaller.new('WebStorm').for(platform)
  end
end