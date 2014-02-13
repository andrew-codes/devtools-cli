require 'configatron'
require_relative '../power_shell'
require 'git'

class SublimeText3Configurator
  def initialize

  end

  def for(platform)
    set_configuration platform
    set_path platform
    #associate_files platform
    package_control platform
    add_packages platform
    configure_settings platform
  end

  private
  def set_configuration(platform)
    if platform == :windows
      @packages_path = "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages"
      @file_associations = {
          '.log' => 'logfile',
          '.yml' => 'yamlfile',
          '.json' => 'jsfile',
      }
    end
  end

  def configure_settings (platform)
    create_user_packages_path
    FileUtils.cp "#{configatron.devtools}/global-software-configuration/sublime-text-3/preferences.sublime-settings", "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages/User/Preferences.sublime-settings"
  end

  def create_user_packages_path
    user_packages_path = "#{@packages_path}/User"
    FileUtils.mkpath user_packages_path
  end

  def add_packages (platform)
    create_user_packages_path
    FileUtils.cp "#{configatron.devtools}/global-software-configuration/sublime-text-3/packages.sublime-settings", "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages/User/Package Control.sublime-settings"
  end

  def package_control (platform)
    package_control_path = "#{@packages_path}"
    FileUtils.mkpath package_control_path
    system "cd #{@packages_path} && git clone https://github.com/wbond/sublime_package_control.git && git pull"
  end

  def associate_files (platform)
    sublime_exe_path = "'#{@sublime_path}\\sublime_text.exe'"
    @file_associations.each_pair { |key, value|
      PowerShell.run_cmd "assoc #{key}=#{value}"
      PowerShell.run_cmd "ftype #{value}=#{sublime_exe_path}"
    }
    PowerShell.run_cmd "ftype txtfile=#{sublime_exe_path}"
  end

  def set_path(platform)
    @sublime_path = 'C:\\Program Files\\Sublime Text 3'
    #set_path_command = "setx PATH '$env.path;#{@sublime_path}' /m"
    #PowerShell.run(set_path_command)
  end

  @file_associations
  @packages_path
end