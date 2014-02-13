require 'configatron'

class GitConfigurator
  def initialize
    @gitConfigPath = "#{configatron.devtools}/global-software-configuration/git"
  end

  def for(platform)
    self.gitconfig
    self.gitignore
  end

  private

  def gitignore
    gitignoreModel = Hash.new
    gitignoreTemplate = File.read("#{@gitConfigPath}/gitignore.mustache")
    File.open("#{configatron.home}/.gitignore", 'w') do |file|
      file.puts Mustache.render(gitignoreTemplate, gitignoreModel)
    end
  end

  def gitconfig
    gitconfigModel = Hash.new
    gitconfigModel[:alias] = ''
    gitconfigModel[:gitignore] = "#{configatron.home}/.gitignore"
    gitconfigTemplate = File.read("#{@gitConfigPath}/gitconfig.mustache")
    File.open("#{configatron.home}/.gitconfig", 'w') do |file|
      file.puts Mustache.render(gitconfigTemplate, gitconfigModel)
    end
  end

  @gitConfigPath
end