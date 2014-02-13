require_relative 'unknown_software'
require_relative 'software_collection_provider'
require_relative 'pre_installed_software'
require_relative 'power_shell'

class ProvisionerLocator
  def initialize
    @unknown_software = UnknownSoftware.new
    @pre_installed_software = PreInstalledSoftware.new
    software_collection_provider = SoftwareCollectionProvider.new
    @software_collection = software_collection_provider.get_all
    @pre_installed_software_collection = [
        :Git,
        :Ruby
    ]
  end

  def install(software)
    get_for(software)[:installer]
  end

  def configure(software)
    get_for(software)[:configurator]
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
      return {
          :installer => @pre_installed_software,
          :configurator => @pre_installed_software
      }
    end
    @software_collection.each { |item|
      if item.object_id == software.object_id
        return item
      end
    }
    @unknown_software.set_software software
    {
            :installer => @unknown_software,
            :configurator => @unknown_software
        }
  end
end