require_relative 'software_installer'
require_relative 'utilities/shell'

class Software
  @shell = Shell.new

  class << self
    attr_reader :list
  end
  @list = []

  def self.inherited(klass)
    @list << SoftwareInstaller.new(klass.new)
  end
end