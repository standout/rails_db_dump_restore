require 'rails_db_dump_restore'
require 'rails'

module RailsDbDumpRestore
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../../tasks/db.rake', __FILE__)
    end
  end
end
