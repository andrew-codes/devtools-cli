require_relative '../software'
require_relative 'git_software'

class Chrome < Software
  def name
    :sublime_text_3
  end

  def initialize
    @sublime_path = ''
    @packages_path = ''
    @file_associations = {}
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst SublimeText3', platform
    end
  end

  def configure_for(platform)
    if platform == :windows
      @sublime_path = 'C:\\Program Files\\Sublime'
      @packages_path = "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages"
      @file_associations = {
          '.log' => 'logfile',
          '.yml' => 'yamlfile',
          '.json' => 'jsfile',
      }
    end
    set_environment_path platform
    set_file_associations platform
    install_packages platform
    configure_settings platform
  end

  private
  def configure_settings(platform)

  end

  def install_packages(platform)
    if platform == :windows
      package_control = "#{@packages_path}/Package Control"
      FileUtils.mkpath package_control
      repo = Git.clone('https://github.com/wbond/sublime_package_control.git', '', :path => package_control)
      repo.pull
      user_packages_path = "#{@packages_path}/User"
      FileUtils.mkpath user_packages_path
      FileUtils.cp "#{configatron.devtools}/settings/global/sublime-text-3/packages.sublime-settings", "#{configatron.home}/AppData/Roaming/Sublime Text 3/Packages/User/Package Control.sublime-settings"
    end
  end

  def set_file_associations(platform)
    unless @file_associations == {}
      if platform == :windows
        sublime_exe_path = "'#{@sublime_path}\\sublime_text.exe'"
        @file_associations.each_pair { |key, value|
          @shell.run "cmd /c assoc #{key}=#{value}", platform
          @shell.run "cmd /c ftype #{value}='#{sublime_exe_path}'", platform
        }
        @shell.run "cmd /c ftype txtfile=#{sublime_exe_path}", platform
      end
    end
  end

  @sublime_path
  @packages_path
  @file_associations

  def set_environment_path(platform)
    unless @sublime_path == ''
      if platform == :windows
        @shell.run "Add-PathVariable '#{@sublime_path}'", platform
      end
    end
  end
end