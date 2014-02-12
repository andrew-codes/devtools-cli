require 'mustache'
require 'open-uri'
require 'rubygems'
require 'git'
require 'fileutils'

namespace :common do
	desc "Enables array arguments"
	task :parameters, :parameters do |t, args| 
		ARGV.shift
		ARGV.each do |arg|
    		task arg.to_sym do ; end
    		task "software:#{arg}".to_sym do ; end
  		end
	end
end

desc "Pre-provisioning environemnt setup"
task :provision_setup do |t, args|
	sh 'powershell set-executionpolicy Unrestricted -force'
	sh "iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))"
end

desc "Provision and install software"
task :provision, [:software] => ['common:parameters', :provision_setup] do |t, args|	
	ARGV.each { |software|
		sh "cinst #{software}"
	}
end

desc "Configure software"
task :configure, [:software] => ['common:parameters'] do |t, args|	
	ARGV.each { |software|
		Rake::Task["software:#{software}"].invoke
	}
end

namespace :software do
	desc "Configure git for windows"
	task :git do
		puts 'Configuring git for windows'
		# gitconfig
		gitconfigModel = Hash.new
		gitconfigModel[:alias] = ''
		gitconfigModel[:gitignore] = '~/.gitignore'
		gitconfigTemplate = File.read('../global-software-configuration/git/gitconfig.mustache')
		File.open("#{Dir.home}/.gitconfig", 'w') do |file|
			file.puts Mustache.render(gitconfigTemplate, gitconfigModel)
		end

		# global gitignore
		gitignoreModel = Hash.new
		gitignoreTemplate = File.read('../global-software-configuration/git/gitignore.mustache')
		File.open("#{Dir.home}/.gitignore", 'w') do |file|
			file.puts Mustache.render(gitignoreTemplate, gitignoreModel)
		end
	end

	desc "Configure sublime for windows"
	task :SublimeText3 do
		puts 'Configuring sublime for windows'
		# Set SublimeText as notepad replacement
		sh 'reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /t REG_SZ /d "C:\Program Files\Sublime Text 3\sublime_text.exe" /f'
		# Install Package Control
		$packageInstallerDirectory = "#{Dir.home}/AppData/Roaming/Sublime Text 3/Packages/Package Control"
		if !File.exists? $packageInstallerDirectory
			Dir.mkdir $packageInstallerDirectory
			$packageInstallerRepo = Git.clone('git://github.com/wbond/sublime_package_control.git','', :path=> $packageInstallerDirectory)
		else
			$packageInstallerRepo = Git.open("#{$packageInstallerDirectory}")
			$packageInstallerRepo.pull
		end
		FileUtils.cp '../global-software-configuration/sublime-text-3/packages.sublime-settings', "'#{Dir.home}/AppData/Roaming/Sublime Text 3/Packages/User/Package Control.sublime-settings'"
		# Include desired packages in settings file
	end
end