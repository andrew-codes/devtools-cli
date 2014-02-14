require_relative 'chocolately_software_installer'

class GitInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('git').for(platform)
    ChocolatelySoftwareInstaller.new('poshgit').for(platform)
  end
end