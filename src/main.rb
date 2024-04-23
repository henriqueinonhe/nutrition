require "zeitwerk"
require "json"
require "pry"

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/src")
loader.ignore("#{Dir.pwd}/src/**/*.spec.rb")
loader.setup

# App

container = RootContainer

container.get(:retrieve_weighing_entries).call()
container.get(:command_line).start()


