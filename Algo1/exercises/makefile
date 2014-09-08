ifeq ($(OS),Windows_NT)
ZIP = 7z a
else
ZIP = zip
endif

TEST_BASED_EXERCISES = conditionals 2d-arrays arrays recursion loops functions binary
OTHER_EXERCISES = car fundamentals conditionals-interpret loops-interpret functions-interpret recursion-interpret arrays-interpret
SHARED = *.js *.css
ALL_EXERCISES = $(TEST_BASED_EXERCISES) $(OTHER_EXERCISES)
DROPBOX_FOLDER = /cygdrive/g/Dropbox/KHLeuven/Algo1/1415

.PHONY: cleantemp $(ALL_EXERCISES)


ZIP_SHARED = $(ZIP) $(1).zip $(SHARED)
ZIP_EXPORT = cat $(1)/export | awk '{printf "$(1)/%s\n", $$0}' | xargs $(ZIP) $(1).zip


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
	cp -v *.zip $(DROPBOX_FOLDER)/oefeningen

refimpl:
	echo $(TEST_BASED_EXERCISES) | sed 's/\s/\n/g' | xargs -I{} make -C {} refimpl.js

lazy.js: lazy.ts
	tsc -t ES5 lazy.ts

clean: cleantemp
	echo $(ALL_EXERCISES) | sed 's/\s/\n/g' | xargs -I{} make -C {} clean
	rm -f *.zip
