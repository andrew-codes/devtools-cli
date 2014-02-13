class PowerShell
  @@pids = []

  def self.run(command)
    system "powershell.exe #{command} && exit"
  end

  def self.run_cmd(command)
    self.run "cmd.exe #{command} && exit"
  end
end