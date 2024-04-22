require "zeitwerk"
require "json"

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/src")
loader.ignore("#{Dir.pwd}/src/**/*.spec.rb")
loader.setup

Interface::CommandLine.new(
  reader: Interface::Reader,
  writer: Interface::Writer
).start



