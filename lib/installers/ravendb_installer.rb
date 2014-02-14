require_relative 'chocolately_software_installer'

class RavenDbInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('ravendb').for(platform)
  end
end