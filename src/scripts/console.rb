require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/src")
loader.ignore("#{Dir.pwd}/src/**/*.spec.rb")
loader.setup

binding.irb