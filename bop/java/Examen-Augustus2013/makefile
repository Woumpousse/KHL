.PHONY: assignment solution doc clean

ZIP = 7z
DOCS = doc/*.html doc/*.css doc/*.png doc/*.js
ASSIGNMENT = $(DOCS) src tests
SOLUTION = solution


all: assignment solution

assignment: doc
	$(ZIP) a opgave.zip $(ASSIGNMENT)

solution: doc
	$(ZIP) a opgave-met-oplossingen.zip $(ASSIGNMENT) $(SOLUTION)

doc:
	$(MAKE) -C doc

clean:
	rm -f opgave.zip opgave-met-oplossingen.zip
	rm -r -f bin
	make -C doc clean

