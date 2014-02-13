class PowerShell
  def self.run(command)
    system "powershell Try{ #{command} } Catch {write-host $error[0] } Finally { exit }"
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}" )
  end
end