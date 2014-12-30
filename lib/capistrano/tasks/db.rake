namespace :db do
  def self.dumpfile
    "tmp/database.dump"
  end

  def dumpfile
    self.class.dumpfile
  end

  desc "Dump remote database to #{dumpfile}"
  task :dump do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:dump"
        end
      end
    end
  end

  desc "Download dumped database from remote to local"
  task download: ["db:dump"] do
    on roles(:app) do
      path = "#{current_path}/#{dumpfile}"
      puts "Fetching #{path} to #{dumpfile}"
      download! path, dumpfile
    end
  end

  desc "Replace local database with a remote one"
  task pull: ["db:download"] do
    run_locally do
      with rails_env: :development do
        system "rake", "db:restore"
      end
    end
  end
end
