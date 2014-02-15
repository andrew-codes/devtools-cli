require 'mustache'
require 'open-uri'
require 'rubygems'
require 'git'
require 'fileutils'
require 'configatron'
require_relative 'lib/software_library'

configatron.home = Dir.home
configatron.devtools = "#{Dir.home}/devtools"
platform = :windows
software_to_provision = []
supported_software = SupportedSoftware.get_all
software_library = SoftwareLibrary.new supported_software

namespace :common do
  desc 'Enables array arguments'
  task :parameters, :parameters do |t, args|
    ARGV.shift
    platform = ARGV[0].to_sym
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