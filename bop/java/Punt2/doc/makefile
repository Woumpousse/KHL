.SECONDEXPANSION:

.PHONY: current upload


all: current

-include $(KHL_ROOT)/shared.mk
-include icons.mk




clean: clean_icons
	rm -f *~


%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = punt2

current: icons
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2

upload: current
	$(call EXPORT_TO_SERVER,bop/exercises/punt2)
