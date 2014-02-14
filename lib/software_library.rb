require_relative 'unknown_software'
require_relative 'pre_installed_software'
Dir[
    "#{File.dirname(__FILE__)}/configurators/*.rb",
    "#{File.dirname(__FILE__)}/installers/*.rb"
].each { |file|
  require file
}

class SoftwareLibrary
  def initialize
    @software_installers = {}
    @software_configurators = {}
    populate_library
  end

  def get_installer_for(software)
    @software_installers.each_pair { |key, value|
      if software == key
        return value
      end
    }
    UnknownSoftware.new software
  end

  def get_configurator_for(software)
    @software_configurators.each_pair { |key, value|
      if software == key
        return value
      end
    }
    UnknownSoftware.new software
  end

  private
  @software_installers
  @software_configurators

  def populate_library
    software_collection = get_supported_software
    pre_installed_software = get_pre_installed_software
    software_collection.each { |software|
      if pre_installed_software.include? software
        @software_installers[software] = PreInstalledSoftware.new software
      else
        @software_installers[software] = Object.const_get("#{software}Installer").new
      end
      @software_configurators[software] = Object.const_get("#{software}Configurator").new
    }

  end

  def get_pre_installed_software
    [
        :Ruby
    ]
  end

  def get_supported_software
    [
        :Git,
        :Ruby,
        :Nodejs,
        :SublimeText3,
        :Zip,
        :VisualStudio2012,
        :VisualStudio2013,
        :WebStorm,
        :RubyMine,
        :MySql,
        :RavenDb,
        :Chrome,
        :Firefox,
        :DiffMerge
    ]
  end
end