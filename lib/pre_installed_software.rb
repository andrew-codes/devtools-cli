class PreInstalledSoftware
  def configure_for(platform)
    puts "Software #{@software} is pre-installed for #{platform}"
  end

  def set_software(software)
    @software = software
  end

  def install_for(platform)
    puts "Software #{@software} is pre-installed for #{platform}"
  end

  private
  @software
end