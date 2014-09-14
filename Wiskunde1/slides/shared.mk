.PHONY: upload

ifeq ($(OS),Windows_NT)
SCP=scp2 -P 22345 -W g:/pw
SSH=ssh2 -p 22345 -W g:/pw
else
SCP=scp -P 22345 -W ~/pw
SSH=ssh -p 22345 -W ~/pw
endif

LOGIN = u0057764
URL = alexander.khleuven.be
REMOTE_DIRECTORY = /var/www/tw1/slides


%.pdf: %.tex
	pdflatex $<

upload: $(CURRENT).pdf
	$(SCP) $(CURRENT).pdf $(LOGIN)@$(URL):$(REMOTE_DIRECTORY)
