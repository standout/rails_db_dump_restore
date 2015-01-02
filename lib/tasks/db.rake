namespace :db do
  def self.dumpfile
    RailsDbDumpRestore::DUMPFILE
  end

  def dumpfile
    self.class.dumpfile
  end

  desc "Dump database to #{dumpfile}"
  task dump: [:environment] do
    system "mkdir -p $(dirname #{dumpfile})"
    path = "#{Rails.root}/#{dumpfile}"
    case ActiveRecord::Base.connection_config[:adapter]
    when "postgresql"
      args = "--clean --no-owner --no-privileges"

      system "PGPASSWORD=#{pw} pg_dump #{args} -U #{us} -d #{db} -f #{path}"
    when "mysql2"
      system "MYSQL_PWD=#{pw} mysqldump -u #{us} #{db} > #{path}"
    end

    puts "#{Rails.env.to_s} database dumped to #{dumpfile}"
  end

  desc "Replace database with contents of #{dumpfile}"
  task restore: [:environment] do
    path = "#{Rails.root}/#{dumpfile}"
    case ActiveRecord::Base.connection_config[:adapter]
    when "postgresql"
      system "PGPASSWORD=#{pw} psql -U #{us} -d #{db} -f #{path}"
    when "mysql2"
      system "MYSQL_PWD=#{pw} mysql -u #{us} #{db} < #{path}"
    end

    puts "#{Rails.env.to_s} database replaced with contents of #{dumpfile}"
  end

  def us
    ActiveRecord::Base.connection_config[:username] || ENV["USER"]
  end

  def pw
    ActiveRecord::Base.connection_config[:password]
  end

  def db
    ActiveRecord::Base.connection_config[:database]
  end
end
