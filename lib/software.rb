require_relative 'software_installer'
require_relative 'utilities/shell'

class Software
  def initialize(shell)
    @shell = shell
  end

  class << self
    attr_reader :list
  end
  @list = []

  def self.inherited(klass)
    @list << SoftwareInstaller.new(klass.new(Shell.new))
  end
end