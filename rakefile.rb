require 'mustache'
require 'open-uri'
require 'rubygems'
require 'git'
require 'fileutils'
require 'configatron'
require_relative 'lib/provisioner_locator'
require_relative 'lib/power_shell'

configatron.home = Dir.home
configatron.devtools = "#{Dir.home}/devtools"
platform = :windows
software_to_provision = []
provisioner = ProvisionerLocator.new

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
  provisioner.pre_install(platform)
  software_to_provision.each { |software|
    provisioner.install(software).for(platform)
  }
  PowerShell.pids.each { |pid|
    Process.kill 'INT', pid
  }
end

desc 'Configure software'
task :configure, [:software] => ['common:parameters'] do |t, args|
  software_to_provision.each { |software|
    provisioner.configure(software).for(platform)
  }
  PowerShell.pids.each { |pid|
    Process.kill 'INT', pid
  }
end