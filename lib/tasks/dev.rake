namespace :dev do
  
  task :rebuild => ["db:drop","dev:build"]
  task :build => ["tmp:clear", "log:clear", "db:create", "db:migrate", "db:seed", "dev:fake"]
  
  task :fake => :environment do
  end

end