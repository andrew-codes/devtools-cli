require_relative '../software'
require_relative 'nuget'

class RavenDb < Software
  def name
    :ravendb
  end

  def install_for(platform)
    if platform == :windows
      nuget = Nuget.new @shell
      nuget.install_for :windows
      @shell.run 'nuget install RavenDB.Server', platform
      @shell.run 'nuget install RavenDB.Client', platform
    end
  end

  def configure_for(platform)

  end
end