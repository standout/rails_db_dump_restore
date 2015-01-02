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

## Testing the cap db:pull task
`test/dummy` has been set up to deploy with capistrano locally to `test/dummy-deploy`
```bash
cd test/dummy
bundle exec cap postgres deploy
RAILS_ENV=postgres bundle exec cap postgres db:pull
```

```bash
cd test/dummy
bundle exec cap mysql deploy
RAILS_ENV=mysql bundle exec cap mysql db:pull
```
Or use these rake tasks

`rake dummy:postgres`

`rake dummy:mysql`

## Testing databases
You need to have working postgres and mysql installation on your machine.
You also need to create the databases.
```bash
(cd test/dummy && RAILS_ENV=postgres rake db:create)
(cd test/dummy && RAILS_ENV=mysql    rake db:create)
```
