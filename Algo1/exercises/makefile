.PHONY: cleantemp arrays recursion 2d-arrays car conditionals

SHARED = *.js *.css

all: conditionals 2d-arrays arrays recursion car

conditionals: cleantemp
	make -C conditionals
	7z a conditionals.zip $(SHARED) conditionals/*.html conditionals/*.js

arrays: cleantemp
	make -C arrays
	7z a arrays.zip $(SHARED) arrays/*.html arrays/*.js

2d-arrays: cleantemp
	make -C 2d-arrays
	7z a 2d-arrays.zip $(SHARED) 2d-arrays/*.html 2d-arrays/*.js

recursion: cleantemp
	make -C recursion
	7z a recursion.zip $(SHARED) recursion/*.html recursion/*.js

car: cleantemp
	make -C car all
	7z a car.zip $(SHARED) car/*.html car/*.png car/*.js car/doc/assignment.pdf

cleantemp:
	rm -f */*~

clean:
	rm -f *.zip
