require_relative 'chocolately_software_installer'
require_relative '../environment_path'

class GitInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('git').for(platform)
    ChocolatelySoftwareInstaller.new('poshgit').for(platform)
    self.setup_posh_git platform
  end

  private
  def setup_posh_git (platform)
    if platform == :windows
        EnvironmentPath.append 'C:\\Program Files (x86)\\git\\bin'
    end
  end
end