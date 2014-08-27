.PHONY: test

test:
	sqlite3 -init queries.sql test.db .quit

test.db: generate.rb create.sql
	rm -f test.db
	ruby generate.rb

clean:
	rm -f test.db *~

