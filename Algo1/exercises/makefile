-include $(KHL_ROOT)/shared.mk

DROPBOX_DIRECTORY = $(DROPBOX_ROOT_FOLDER)/Algo1/1415


TEST_BASED_EXERCISES = car conditionals 2d-arrays arrays recursion recursion2 loops functions binary
OTHER_EXERCISES = fundamentals-interpret conditionals-interpret loops-interpret functions-interpret recursion-interpret arrays-interpret
SHARED = *.js *.css
ALL_EXERCISES = $(TEST_BASED_EXERCISES) $(OTHER_EXERCISES)

DROPBOX_DIRECTORY = $(DROPBOX_ROOT_DIRECTORY)/Algo1/1415

.PHONY: cleantemp $(ALL_EXERCISES)

DIRECTORY = algo1/exercises/

ZIP_SHARED = $(ZIP) $(1).zip $(SHARED)
ZIP_EXPORT = cat $(1)/export | awk '{printf "$(1)/%s\n", $$0}' | xargs $(ZIP) $(1).zip
ZIP_FILE = exercises.zip


all: $(ALL_EXERCISES)

$(TEST_BASED_EXERCISES):
	make -C $@
	rm -f $@.zip
	$(call ZIP_SHARED,$@)
	$(call ZIP_EXPORT,$@)

$(OTHER_EXERCISES):
	make -C $@
	rm -f $@.zip
	$(call ZIP_EXPORT,$@)


dropbox: $(ALL_EXERCISES)
	cp -v *.zip $(DROPBOX_DIRECTORY)/oefeningen

zip: $(ALL_EXERCISES)
	rm -f $(ZIP_FILE)
	ls | grep \.zip | xargs $(ZIP) $(ZIP_FILE)

upload: zip
	$(call UPLOAD,$(ZIP_FILE),$(DIRECTORY))
	$(REMOTE_EXECUTE) 'cd $(ROOT_REMOTE_DIRECTORY)/$(DIRECTORY); unzip -o $(ZIP_FILE)'

refimpl:
	echo $(TEST_BASED_EXERCISES) | sed 's/\s/\n/g' | xargs -I{} make -C {} refimpl.js

lazy.js: lazy.ts
	tsc -t ES5 lazy.ts

clean: cleantemp
	echo $(ALL_EXERCISES) | sed 's/\s/\n/g' | xargs -I{} make -C {} clean
	rm -f *.zip
