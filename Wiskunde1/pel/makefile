.PHONY: sessions zip upload

ifeq ($(OS),Windows_NT)
ZIP = 7z a
SCP=scp2 -P 22345 -W g:/pw
SSH=ssh2 -p 22345 -W g:/pw
else
ZIP = zip
SCP=scp -P 22345 -W ~/pw
SSH=ssh -p 22345 -W ~/pw
endif

ZIP_FILE=pel.zip
LOGIN = u0057764
URL = alexander.khleuven.be
REMOTE_DIRECTORY = /var/www/tw1/pel


all: sessions

sessions:
	find . -mindepth 1 -maxdepth 1 -type d | xargs --max-args=1 make -C

zip: sessions
	ruby exports.rb $(SESSIONS) | dos2unix | xargs $(ZIP) $(ZIP_FILE)

upload: zip
	$(SCP) $(ZIP_FILE) $(LOGIN)@$(URL):$(REMOTE_DIRECTORY)
	$(SSH) $(LOGIN)@$(URL) 'cd $(REMOTE_DIRECTORY); unzip -o $(ZIP_FILE)'

clean:
	rm -f *.zip
