.PHONY: doc

all: doc export

doc:
	make -C doc all

export:
	echo assignment.html *.js *.png | ruby -e "puts STDIN.read.split" > export
	echo doc/assignment.pdf >> export

clean:
