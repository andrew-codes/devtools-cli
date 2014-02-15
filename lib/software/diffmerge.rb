require_relative '../software'

class DiffMerge < Software
  def name
    :diffmerge
  end

  def install_for(platform)
    if platform == :windows
      @shell.run 'cinst DiffMerge'
    end
  end

  def configure_for(platform)

  end
end