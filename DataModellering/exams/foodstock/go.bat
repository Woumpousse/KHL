@echo off
del food.db
sqlite3 -init create.sql food.db