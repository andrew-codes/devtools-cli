namespace :common do
	desc "Enables array arguments"
	task :parameters, :parameters do |t, args| 
		ARGV.shift
		ARGV.each do |arg|
    		task arg.to_sym do ; end
  		end
	end
end

namespace :windows do
	desc "Installs required windows software"
	task :install, [:software] => 'common:parameters' do
		ARGV.each { |software|
			exec "cinst #{software}"
		}
	end

	desc "Configures windows software"
	task :configure, [:software] => :install do
	end
end

namespace :osx do
	desc "Installs required osx software"
	task :install,  [:software] => 'common:parameters' do
		
	end

	desc "Configures osx software"
	task :configure, [:software] => :install do
	end
end
