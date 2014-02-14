class UnknownSoftware
  def initialize(software)
    @software = software
  end

  def for(platform)
    puts "Software #{@software} is not supported for #{platform}"
  end

  private
  @software
end