require 'mustache'

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
			gitConfiguration = Hash.new
			gitConfiguration[:alias] = ''
			gitTemplate = File.read('global_-software-configuration/git/gitconfig.mustache')
			puts Mustache.render(gitTemplate, gitConfiguration)
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