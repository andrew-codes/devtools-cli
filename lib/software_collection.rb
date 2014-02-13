Dir.glob('configurators/*.rb') do |file|
  require_relative file
end
Dir.glob('installers/*.rb') do |file|
  require_relative file
end

class SoftwareCollection
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
    software = self.get_software_list
    software.each { |software_name|
      software_collection.push({
                                   software_name => {
                                       :installer => "#{software_name}Installer".constantize.new,
                                       :configurator => "#{software_name}Configurator".constantize.new
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