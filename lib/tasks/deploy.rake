namespace :deploy do
  desc "Deploys to StatsFoundary production."
  task :production do
    sh "heroku pgbackups:capture --expire"
    sh "git push heroku master"
    sh "heroku run rake db:migrate"
  end
end
