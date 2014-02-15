require_relative '../software'

class RubyMine < Software
  def name
    :rubymine
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst RubyMine', platform
    end
  end

  def configure_for(platform)

  end
end