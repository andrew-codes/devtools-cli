Dir[
    "#{File.dirname(__FILE__)}/configurators/*.rb",
    "#{File.dirname(__FILE__)}/installers/*.rb"
].each { |file|
  require file
}

class SoftwareCollectionProvider
  def initialize
    @software = populate_software
  end

  def get_all
    @software
  end

  private
  @software

  def populate_software
    software_collection = []
    software = get_supported_software
    software.each { |software_name|
      software_collection.push({
                                   :name => software_name,
                                   :installer => Object.const_get("#{software_name}Installer").new,
                                   :configurator => Object.const_get("#{software_name}Configurator").new
                               })
    }
    software_collection
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
        :RavenDb
    ]
  end
end