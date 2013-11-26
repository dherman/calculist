.PHONY: preview build deploy

preview:
	raco frog -bp

build:
	raco frog -b

# deploy: build
# 	git clone https://github.com/dherman/calculist-frog.git _
