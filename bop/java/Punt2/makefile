.PHONY: upload

-include $(KHL_ROOT)/shared.mk

ZIP_FILE=punt2.zip

all:
	echo Does nothing

upload_source:
	$(ZIP) $(ZIP_FILE) src
	$(call UPLOAD,$(ZIP_FILE),bop/exercises/punt2)

upload: upload_source
	make -C doc upload
