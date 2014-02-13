class PowerShell
  def self.run(command)
    system "powershell #{command} && exit"
  end

  def self.run_cmd(command)
    system "cmd.exe #{command}"
  end
end