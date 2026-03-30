# Makefile for CV compilation
# Uses XeLaTeX for reliable CJK support on macOS

MAIN = CV
OUTPUT_DIR = ../assets/pdf
ENGINE ?= xelatex

.PHONY: all clean watch

all: $(OUTPUT_DIR)/$(MAIN).pdf

$(OUTPUT_DIR)/$(MAIN).pdf: $(MAIN).tex
	@mkdir -p $(OUTPUT_DIR)
	$(ENGINE) -interaction=nonstopmode $(MAIN).tex
	$(ENGINE) -interaction=nonstopmode $(MAIN).tex
	mv $(MAIN).pdf $(OUTPUT_DIR)/

# Quick build without moving
quick:
	$(ENGINE) -interaction=nonstopmode $(MAIN).tex

# Watch for changes (requires inotify-tools)
watch:
	@echo "Watching for changes to $(MAIN).tex..."
	@while true; do \
		inotifywait -q -e modify $(MAIN).tex; \
		make quick; \
	done

clean:
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).out $(MAIN).pdf
	rm -f *.aux *.log *.out

# Install dependencies on Ubuntu/Debian
install-deps:
	sudo apt-get install texlive-full texlive-lang-chinese
