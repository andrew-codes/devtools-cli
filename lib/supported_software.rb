require_relative 'software_installer'
require_relative 'utilities/shell'

class SupportedSoftware
  def self.get_all
    shell = Shell.new
    software = []
    before = ObjectSpace.each_object(Class).to_a
    Dir['software/*.rb'].each { |file|
      require_relative file
    }
    after = ObjectSpace.each_object(Class).to_a
    (after-before).map { |klass|
      software.push SoftwareInstaller.new(klass.new(shell))
    }
    software
  end
end