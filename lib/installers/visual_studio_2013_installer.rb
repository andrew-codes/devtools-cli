require_relative '../chocolatey'

class VisualStudio2012Installer
  def initialize
    @chocolately_installer = Chocolatey.new
  end

  def for(platform)
    @chocolately_installer.install('VisualStudio2013Ultimate').for(platform)
    @chocolately_installer.install('ReSharper').for(platform)
    @chocolately_installer.install('dotPeek').for(platform)
  end

  private
  @chocolately_installer
end