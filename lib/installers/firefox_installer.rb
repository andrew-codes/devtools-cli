require_relative 'chocolately_software_installer'

class FirefoxInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('Firefox').for(platform)
  end
end