require_relative '../chocolatey'

class ChocolatelySoftwareInstaller
  def initialize()
    if @@windows_installer.nil?
      @@windows_installer = Chocolatey.new
    end
  end

  def install_for(software, platform)
    if platform == :windows
      @@windows_installer.install(software)
    end
  end

  private
  @@windows_installer = nil
end