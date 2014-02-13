class PowerShell
  def self.run(command)
    system " #{command}"
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}")
  end
end