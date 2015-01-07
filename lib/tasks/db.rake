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

      run """
        PGPASSWORD=#{password}
        pg_dump #{args}
        --host=#{host}
        --username=#{username}
        --dbname=#{database}
        --file=#{path}
      """
    when "mysql2"
      run """
        MYSQL_PWD=#{password}
        mysqldump
        --host=#{host}
        --user=#{username}
        #{database} > #{path}
      """
    end

    puts "#{Rails.env.to_s} database dumped to #{dumpfile}"
  end

  desc "Replace database with contents of #{dumpfile}"
  task restore: [:environment] do
    path = "#{Rails.root}/#{dumpfile}"
    case ActiveRecord::Base.connection_config[:adapter]
    when "postgresql"
      run """
        PGPASSWORD=#{password}
        psql
        --host=#{host}
        --username=#{username}
        --dbname=#{database}
        --file=#{path}
      """
    when "mysql2"
      run """
        MYSQL_PWD=#{password}
        mysql
        --host=#{host}
        --user=#{username}
        #{database} < #{path}
      """
    end

    puts "#{Rails.env.to_s} database replaced with contents of #{dumpfile}"
  end

  def run(multiline_command)
    command = squeeze_into_one_line(multiline_command)

    if ENV["DEBUG"]
      puts command
    else
      system command
    end
  end

  def host
    ActiveRecord::Base.connection_config[:host]
  end

  def username
    ActiveRecord::Base.connection_config[:username] || ENV["USER"]
  end

  def password
    ActiveRecord::Base.connection_config[:password]
  end

  def database
    ActiveRecord::Base.connection_config[:database]
  end

  def squeeze_into_one_line(multiline_string)
    multiline_string.strip.gsub("\n", " ").squeeze(" ")
  end
end
