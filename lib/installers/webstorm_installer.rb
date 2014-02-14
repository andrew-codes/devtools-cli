require_relative '../chocolatey'

class WebStormInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('WebStorm').for(platform)
  end

  private
  @chocolately_installer
end