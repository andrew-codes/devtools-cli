require_relative '../software'

class Nodejs < Software
  def name
    :nodejs
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst nodejs'
    end
    @shell.run 'npm install grunt-cli -g'
    @shell.run 'npm install gulp -g'
    @shell.run 'npm install yeoman -g'
  end

  def configure_for(platform)

  end
end