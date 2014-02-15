require_relative 'unknown_software'

class SoftwareLibrary
  def initialize(software_collection)
    @software_collection = software_collection
  end

  def get(software)
    @software_collection.each { |software_installer|
      if software_installer.is_a_match software
        return software_installer
      end
    }
    UnknownSoftware.new software
  end

  private
  @software_collection
end