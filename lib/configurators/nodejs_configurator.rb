require_relative '../power_shell'

class NodejsConfigurator
  def for(platform)
    system 'npm install gulp -g'
    system 'npm install grunt-cli -g'
    system 'npm install yeoman -g'
  end
end