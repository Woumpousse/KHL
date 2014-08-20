.PHONY: assignment solution doc clean

ifeq ($(OS),Windows_NT)
ZIP = 7z a
else
ZIP = zip
endif

ASSIGNMENT = opgave.zip
SOLUTION = opgave-met-oplossingen.zip

all: $(ASSIGNMENT) $(SOLUTION)

$(ASSIGNMENT): doc
	$(ZIP) $(ASSIGNMENT) src tests
	cat doc/export | awk '{printf "doc/%s\n", $$0}' | xargs $(ZIP) $(ASSIGNMENT)

$(SOLUTION): doc
	$(ZIP) a $(SOLUTION) src tests solution
	cat doc/export | awk '{printf "doc/%s\n", $$0}' | xargs $(ZIP) $(SOLUTION)

doc:
	$(MAKE) -C doc

clean:
	rm -f $(ASSIGNMENT) $(SOLUTION)
	rm -r -f bin
	make -C doc clean
