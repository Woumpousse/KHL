.PHONY: cleantemp arrays recursion 2d-arrays car conditionals loops

ifeq ($(OS),Windows_NT)
ZIP = 7z a
else
ZIP = zip
endif

SHARED = *.js *.css

ZIP_SHARED = $(ZIP) $(1).zip $(SHARED)
ZIP_EXPORT = cat $(1)/export | awk '{printf "$(1)/%s\n", $$0}' | xargs $(ZIP) $(1).zip


all: conditionals 2d-arrays arrays recursion car loops

conditionals arrays 2d-arrays recursion car loops:
	make -C $@
	rm -f $@.zip
	$(call ZIP_SHARED,$@)
	$(call ZIP_EXPORT,$@)


lazy.js: lazy.ts
	tsc -t ES5 lazy.ts

clean: cleantemp
	rm -f *.zip
