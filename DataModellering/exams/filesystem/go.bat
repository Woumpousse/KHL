@echo off
del filesystem.db
sqlite3 -init create.sql filesystem.db