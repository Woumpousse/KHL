CONVERT = convert
IMAGE_OPTIONS = -quality 90 -density 300 -trim


all: suv.png city.png

%.pdf: %.tex
	pdflatex $<

%.png: %.pdf
	$(CONVERT) $(IMAGE_OPTIONS) $< $@
