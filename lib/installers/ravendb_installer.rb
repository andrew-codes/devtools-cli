require_relative '../chocolatey'

class RavenDbInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('ravendb').for(platform)
  end

  private
  @chocolately_installer
end