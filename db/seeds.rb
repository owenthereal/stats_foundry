user = User.create!(:email => "owen.ou@statsfoundry.com", :password => "111111")
table = Table.create!(:user => user, :name => "StatsFoundary Analytics")
{ "visited_at" => DateTimeColumn, "url" => TextColumn, "ip" => TextColumn }.each do |column_name, column_type|
  column_type.create!(:type => column_type.name, :table => table, :name => column_name)
end
