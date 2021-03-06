PORT = 22345

ifeq ($(OS),Windows_NT)
DROPBOX_ROOT_DIRECTORY = /cygdrive/g/Dropbox/KHLeuven
SCP=scp2 -P $(PORT) -W g:/pw
SSH=ssh2 -p $(PORT) -W g:/pw
ZIP = 7z a
TYPESCRIPT = tsc
EXPORTS = ruby `cygpath -w $(KHL_ROOT)/exports.rb`
else
DROPBOX_DIRECTORY = TODO
SCP=scp -P $(PORT)
SSH=ssh -p $(PORT)
ZIP = zip
TYPESCRIPT = true
EXPORTS = ruby $(KHL_ROOT)/exports.rb
endif

URL = alexander.khleuven.be
REMOTE_ROOT_DIRECTORY = /var/www
IMAGEMAGICK = convert
LATEX = pdflatex


# $(call REMOTE_EXECUTE,command)
REMOTE_EXECUTE=$(SSH) $(KHL_LOGIN)@$(URL) $(1)

# $(call UPLOAD,file,directory)
UPLOAD=$(SCP) $(1) $(KHL_LOGIN)@$(URL):$(REMOTE_ROOT_DIRECTORY)/$(2)

# $(call ZIP_EXPORTS,directory,zip)
ZIP_EXPORTS=$(EXPORTS) $(1) | dos2unix | xargs $(ZIP) $(2)

# $(call EXPORT_TO_SERVER,directory)
EXPORT_TO_SERVER=$(call ZIP_EXPORTS,.,package.zip);$(call REMOTE_EXECUTE,"mkdir -p $(REMOTE_ROOT_DIRECTORY)/$(1)");$(call UPLOAD,package.zip,$(1));rm package.zip;$(call REMOTE_EXECUTE,"cd $(REMOTE_ROOT_DIRECTORY)/$(1);unzip -o package.zip")
