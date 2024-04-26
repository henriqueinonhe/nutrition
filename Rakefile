# frozen_string_literal: true

task :default do
  ruby './src/main.rb'
end

task :setup do
  ruby './src/scripts/setup.rb'
end

task :test do
  sh 'bundle exec rspec'
end

task :sandbox do
  ruby './src/sandbox.rb'
end

task :console do
  ruby './src/scripts/console.rb'
end

task :lint do
  sh 'bundle exec rubocop'
end

task :'lint:fix' do
  sh 'bundle exec rubocop -a'
end

task :'lint:force_fix' do
  sh 'bundle exec rubocop -A'
end
