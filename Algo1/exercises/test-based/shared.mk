.PHONY: zip

-include ../../shared.mk

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
