class PowerShell
  def self.run(command)
  `#{command}`
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}")
  end
end