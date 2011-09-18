namespace :server do
  desc "Starts up server"
  task :start do
    sh 'bundle exec foreman start -f Procfile.development'
  end
end
