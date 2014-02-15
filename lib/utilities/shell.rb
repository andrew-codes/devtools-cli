class Shell
  def initialize(platform)
    @platform = platform
  end

  def self.run(command)
    if @platform == :windows
      system "powershell.exe #{command} && exit"
    else
      system command
    end
  end
end