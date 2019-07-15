require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'
desc 'Run RSpec'
RSpec::Core::RakeTask.new { |t| t.verbose = false }
task default: :spec
Coveralls::RakeTask.new
