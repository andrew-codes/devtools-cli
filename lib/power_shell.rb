class PowerShell
  def self.run(command)
    system "powershell -Command { Try{ #{command} } Catch {write-host $error[0] } }"
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}" )
  end
end