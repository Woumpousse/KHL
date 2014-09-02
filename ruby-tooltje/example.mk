example: example.template *.rb icons example-slides example-html example-multimake

example-html:
	ruby Generate.rb --output example.html --template example.template --require ./Example.rb --class Examples --parameter x=1 -P y=2

example-multimake: multimake-example.rb
	ruby multimake-example.rb

example-slides: slides-example.tex
	$(LATEX) slides-example.tex
	$(IMAGEMAGICK) -quality 90 -density 300 -trim -shave 3x3 slides-example.pdf slides-example-%d.png

clean_example:
	rm -f slides-example-?.png slides-example.aux
