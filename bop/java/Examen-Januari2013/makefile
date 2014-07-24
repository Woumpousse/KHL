.PHONY: assignment solution doc clean

ZIP = 7z

all: assignment solution

assignment: doc
	$(ZIP) a assignment.zip doc\opgave.zip src tests

solution: doc
	$(ZIP) a solution.zip doc\opgave.zip src tests solution

doc:
	$(MAKE) -C doc

clean:
	del /s /q bin
	rmdir bin
	cd doc & make clean

