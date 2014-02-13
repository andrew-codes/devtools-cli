class PowerShell
  def run(command)
    system "powershell #{command}"
  end

  def run_cmd(command)
    system "cmd.exe #{command}"
  end
end