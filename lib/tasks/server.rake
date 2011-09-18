namespace :server do
  desc "Starts up server"
  task :start do
    sh 'bundle exec foreman start -f Procfile.local'
  end
end
