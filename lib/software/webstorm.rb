require_relative '../software'

class WebStorm < Software
  def name
    :webstorm
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst WebStorm', platform
    end
  end

  def configure_for(platform)

  end
end