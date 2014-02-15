require_relative '../software'

class RavenDb < Software
  def name
    :ravendb
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst RavenDb'
    end
  end

  def configure_for(platform)

  end
end