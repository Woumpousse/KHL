.PHONY: doc

-include $(KHL_ROOT)/shared.mk

all: doc

doc:
	make -C doc all

zip:
	ruby ../exports.rb . | dos2unix | xargs $(ZIP) car.zip

