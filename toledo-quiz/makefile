.PHONY: algo1-interpret-functions

IM = "/cygdrive/c/Program Files (x86)/ImageMagick-6.8.6-Q16/convert.exe"

algo1-interpret-functions:
	cat algo1/functions.interpret | ruby interpret-js.rb tex > temp.tex
	pdflatex temp.tex
	$(IM) -density 200 -quality 90 -trim temp.pdf q%03d.png
	7z a algo1-interpret-functions.zip q???.png
	rm temp.* q???.png
	cat algo1/functions.interpret | ruby interpret-js.rb toledo https://cygnus.cc.kuleuven.be/bbcswebdav/courses/B-KHLeuven-MBI04a-1314/Quiz/interpret-functions/q%03d.png > interpret-functions.txt
