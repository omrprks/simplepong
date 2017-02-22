.PHONY: clean
.SUFFIXES: .lua .love

SHELL := /bin/bash

APP = game
# pushd `pwd | xargs dirname`

all:
	@zip $(APP).zip *.lua
	@mv $(APP).zip $(APP).love
	@mv $(APP).love ../bin/

clean:
	@rm ../bin/*.love

run:
