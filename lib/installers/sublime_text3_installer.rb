require_relative '../chocolatey'

class SublimeText3Installer
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('SublimeText3').for(platform)
  end

  private
  @chocolately_installer
end