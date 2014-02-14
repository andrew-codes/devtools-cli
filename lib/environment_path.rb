class EnvironmentPath
  def initialize(platform)
    @platform = platform
  end

  def append(path)
    if platform == :windows
      PowerShell.run("Set-PathVariable #{path}")
    end
  end
end