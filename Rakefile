#!/usr/bin/env rake
require "bundler/gem_tasks"

task :package => [:build, :preinstall]
task :clean do
  sh 'rm -rf pkg'
end
task :preinstall do
  sh "gem install haml ../cxx/pkg/*.gem"
end

task :default => :package
