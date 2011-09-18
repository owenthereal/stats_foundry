user = User.create!(:email => "owen.ou@statsfoundry.com", :password => "111111")
table = Table.create!(:user => user, :name => "StatsFoundary Analytics")
{ "visited_at" => Column::DateTimeColumn, "url" => Column::TextColumn, "ip" => Column::TextColumn }.each do |column_name, column_type|
  column_type.create!(:table => table, :name => column_name)
end
