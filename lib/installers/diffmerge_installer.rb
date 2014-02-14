require_relative 'chocolately_software_installer'

class DiffMergeInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('diffmerge').for(platform)
  end
end