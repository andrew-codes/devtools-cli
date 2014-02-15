require_relative '../software'

class SevenZip < Software
  def name
    :zip
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst 7zip'
    end
  end

  def configure_for(platform)

  end
end