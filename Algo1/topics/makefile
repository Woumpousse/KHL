PORT = 22345

ifeq ($(OS),Windows_NT)
ZIP = 7z a
DROPBOX_FOLDER = /cygdrive/g/Dropbox/KHLeuven/Algo1/1415
SCP=scp2 -P $(PORT)
SSH=ssh2
else
ZIP = zip
DROPBOX_FOLDER = /cygdrive/g/Dropbox/KHLeuven/Algo1/1415
SCP=scp -P $(PORT)
SSH=ssh
endif

LOGIN = u0057764
URL = alexander.khleuven.be
DIRECTORY = /var/www/algo1/slides/
ZIP_FILE = slides.zip
UPLOAD = $(ZIP_FILE)


.PHONY: $(TOPICS) dropbox zip upload

all: $(TOPICS)

dropbox: $(TOPICS)
	find . -name *.pdf | xargs -I{} cp -v {} $(DROPBOX_FOLDER)/slides

zip: $(TOPICS)
	rm -f $(ZIP_FILE)
	find . -name *.pdf | xargs $(ZIP) $(ZIP_FILE)

upload_single:
	echo Use make UPLOAD=file
	$(SCP) $(UPLOAD) $(LOGIN)@$(URL):$(DIRECTORY)

upload: zip
	$(SCP) $(ZIP_FILE) $(LOGIN)@$(URL):$(DIRECTORY)	
	$(SSH) -p $(PORT) $(LOGIN)@$(URL) 'cd $(DIRECTORY); unzip -o $(ZIP_FILE)'

$(TOPICS):
	make -C $@
