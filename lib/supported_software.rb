class SupportedSoftware
  def self.get_all
    software = []
    before = ObjectSpace.each_object(Class).to_a
    Dir['software/*.rb'].each { |file|
      require_relative file
    }
    after = ObjectSpace.each_object(Class).to_a
    (after-before).map { |klass|
      software.push klass.new
    }
    software
  end
end