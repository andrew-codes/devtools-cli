class PreInstalledSoftware
  def for(platform)
    puts "Software #{@software} is pre-installed for #{platform}"
  end

  def set_software(software)
    @software = software
  end

  private
  @software
end