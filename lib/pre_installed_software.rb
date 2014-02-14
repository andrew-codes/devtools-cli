class PreInstalledSoftware
  def initialize(software)
    @software = software
  end

  def for(platform)
    puts "Software #{@software} is pre-installed for #{platform}"
  end

  private
  @software
end