class SoftwareInstaller
  def initialize(software)
    if defined? software.is_pre_installed?
      @is_installed = software.is_pre_installed?
    else
      @is_installed = false
    end
    @software = software
  end

  def is_a_match(software)
    software == @software.name
  end

  def is_installed?
    @is_installed
  end

  def install_for(platform)
    unless self.is_installed?
      puts "Begin installation of #{@software.name} on #{platform}"
      @software.install_for(platform)
      @is_installed = true
      puts "Finished installation of #{@software.name} on #{platform}"
    end
    puts "Begin configuration of #{@software.name} on #{platform}"
    @software.configure_for(platform)
    puts "Finish configuration of #@software.name} on #{platform}"

  end

  private
  @is_installed
  @software
end