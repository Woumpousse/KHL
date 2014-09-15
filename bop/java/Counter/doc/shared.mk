IMAGEMAGICK = convert
LATEX = pdflatex

ifeq ($(OS),Windows_NT)
ZIP = 7z a
else
ZIP = zip
endif
