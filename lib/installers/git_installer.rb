require_relative 'chocolately_software_installer'
require_relative '../environment_path'

class GitInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('git').for(platform)
    setup_posh_git platform
    ChocolatelySoftwareInstaller.new('poshgit').for(platform)
  end

  private
  def setup_posh_git (platform)
    environment = EnvironmentPath.new(platform)
    if platform == :windows
      environment.append 'C:\\Program Files (x86)\\git\\bin'
    end
  end
end