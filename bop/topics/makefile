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
REMOTE_DIRECTORY = /var/www/tw1/slides

all: slides

slides:
	find . -mindepth 1 -maxdepth 1 -type d | xargs --max-args=1 make -C

upload:
	find . -mindepth 1 -maxdepth 1 -type d | xargs --max-args=1 -I{} make -C {} upload

zip: slides
	find . -name *.pdf | xargs $(ZIP) slides.zip
