class PowerShell
  @@pids = []

  def self.run(command)
    @@pids.push(Process.spawn "powershell #{command}")
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}")
  end

  def self.kill_all
    @@pids.each { |pid|
      Process.kill 'INT', pid
    }
  end
end