.SECONDEXPANSION:

.PHONY: current current-html export


all: icons export current


-include shared.mk
-include icons.mk

PORT = 22345

ifeq ($(OS),Windows_NT)
SCP=scp2 -P $(PORT)
SSH=ssh2
else
SCP=scp -P $(PORT)
SSH=ssh
endif

CURRENT=basics
LOGIN = u0057764
URL = alexander.khleuven.be
DIRECTORY = /var/www/bop/exercises/
ZIP_FILE = $(CURRENT).zip



clean: clean_icons
	rm -f *~


%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@



zip: current
	echo *.css *.png basics.html *.js | xargs $(ZIP) $(ZIP_FILE)

upload: zip
	$(SCP) $(ZIP_FILE) $(LOGIN)@$(URL):$(DIRECTORY)	
	$(SSH) -p $(PORT) $(LOGIN)@$(URL) 'cd $(DIRECTORY); unzip -o $(ZIP_FILE)'


current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
