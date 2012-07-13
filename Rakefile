#!/usr/bin/env rake
require "bundler/gem_tasks"

task :package => :build
task :clobber_package do
  sh 'rm -rf pkg'
end

task :default => :package
