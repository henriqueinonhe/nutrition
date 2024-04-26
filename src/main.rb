# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/src")
loader.ignore("#{Dir.pwd}/src/**/*.spec.rb")
loader.setup

# App

container = RootContainer

container.get(:command_line).start
