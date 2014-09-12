PORT=22345

ifeq ($(OS),Windows_NT)
ZIP = 7z a
DROPBOX_FOLDER = /cygdrive/g/Dropbox/KHLeuven/Algo1/1415
SCP=scp2 -P 22345
SSH=ssh2
else
ZIP = zip
DROPBOX_FOLDER = /cygdrive/g/Dropbox/KHLeuven/Algo1/1415
SCP=scp -P $(PORT)
SSH=ssh
endif

LOGIN = u0057764
URL = alexander.khleuven.be:/var/www/algo1/slides/
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
	$(SCP) $(UPLOAD) $(LOGIN)@$(URL)

upload: zip
	$(SCP) $(ZIP_FILE) $(LOGIN)@$(URL)
	$(SSH) -p $(PORT) $(LOGIN)@$(URL) 'cd /var/www/algo1/slides; unzip slides.zip'

$(TOPICS):
	make -C $@
