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

  def self.get_all
    @software
  end

  private
  @software

  def populate_software
    software_collection = []
    software = get_software_list
    software.each { |software_name|
      software_collection.push({
                                   software_name => {
                                       :installer => Object.const_get("#{software_name}Installer").new,
                                       :configurator => Object.const_get("#{software_name}Configurator").new
                                   }
                               })
    }
    software_collection
  end

  def get_software_list
    [
        :Git,
        :Nodejs,
        :SublimeText3
    ]
  end
end