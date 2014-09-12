-include ../shared.mk


all: refimpl.js export

refimpl.js: refimpl.ts
	$(TYPESCRIPT) refimpl.ts

clean:
	rm -f refimpl.js
	rm -f export

export:
	echo assignment.html *.js | ruby -e "puts STDIN.read.split" > export
