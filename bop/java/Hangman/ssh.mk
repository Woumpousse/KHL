ifeq ($(OS),Windows_NT)
SCP=scp2 -P 22345 -W g:/pw
SSH=ssh2 -p 22345 -W g:/pw
else
SCP=scp -P 22345 -W ~/pw
SSH=ssh -p 22345 -W ~/pw
endif

LOGIN = u0057764
URL = alexander.khleuven.be
ROOT_REMOTE_DIRECTORY = /var/www/bop

# $(call UPLOAD,file,directory)
UPLOAD=$(SCP) $(1) $(LOGIN)@$(URL):$(2)
