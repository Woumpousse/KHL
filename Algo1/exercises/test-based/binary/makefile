.PHONY: zip

-include ../../shared.mk

all: refimpl.js

refimpl.js: refimpl.ts
	$(TYPESCRIPT) --out refimpl-maxi.js refimpl.ts
	cat refimpl-maxi.js | ruby minify.rb > refimpl.js

clean:
	rm -f refimpl.js

zip: refimpl.js
	rm -f $(CURRENT).zip
	$(call ZIP_EXPORTS,.,$(CURRENT).zip)

upload: zip
	$(call UPLOAD,$(CURRENT).zip,$(EXERCISES_ROOT))
