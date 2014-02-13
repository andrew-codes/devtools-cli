class PowerShell
  def self.run(command)
  `powershell #{command} && exit`
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}")
  end
end