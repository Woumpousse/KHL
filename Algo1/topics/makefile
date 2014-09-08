DROPBOX_FOLDER = /cygdrive/g/Dropbox/KHLeuven/Algo1/1415

.PHONY: $(TOPICS) dropbox

all: $(TOPICS)

dropbox: $(TOPICS)
	find . -name *.pdf | xargs -I{} cp -v {} $(DROPBOX_FOLDER)/slides

$(TOPICS):
	make -C $@
