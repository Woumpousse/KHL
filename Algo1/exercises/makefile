.PHONY: cleantemp arrays recursion 2d-arrays car conditionals

SHARED = *.js *.css

all: conditionals 2d-arrays arrays recursion car lazy.js

conditionals: cleantemp $(SHARED)
	make -C conditionals
	7z a conditionals.zip $(SHARED) conditionals/*.html conditionals/*.js

arrays: cleantemp $(SHARED)
	make -C arrays
	7z a arrays.zip $(SHARED) arrays/*.html arrays/*.js

2d-arrays: cleantemp $(SHARED)
	make -C 2d-arrays
	7z a 2d-arrays.zip $(SHARED) 2d-arrays/*.html 2d-arrays/*.js

recursion: cleantemp $(SHARED)
	make -C recursion
	7z a recursion.zip $(SHARED) recursion/*.html recursion/*.js

car: cleantemp
	make -C car all
	7z a car.zip $(SHARED) car/*.html car/*.png car/*.js car/doc/assignment.pdf

lazy.js: lazy.ts
	tsc -t ES5 lazy.ts

cleantemp:
	rm -f */*~ lazy.js

clean: cleantemp
	rm -f *.zip
