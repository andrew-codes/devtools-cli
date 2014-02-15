require_relative '../software'

class Nodejs < Software
  def name
    :nodejs
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst nodejs', platform
    end
    @shell.run 'npm install grunt-cli -g', platform
    @shell.run 'npm install gulp -g', platform
    @shell.run 'npm install yeoman -g', platform
  end

  def configure_for(platform)

  end
end