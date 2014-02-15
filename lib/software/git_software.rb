require_relative '../software'
require_relative 'diffmerge'
require_relative 'posh_git'

class GitSoftware < Software
  def name
    :git
  end

  def is_pre_installed?
    true
  end

  def install_for(platform)
    if platform == :windows
      @shell.run "cinst 'git'", platform
    end
  end

  def configure_for(platform)
    add_to_path platform
    gitconfig platform
    gitignore platform
    additional_tools platform
  end

  private

  def additional_tools(platform)
    diff_merge = DiffMerge.new @shell
    diff_merge.install_for platform
    diff_merge.configure_for platform
    posh_git = PoshGit.new @shell
    posh_git.install_for platform
    posh_git.configure_for platform
  end

  def add_to_path(platform)
    if platform == :windows
      @shell.run "Add-PathVariable 'C:\\Program Files (x86)\\Git\\bin'", platform
    end
  end

  def gitconfig(platform)
    gitconfig_model = Hash.new
    git_alias = ''
    if platform == :osx
      git_alias = "gui !sh -c '/usr/local/git/libexec/git-core/git-gui'"
    end
    gitconfig_model[:alias] = git_alias
    gitconfig_model[:gitignore] = "#{configatron.home}/.gitignore"
    gitconfig_template = File.read("#{configatron.devtools}/settings/global/git/gitconfig.mustache")
    gitconfig_contents = Mustache.render(gitconfig_template, gitconfig_model)
    File.open("#{configatron.home}/.gitconfig", 'w') do |file|
      file.puts gitconfig_contents
    end
  end

  def gitignore(platform)
    gitignore_model = Hash.new
    gitignore_template = File.read("#{configatron.devtools}/settings/global/git/gitignore.mustache")
    File.open("#{configatron.home}/.gitignore", 'w') do |file|
      file.puts Mustache.render(gitignore_template, gitignore_model)
    end
  end
end