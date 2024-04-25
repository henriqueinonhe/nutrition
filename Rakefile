task :default do
  ruby "./src/main.rb"
end

task :setup do
  ruby "./src/scripts/setup.rb"
end

task :test do
  sh "bundle exec rspec"
end

task :sandbox do
  ruby "./src/sandbox.rb"
end

task :console do
  ruby "./src/scripts/console.rb"
end