class EnvironmentPath
  def initialize(platform)
    @platform = platform
  end

  def append(path)
    if @platform == :windows
      PowerShell.run("Add-PathVariable '#{path}'")
    end
  end
end