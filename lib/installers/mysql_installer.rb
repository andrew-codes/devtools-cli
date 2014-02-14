require_relative 'chocolately_software_installer'

class MySqlInstaller
  def for(platform)
    ChocolatelySoftwareInstaller.new('mysql').for(platform)
    ChocolatelySoftwareInstaller.new('mysql.workbench').for(platform)
  end
end