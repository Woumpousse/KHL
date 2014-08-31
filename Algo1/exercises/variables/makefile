.SECONDEXPANSION:

.PHONY: zip variables-html

PACKAGE=unnamed
PACKAGE_CONTENTS=khl.js jquery.js khl.css khluml.sty hint.tex next.tex previous.tex reset.tex reveal.tex verify.tex Controller.rb Generate.rb Generation.rb HTML.rb Java.rb JavaScript.rb Parameters.rb Questions.rb Shared.rb Types.rb makefile .gitignore


all: icons variables-html


-include shared.mk
-include icons.mk


clean: clean_icons
	rm -f *~

variables-html:
	ruby Generate.rb --output variables.html --template variables.template --require ./variables.rb --class Variables -p 2
