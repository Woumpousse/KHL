.PHONY: assignment solution doc clean

ZIP = 7z
DOCS = doc/*.html doc/*.css doc/*.png doc/*.js
ASSIGNMENT = opgave.zip
SOLUTION = opgave-met-oplossingen.zip



all: $(ASSIGNMENT) $(SOLUTION)

$(ASSIGNMENT): doc
	$(ZIP) a $(ASSIGNMENT) src tests
	cat doc/export | awk '{printf "doc/%s\n", $$0}' | xargs $(ZIP) a $(ASSIGNMENT)

$(SOLUTION): doc
	$(ZIP) a $(SOLUTION) src tests solution
	cat doc/export | awk '{printf "doc/%s\n", $$0}' | xargs 7z a $(SOLUTION)

doc:
	$(MAKE) -C doc

clean:
	rm -f $(ASSIGNMENT) $(SOLUTION)
	rm -r -f bin
	make -C doc clean


