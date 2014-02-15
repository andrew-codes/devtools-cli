require_relative '../software'

class VisualStudio2013Ultimate < Software
  def name
    :visual_studio_2012
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst VisualStudio2013Ultimate'
      @shell.run 'cinst ReSharper'
      @shell.run 'cinst dotPeek'
    end
  end

  def configure_for(platform)

  end
end