require_relative 'software_installer'

class UnknownSoftware < SoftwareInstaller
  def initialize(software)
    @software = software
  end

  def install_for(platform)
    puts "Software #{@software} is not supported for #{platform}"
  end

  private
  @software
end