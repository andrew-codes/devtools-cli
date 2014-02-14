require_relative 'chocolately_software_installer'

class ZipInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('7zip').for(platform)
  end
end