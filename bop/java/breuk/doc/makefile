.SECONDEXPANSION:

.PHONY: current zip upload


all: current

-include $(KHL_ROOT)/shared.mk
-include icons.mk




clean: clean_icons
	rm -f *~


%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = breuk

current: icons
	ruby Generate.rb --output $(CURRENT)-intermediary.html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
	ruby latex.rb --input $(CURRENT)-intermediary.html --output $(CURRENT).html --latex $(CURRENT).tex
	pdflatex $(CURRENT).tex
	$(IMAGEMAGICK) -quality 90 -density 150 -trim $(CURRENT).pdf latex%d.png

zip: current
	$(call ZIP_EXPORTS,.,$(CURRENT).zip)

upload: zip
	$(call REMOTE_EXECUTE,"cd $(REMOTE_ROOT_DIRECTORY)/bop/exercises; mkdir -p $(CURRENT)")
	$(call UPLOAD,$(CURRENT).zip,bop/exercises/$(CURRENT))
	$(call REMOTE_EXECUTE,"cd $(REMOTE_ROOT_DIRECTORY)/bop/exercises/$(CURRENT); unzip -o $(CURRENT).zip")
