require "highline"

task :default => [:spec]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |test|
  test.verbose = true
end

desc "run this task to generate a working xpca.yml config file"
task :config do
  basedir = File.dirname(__FILE__)
  template = File.join(basedir, 'config', 'template.yml')
  config = File.read(template)
  highline = HighLine.new
  account_code = highline.ask("Account code: ")
  license_code = highline.ask("License code: ")
  config = config.sub 'XXXXX00000', account_code
  config = config.sub 'AA00-BB11-CC22-DD33', license_code
  template = File.join(basedir, 'config', 'xpca.yml')
  File.open(template, "w+") { |f| f.puts config }
end
