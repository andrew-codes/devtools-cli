class Shell
  def initialize
  end

  def self.run(command, platform)
    if platform == :windows
      system "powershell.exe #{command} && exit"
    else
      system command
    end
  end
end