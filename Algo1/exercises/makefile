.PHONY: arrays recursion 2d-arrays cleantemp

SHARED = *.js *.css

all: 2d-arrays arrays recursion

arrays: cleantemp
	7z a arrays.zip $(SHARED) arrays

2d-arrays: cleantemp
	7z a arrays.zip $(SHARED) 2d-arrays

recursion: cleantemp
	7z a arrays.zip $(SHARED) recursion

cleantemp:
	rm */*~

clean:
	rm -f *.zip
