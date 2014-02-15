require_relative 'software'

class SupportedSoftware
  def self.get_all
    Software.list
  end
end