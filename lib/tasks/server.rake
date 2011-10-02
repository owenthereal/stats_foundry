desc "Starts up development server"
task :server do
  sh 'bundle exec foreman start -f Procfile.development'
end
