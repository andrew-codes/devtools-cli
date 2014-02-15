require_relative '../software'

class PoshGit < Software
  def name
    :posh_git
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst poshgit', platform
    end
  end

  def configure_for(platform)

  end
end