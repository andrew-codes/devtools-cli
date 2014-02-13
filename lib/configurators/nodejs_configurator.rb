require_relative '../power_shell'

class NodejsConfigurator
  def for(platform)
    if (platform == :windows)
      PowerShell.run 'npm install gulp -g'
      PowerShell.run 'npm install grunt-cli -g'
      PowerShell.run 'npm install yeoman -g'
    end
  end
end