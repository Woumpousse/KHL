.PHONY: zip upload

-include ../../shared.mk

# TODO: fix this
ZIP_EXPORTS=ruby $(KHL_ROOT)/exports.rb . | xargs $(ZIP) $(CURRENT).zip

all: refimpl.js

refimpl.js: refimpl.ts
	$(TYPESCRIPT) refimpl.ts

clean:
	rm -f refimpl.js *~ $(CURRENT.zip)

zip: refimpl.js
	rm -f $(CURRENT).zip
	$(call ZIP_EXPORTS,.,$(CURRENT).zip)

upload: zip
	$(call UPLOAD,$(CURRENT).zip,$(EXERCISES_ROOT))
