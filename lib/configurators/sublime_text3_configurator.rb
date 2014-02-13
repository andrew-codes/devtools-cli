require 'configatron'
require_relative '../power_shell'
require 'git'

class SublimeText3Configurator
  def initialize

  end

  def configure_for(platform)
    self.setConfiguration platform
    self.setPath platform
    self.associateFiles platform
    self.packageControl platform
    self.addPackages platform
    self.configureSettings platform
  end

  private
  def setConfiguration(platform)
    if platform == :windows
      @packagesPath = "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages"
      @fileAssociations = {
          '.log' => 'logfile',
          '.yml' => 'yamlfile',
          '.json' => 'jsfile',
      }
    end
  end

  def configureSettings (platform)
    self.createUserPackagesPath
    FileUtils.cp "#{configatron.devtools}/global-software-configuration/sublime-text-3/preferences.sublime-settings", "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  end

  def createUserPackagesPath
    userPackagesPath = "#{@packagesPath/User}"
    if !File.exists? userPackagesPath
      FileUtils.mkpath userPackagesPath
    end
  end

  def addPackages (platform)
    self.createUserPackagesPath
    FileUtils.cp "#{configatron.devtools}/global-software-configuration/sublime-text-3/packages.sublime-settings", "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages/User/Package Control.sublime-settings"
  end

  def packageControl (platform)
    if !File.exists? @packagesPath
      FileUtils.mkpath @packagesPath
    end
    packageControlPath = "#{@packagesPath}/Package Control"
    packageInstallerRepo = Git.clone(' git : // github.com/wbond/sublime_package_control.git ', '', :path => packageControlPath)
    packageInstallerRepo = Git.open(packageControlPath)
    packageInstallerRepo.pull
  end

  def associateFiles (platform)
    sublimeExePath = "'#{sublimePath}\\sublime_text.exe'"
    @fileAssociations.each_pair do |key, value|
      PowerShell.run_cmd "assoc #{key}=#{value}"
      PowerShell.run_cmd "ftype #{value}=#{sublimeExe}"
    end
    PowerShell.run_cmd "ftype txtfile=#{sublimeExe}"
  end

  def setPath(platform)
    sublimePath = 'C:\\Program Files\\Sublime Text 3'
    setPathCommand = "powershell [Environment]::SetEnvironmentVariable(\"#{sublimePath}\", $env:Path, [System.EnvironmentVariableTarget]::Machine)"
    PowerShell.run(setPathCommand)
  end

  @fileAssociations
  @packagesPath
end