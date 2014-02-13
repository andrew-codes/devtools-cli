class PowerShell
  def self.run(command)
    system "powershell try{#{command}} catch[system.exception] {write-host $error[0]} finally{ exit }"
  end

  def self.run_cmd(command)
    system "cmd.exe #{command}"
  end
end