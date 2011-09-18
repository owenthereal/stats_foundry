namespace :deploy do
  desc "Deploys to StatsFoundary production."
  task :production do
    sh "heroku pgbackups:capture --expire"
    sh "git push heroku master"
    sh "heroku run rake db:migrate"
  end

  namespace :production do
    desc "Deploys to StatsFoundary proudction and reset the database with seeds."
    task :reset => 'deploy:production' do
      sh "heroku run rake db:reset"
    end
  end
end
