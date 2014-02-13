require_relative '../chocolatey'

class ChocolatelySoftwareInstaller
  def initialize(software)
    @software = software
    if @@windows_installer.nil?
      @@windows_installer = Chocolatey.new
    end
  end

  def install_for(platform)
    if platform == :windows
      @@windows_installer.install(@software)
    end
  end

  private
  @@windows_installer
  @software
end