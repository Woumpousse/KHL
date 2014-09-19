all: quadratic.pdf

-include $(KHL_ROOT)/shared.mk

quadratic.pdf: quadratic.tex
	pdflatex quadratic.tex
	pdflatex quadratic.tex

upload: quadratic.pdf
	$(call UPLOAD,quadratic.pdf,tw1)

clean:
	rm -f *~ *.pdf *.aux *.log
