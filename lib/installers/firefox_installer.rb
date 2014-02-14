require_relative '../chocolatey'

class FirefoxInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('Firefox').for(platform)
  end

  private
  @chocolately_installer
end