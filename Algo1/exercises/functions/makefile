ifeq ($(OS),Windows_NT)
TYPESCRIPT = tsc
else
TYPESCRIPT = true
endif


all: export solutions.js

solutions.js: solutions.ts
	tsc solutions.ts

clean:
	rm -f solutions.js

export:
	echo assignment.html *.js | ruby -e "puts STDIN.read.split" > export
