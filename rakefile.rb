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
    		task "windows:software:#{arg}".to_sym do ; end
    		task "osx:software:#{arg}".to_sym do ; end
  		end
	end
end

namespace :windows do
	desc "Installs required windows software"
	task :install, [:software] => 'common:parameters' do
		ARGV.each { |software|
			sh "cinst #{software}"
		}
	end

	desc "Installs and configures windows software"
	task :configure, [:software] => :install do |t, args|
		ARGV.each { |software|
			Rake::Task["windows:software:#{software}"].invoke
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
			gitconfigTemplate = File.read('global-software-configuration/git/gitconfig.mustache')
			File.open("#{Dir.home}/.gitconfig", 'w') do |file|
				file.puts Mustache.render(gitconfigTemplate, gitconfigModel)
			end
	
			#global gitignore
			gitignoreModel = Hash.new
			gitignoreTemplate = File.read('global-software-configuration/git/gitignore.mustache')
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
			FileUtils.cp 'global-software-configuration/sublime-text-3/packages.sublime-settings', "'#{Dir.home}/AppData/Roaming/Sublime Text 3/Packages/User/Package Control.sublime-settings'"
			# Include desired packages in settings file
		end
	end
end

namespace :osx do
	desc "Installs required osx software"
	task :install,  [:software] => 'common:parameters' do
		
	end

	desc "Installs and configures osx software"
	task :configure, [:software] => :install do |t, args|
		ARGV.each { |software|
			Rake::Task["osx:software:#{software}"].invoke
		}
	end
	
	namespace :software do
		desc "Configure git for osx"
		task :git do
			puts 'Configuring git for OSX'
		end
	end
end