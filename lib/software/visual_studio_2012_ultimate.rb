require_relative '../software'

class VisualStudio2012Ultimate < Software
  def name
    :visual_studio_2012
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst VisualStudio2012Ultimate', platform
      @shell.run 'cinst Dogtail.VS2012.3', platform
      @shell.run 'cinst ReSharper', platform
      @shell.run 'cinst dotPeek', platform
    end
  end

  def configure_for(platform)
    if platform == :windows
      import_settings 'solarized-dark.vssettings '
    end
  end

  private
  @visual_studio_exe = 'C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe'

  def import_settings(settings_file)
    @shell.run "'#{@visual_studio_exe}' /Command 'Tools.ImportandExportSettings /import:#{configuratron.devtools}/settings/windows/visual-studio-2012/#{settings_file}'"
  end
end