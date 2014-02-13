class PowerShell
  def self.run(command)
    Process.spawn "PowerShell", "exec \"powershell #{command}\""
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}")
  end
end