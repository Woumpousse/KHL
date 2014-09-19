all:
	find -mindepth 1 -type d | xargs --max-args=1 make -C

upload:
	find -mindepth 1 -type d | xargs --max-args=1 -I{} make -C {} upload
