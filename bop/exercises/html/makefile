FILE = Process.rb

.PHONY: check

all: check out.html

check: $(FILE) *.rb
	ruby $(FILE) check

out.html: $(FILE) *.rb test.html
	ruby $(FILE) html > out.html

clean:
	rm out.html
