.PHONY: zip_code upload_code upload

-include $(KHL_ROOT)/shared.mk

all:

zip_code:
	$(ZIP) source.zip src tests

upload_code: zip_code
	$(call REMOTE_EXECUTE,"cd /var/www/bop/exercises; mkdir -p breuk")
	$(call UPLOAD,source.zip,bop/exercises/breuk)

upload: upload_code
	make -C doc upload
