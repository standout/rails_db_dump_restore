# gem install rails_db_dump_restore

### rake tasks

```bash
# Dump database to tmp/database.dump
rake db:dump
# development database dumped to tmp/database.dump

# Replace database with contents of tmp/database.dump
rake db:restore
# development database replaced with contents of tmp/database.dump
```

### capistrano tasks

```bash
# Replace local database with a remote one
cap production db:pull
# Dumps production database to remote tmp/database.dump
# Downloads the dumpfile to local tmp/database.dump
# Replaces local database with contents of tmp/database.dump
```

Add `require 'capistrano/rails_db_dump_restore'` to your `Capfile`

## Quirks
Only works with `postgresql` and `mysql2` database adapters as of now. You should add support for others.
