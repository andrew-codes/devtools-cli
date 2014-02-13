require 'mustache'
require 'open-uri'
require 'rubygems'
require 'git'
require 'fileutils'
require 'configatron'
require 'lib/provisioner_locator'

configatron.home = Dir.home
configatron.devtools = "#{Dir.home}/devtools"
platform = :windows
software_to_provision = []

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
      task "software:#{arg}".to_sym do
        ;
      end
    end
  end
end

desc 'Provision and install software'
task :provision, [:software] => ['common:parameters'] do |t, args|
  ProvisionerLocator.pre_install(platform)
  software_to_provision.each { |software|
    ProvisionerLocator.install(software).for(platform)
  }
end

desc 'Configure software'
task :configure, [:software] => ['common:parameters'] do |t, args|
  software_to_provision.each { |software|
    ProvisionerLocator.configure(software).for(platform)
  }
end