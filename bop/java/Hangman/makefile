.PHONY: doc clean assignment_source_zip solution_source_zip

-include zip.mk
-include ssh.mk


ASSIGNMENT_SOURCE_ZIP = source.zip
SOLUTION_SOURCE_ZIP = solution.zip

REMOTE_DIRECTORY = $(ROOT_REMOTE_DIRECTORY)/exercises/Hangman/

all:


assignment_source_zip:
	$(ZIP) $(ASSIGNMENT_SOURCE_ZIP) src tests

solution_source_zip:
	$(ZIP) $(SOLUTION_SOURCE_ZIP) src tests solution

source_zips: assignment_source_zip solution_source_zip

upload_source: source_zips
	$(call UPLOAD,$(ASSIGNMENT_SOURCE_ZIP),$(REMOTE_DIRECTORY))
	$(call UPLOAD,$(SOLUTION_SOURCE_ZIP),$(REMOTE_DIRECTORY))

upload: upload_source
	make -C doc upload

doc:
	make -C doc
