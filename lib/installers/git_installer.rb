require_relative '../chocolatey'

class GitInstaller
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('git').for(platform)
    @chocolately_installer.isntall('poshgit').for(platform)
  end

  private
  @chocolately_installer
end