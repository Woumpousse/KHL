PORT = 22345

ifeq ($(OS),Windows_NT)
SCP=scp2 -P $(PORT) -W g:/pw
SSH=ssh2 -p $(PORT) -W g:/pw
ZIP = 7z a
else
SCP=scp -P $(PORT)
SSH=ssh -p $(PORT)
ZIP = zip
endif

URL = alexander.khleuven.be
ROOT_REMOTE_DIRECTORY = /var/www

# $(call UPLOAD,file,directory)
UPLOAD=$(SCP) $(1) $(KHL_LOGIN)@$(URL):$(ROOT_REMOTE_DIRECTORY)/$(2)

# $(call REMOTE_EXECUTE,command)
REMOTE_EXECUTE=$(SSH) $(1)
