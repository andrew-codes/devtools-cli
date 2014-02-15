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

  end
end