ifeq ($(OS),Windows_NT)
TYPESCRIPT = tsc
else
TYPESCRIPT = true
endif


all: export refimpl.js

refimpl.js: refimpl.ts
	tsc refimpl.ts

clean:
	rm -f refimpl.js
	rm -f export

export:
	echo assignment.html *.js | ruby -e "puts STDIN.read.split" > export
