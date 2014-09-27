.SECONDEXPANSION:

.PHONY: zip current


all: icons current

-include $(KHL_ROOT)/shared.mk
-include icons.mk
-include ../../shared.mk

ZIP_FILE = $(CURRENT).zip

clean: clean_icons
	rm -f *~

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@

current:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2

zip: current
	rm -f $(ZIP_FILE)
	$(call ZIP_EXPORTS,.,$(ZIP_FILE))

upload: zip
	$(call REMOTE_EXECUTE,"cd $(REMOTE_ROOT_DIRECTORY)/$(EXERCISES_ROOT); mkdir -p $(CURRENT)")
	$(call UPLOAD,$(ZIP_FILE),$(EXERCISES_ROOT)/$(CURRENT))
	$(call REMOTE_EXECUTE,"cd $(REMOTE_ROOT_DIRECTORY)/$(EXERCISES_ROOT)/$(CURRENT); unzip -o $(ZIP_FILE)")
