namespace :dev do
  
  task :rebuild => ["db:drop","dev:build"]
  task :build => ["tmp:clear", "log:clear", "db:create", "db:migrate", "dev:fake"]
  
  task :fake => :environment do
    puts Rails.env
  end
  
end