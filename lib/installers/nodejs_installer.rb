require_relative '../chocolatey'

class NodejsInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('nodejs').for(platform)
    @chocolately_installer.install('nodejs.commandline').for(platform)
  end

  private
  @chocolately_installer
end