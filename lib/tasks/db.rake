namespace :db do
  desc "Dump database to #{RailsDbDumpRestore::DUMPFILE}"
  task dump: [:environment] do
    RailsDbDumpRestore::Database.new.dump
  end

  desc "Replace database with contents of #{RailsDbDumpRestore::DUMPFILE}"
  task restore: [:environment] do
    RailsDbDumpRestore::Database.new.restore
  end
end
