require '../power_shell'

class NodejsConfigurator
  def configure_for(platform)
    sh 'npm install gulp -g'
    sh ' npm install grunt-cli -g'
    sh ' npm install yeoman -g'
  end
end