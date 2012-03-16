require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new do |t|
  t.files   = ["app/**/*.rb",
               "lib/**/*.rb"]
  t.options = ["--readme=README",
               "--no-private",
               "--charset=UTF-8",
               "--output-dir=doc"]
  t.options << "--debug" << "--verbose" if $trace
end
