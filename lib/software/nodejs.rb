require_relative '../software'

class Nodejs < Software
  def name
    :nodejs
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst nodejs.install', platform
    end
    @shell.run '$env:Path = [System.Environment]::GetEnvironmentVariable(\"Path\",\"Machine\")', platform
    @shell.run 'npm install grunt-cli -g', platform
    @shell.run 'npm install gulp -g', platform
    @shell.run 'npm install yeoman -g', platform
  end

  def configure_for(platform)

  end
end