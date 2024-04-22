require "zeitwerk"
require "json"

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/src")
loader.push_dir("#{Dir.pwd}/src/testing")
loader.ignore("#{Dir.pwd}/src/**/*.spec.rb")
loader.setup

ENV["ENV"] = "test"

root_dir_path = Dir.pwd
src_dir_path = root_dir_path + "/src"

test_files_paths = Dir.glob("#{src_dir_path}/**/*").filter do |path|
  path.end_with? ".spec.rb"
end

test_files_paths.each do |path|
  require path
end

Test::run