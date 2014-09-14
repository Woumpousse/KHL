.SECONDEXPANSION:

.PHONY: current current-html export


all: icons export current


-include shared.mk
-include icons.mk

PORT = 22345

ifeq ($(OS),Windows_NT)
PASSWORD_LOCATION = g:/pw
SCP=scp2 -P $(PORT)
SSH=ssh2
else
PASSWORD_LOCATION = ~/pw
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

export:
	echo *.css *.png *.js *.html | ruby -e "puts STDIN.read.split" > export

zip: export current
	cd ..; cat $(CURRENT)/export | awk '{printf "$(CURRENT)/%s\n", $$0}' | xargs $(ZIP) $(CURRENT)/$(CURRENT).zip

upload: zip
	$(SCP) -W $(PASSWORD_LOCATION) $(ZIP_FILE) $(LOGIN)@$(URL):$(DIRECTORY)	
	$(SSH) -W $(PASSWORD_LOCATION) -p $(PORT) $(LOGIN)@$(URL) 'cd $(DIRECTORY); unzip -o $(ZIP_FILE)'


current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2
