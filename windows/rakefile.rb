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
	system 'powershell set-executionpolicy Unrestricted -force'
	system "powershell iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))"
end

desc "Provision and install software"
task :provision, [:software] => ['common:parameters', :provision_setup] do |t, args|	
	ARGV.each { |software|
		system "powershell cinst #{software}"
	}
end

desc "Configure software"
task :configure, [:software] => ['common:parameters'] do |t, args|	
	ARGV.each { |software|
		Rake::Task["software:#{software.gsub(/[.]/, "_")}"].invoke
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
		# Put sublime on PATH
		$sublimePath = 'C:\\Program Files\\Sublime Text 3'
		$setPathCommand = %Q|powershell [Environment]::SetEnvironmentVariable("#{$sublimePath}", $env:Path, [System.EnvironmentVariableTarget]::Machine)|
		system $setPathCommand
		# Set SublimeText file associations
		$sublimeExe = "'#{$sublimePath}\\sublime_text.exe'"
		system 'assoc .log=logfile'
		system 'assoc .yml=yamlfile'
		system 'assoc .json=jsonfile'
		system 'assoc .gitconfig=gitfile'
		system 'assoc .gitignore=gitfile'
		system "ftype txtfile=#{$sublimeExe}"
		system "ftype logfile=#{$sublimeExe}"
		system "ftype yamlfile=#{$sublimeExe}"
		system "ftype jsonfile=#{$sublimeExe}"		
		system "ftype CSSfile=#{$sublimeExe}"	
		system "ftype gitfile=#{$sublimeExe}"
		# Install Package Control
		$packageInstallerDirectory = "#{Dir.home}/AppData/Roaming/Sublime Text 3/Packages"
		if !File.exists? $packageInstallerDirectory
			FileUtils.mkpath $packageInstallerDirectory
			$packageInstallerRepo = Git.clone('git://github.com/wbond/sublime_package_control.git','Package Control', :path=> $packageInstallerDirectory)
		else
			$packageInstallerRepo = Git.open("#{$packageInstallerDirectory}")
			$packageInstallerRepo.pull
		end
		# Install packages & settings
		if !File.exists? "#{$packageInstallerDirectory}/User"
			FileUtils.mkpath "#{$packageInstallerDirectory}/User"
		end
		FileUtils.cp '../global-software-configuration/sublime-text-3/packages.sublime-settings', "#{Dir.home}/AppData/Roaming/Sublime Text 3/Packages/User/Package Control.sublime-settings"
		FileUtils.cp '../global-software-configuration/sublime-text-3/preferences.sublime-settings', "#{Dir.home}/AppData/Roaming/Sublime Text 3/Packages/User/Preferences.sublime-settings"
	end

	desc "Configure nodejs for windows"
	task :nodejs do
		# Install nodejs global modules
		system' npm install gulp -g'
		system' npm install grunt-cli -g'
		system' npm install yeoman -g'
	end
end