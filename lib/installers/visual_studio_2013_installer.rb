require_relative 'chocolately_software_installer'

class VisualStudio2013Installer

  def for(platform)
    ChocolatelySoftwareInstaller.new('VisualStudio2013Ultimate').for(platform)
    ChocolatelySoftwareInstaller.new('ReSharper').for(platform)
    ChocolatelySoftwareInstaller.new('dotPeek').for(platform)
  end
end