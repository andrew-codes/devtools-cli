class UnknownSoftware
  def for(platform)
    puts "Software #{@software} is not supported for #{platform}"
  end

  def set_software(software)
    @software = software
  end

  private
  @software
end