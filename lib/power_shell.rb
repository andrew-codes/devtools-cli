require 'fileutils'

class PowerShell
  def self.run(command)
    Fileutils.open('tmp/command.ps1', 'w') do |file|
      file.puts(command)
    end
    system "powershell ./tmp/command.ps1"
  end

  def self.run_cmd(command)
    self.run("cmd.exe #{command}")
  end
end