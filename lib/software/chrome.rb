require_relative '../software'

class Chrome < Software
  def name
    :chrome
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst GoogleChrome', platform
    end
  end

  def configure_for(platform)

  end
end