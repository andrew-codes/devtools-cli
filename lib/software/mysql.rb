require_relative '../software'

class MySql< Software
  def name
    :mysql
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst mysql'
      @shell.run 'cinst mysql.workbench'
    end
  end

  def configure_for(platform)

  end
end