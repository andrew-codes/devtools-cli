require_relative '../power_shell'

class NodejsConfigurator
  def for(platform)
    sh 'npm install gulp -g'
    sh ' npm install grunt-cli -g'
    sh ' npm install yeoman -g'
  end
end