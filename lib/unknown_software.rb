class UnknownSoftware
  def configure_for(platform)
    puts "Software #{@software} is not supported for #{platform}"
  end

  def set_software(software)
    @software = software
  end

  def install_for(platform)
    puts "Software #{@software} is not supported for #{platform}"
  end

  private
  @software
end