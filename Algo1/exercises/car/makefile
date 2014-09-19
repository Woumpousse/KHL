.PHONY: doc

-include $(KHL_ROOT)/shared.mk

all: doc

doc:
	make -C doc all

zip: doc
	rm -f car.zip
	$(EXPORTS) . | dos2unix | xargs $(ZIP) car.zip

upload: zip
	$(call UPLOAD,car.zip,algo1/exercises)

