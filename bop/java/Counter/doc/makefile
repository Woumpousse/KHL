.SECONDEXPANSION:

.PHONY: current zip upload


all: icons current


ifeq ($(OS),Windows_NT)
ZIP = 7z a
SCP=scp2 -P 22345 -W g:/pw
SSH=ssh2 -p 22345 -W g:/pw
else
ZIP = zip
SCP=scp -P 22345 -W ~/pw
SSH=ssh -p 22345 -W ~/pw
endif

ZIP_FILE = Counter.zip
LOGIN = u0057764
URL = alexander.khleuven.be
REMOTE_DIRECTORY = /var/www/bop/exercises/Counter



-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

%.pdf: %.tex
	$(LATEX) $<

%.png: %.pdf
	$(IMAGEMAGICK) -quality 90 -density 300 $< $@


CURRENT = counter

current: current-html

current-html:
	ruby Generate.rb --output $(CURRENT).html --template $(CURRENT).template --require ./$(CURRENT).rb --class Resources -p 2

zip: current
	ruby exports.rb . | dos2unix | xargs $(ZIP) $(ZIP_FILE)

upload: zip
	$(SCP) $(ZIP_FILE) $(LOGIN)@$(URL):$(REMOTE_DIRECTORY)
	$(SSH) $(LOGIN)@$(URL) "cd $(REMOTE_DIRECTORY); unzip $(ZIP_FILE)"
