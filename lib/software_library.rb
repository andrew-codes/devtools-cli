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
    software_collection.each { |software|
      @software_installers[software] = nil
      @software_installers[software] = Object.const_get("#{software}Installer").new
      @software_configurators[software] = Object.const_get("#{software}Configurator").new
    }
    @software_installers[:Ruby] = PreInstalledSoftware.new :Ruby
  end

  def get_supported_software
    [
        :Git,
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
        :Firefox
    ]
  end
end