require 'mustache'
require 'open-uri'
require 'rubygems'
require 'git'
require 'fileutils'
require 'configatron'
require_relative 'lib/software_library'
require_relative 'lib/software'
Dir['lib/software/*.rb'].each { |file|
  require_relative file
}

configatron.home = Dir.home
configatron.devtools = "#{configatron.home}/devtools"
platform = :windows
software_to_provision = []
supported_software = Software.list
software_library = SoftwareLibrary.new supported_software

namespace :common do
  desc 'Enables array arguments'
  task :parameters, :parameters do |t, args|
    ARGV.shift
    platform = ARGV[0].to_sym
    task platform do
      ;
    end
    ARGV.shift
    ARGV.each do |arg|
      item = arg.to_sym
      software_to_provision.push item
      task item do
        ;
      end
    end
  end
end

desc 'Provision and install software'
task :provision, [:software] => ['common:parameters'] do |t, args|
  software_to_provision.each { |software|
      software_library.get(software).install_for(platform)
  }
end