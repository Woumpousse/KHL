.SECONDEXPANSION:

.PHONY: upload images

-include $(KHL_ROOT)/shared.mk


DIRECTORY=bop/quizzes/`basename "$$PWD"`

all:
	cat usage.txt

exercises.tex: exercises.rb exercises.java exercises.template
	ruby exercises.rb latex > exercises.tex

exercises.pdf: exercises.tex
	pdflatex exercises.tex

exercises.txt: exercises.rb exercises.java
	ruby exercises.rb toledo "http://$(URL)/$(DIRECTORY)/ex%02d.png" > exercises.txt

images: exercises.pdf
	$(IMAGEMAGICK) -density 200 -quality 90 -trim exercises.pdf ex%02d.png

clean:
	rm -f exercises.tex exercises.pdf exercises.txt ex??.png exercises.zip *~

upload: images exercises.txt
	$(call EXPORT_TO_SERVER,$(DIRECTORY)) 
