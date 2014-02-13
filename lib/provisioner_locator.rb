require_relative 'unknown_software'
require_relative 'software_collection'
require_relative 'pre_installed_software'
require_relative 'power_shell'

class ProvisionerLocator
  def initialize
    @unknown_software = UnknownSoftware.new
    @pre_installed_software = PreInstalledSoftware.new
    @software_collection = SoftwareCollection.get_all
    @pre_installed_software_collection = [
        :Git,
        :Ruby
    ]
  end

  def install(software)
    self.get_for(software).installer
  end

  def configure(software)
    self.get_for(software).configurator
  end

  def pre_install(platform)
        if platform == :windows
          PowerShell.run 'set-executionpolicy Unrestricted -force'
        end
  end

  private
  @software_collection
  @unknown_software
  @pre_installed_software_collection
  @pre_installed_software

  def get_for(software)
     if @pre_installed_software_collection.include? software
       @pre_installed_software.set_software software
       @pre_installed_software
     end
    @software_collection.each { |item|
      if item == software
        return item
      end
    }
    @unknown_software.set_software software
    @unknown_software
  end
end