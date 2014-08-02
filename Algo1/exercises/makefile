.PHONY: cleantemp arrays recursion 2d-arrays car

SHARED = *.js *.css

all: 2d-arrays arrays recursion car

arrays: cleantemp
	7z a arrays.zip $(SHARED) arrays

2d-arrays: cleantemp
	7z a arrays.zip $(SHARED) 2d-arrays

recursion: cleantemp
	7z a arrays.zip $(SHARED) recursion

car: cleantemp
	make -C car all
	7z a car.zip $(SHARED) car/*.html car/*.png car/*.js car/doc/assignment.pdf

cleantemp:
	rm -f */*~

clean:
	rm -f *.zip
