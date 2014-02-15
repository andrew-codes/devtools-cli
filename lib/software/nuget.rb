require_relative '../software'

class Nuget < Software
  def name
    :nuget
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst NuGet', platform
      @shell.run 'cinst NuGet.CommandLine', platform
    end
  end

  def configure_for(platform)

  end
end