.SECONDEXPANSION:

.PHONY: zip current current-html export

-include $(KHL_ROOT)/shared.mk

URL = "I pity the fool who forgets to specify the url"


all:
	cat usage.txt

exercises.tex: exercises.rb exercises.java
	ruby exercises.rb latex > exercises.tex

exercises.pdf: exercises.tex
	pdflatex exercises.tex

exercises.txt: exercises.rb exercises.java
	ruby exercises.rb toledo $(URL) > exercises.txt

images: exercises.pdf
	$(IMAGEMAGICK) -density 200 -quality 90 -trim exercises.pdf ex%02d.png

exercises.zip: images
	$(ZIP) exercises.zip ex??.png

clean:
	rm -f exercises.tex exercises.pdf exercises.txt ex??.png exercises.zip *~
