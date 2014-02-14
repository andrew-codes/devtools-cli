require_relative '../chocolatey'

class RubyMineInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('RubyMine').for(platform)
  end

  private
  @chocolately_installer
end