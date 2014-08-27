@echo off
del test.db
ruby generate.rb > create.sql
sqlite3 -init queries.sql test.db .quit