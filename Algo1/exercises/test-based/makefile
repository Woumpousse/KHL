.PHONY: libs

LIBS = underscore.js jquery.js clone.js util.js lazy.js test-framework.js html-tests.js

all:

libs:
	find . -mindepth 1 -type d | xargs -I{} sh -c "cat $(LIBS) > '{}/libs.js'"

css:
	find . -mindepth 1 -type d | xargs -I{} sh -c "cat assignment.css > '{}/assignment.css'"

update: libs css

zip:
	find . -mindepth 1 -type d | xargs -I{} make -C {} zip

clean:
	find . -mindepth 1 -type d | xargs -I{} make -C {} clean
	rm -f *~
