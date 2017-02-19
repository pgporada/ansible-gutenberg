.ONESHELL:
SHELL := /bin/bash

all:
	@./layout.sh
	@./printer.sh
	@./proofreader.sh
	@./publisher.sh
