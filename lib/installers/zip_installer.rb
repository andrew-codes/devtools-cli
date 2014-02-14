require_relative '../chocolatey'

class ZipInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('7zip').for(platform)
  end

  private
  @chocolately_installer
end