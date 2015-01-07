require File.join(File.dirname(__FILE__), *%w[rails_db_dump_restore railtie]) if defined?(::Rails::Railtie)
require File.join(File.dirname(__FILE__), *%w[rails_db_dump_restore dumpfile])
require File.join(File.dirname(__FILE__), *%w[rails_db_dump_restore database])

module RailsDbDumpRestore
end
