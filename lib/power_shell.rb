class PowerShell
  @@pids = []

  def self.run(command)
    system "powershell.exe #{command} && exit"
  end

  def self.run_cmd(command)
    system "cmd.exe #{command} && exit"
  end
end