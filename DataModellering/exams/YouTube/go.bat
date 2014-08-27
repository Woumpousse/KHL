@echo off
del test.db
ruby generate.rb
sqlite3 -init queries.sql test.db .quit