require_relative '../software'

class FireFox < Software
  def name
    :firefox
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst Firefox', platform
    end
  end

  def configure_for(platform)

  end
end