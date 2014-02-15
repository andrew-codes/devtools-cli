require_relative 'software'
Dir['software/*.rb'].each { |file|
  require_relative file
}

class SupportedSoftware
  def self.get_all
    Software.list
  end
end