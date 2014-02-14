require_relative 'software_library'
require_relative 'power_shell'

class ProvisionerLocator
  def initialize
    @software_library = SoftwareLibrary.new
  end

  def install(software)
    @software_library.get_installer_for(software)
  end

  def configure(software)
    @software_library.get_configurator_for(software)
  end

  private
  @software_library
end