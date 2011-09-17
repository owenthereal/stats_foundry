user = Factory(:user, :email => "owen.ou@statsfoundry.com", :password => "111111")
table = Factory(:table, :user => user, :name => "StatsFoundary Analytics")
{ "visited_at" => :date_time_column, "url" => :text_column, "ip" => :text_column }.each do |column_name, column_type|
  Factory(column_type, :table => table, :name => column_name)
end
