# Makefile for CV compilation
# Requires: texlive-full or texlive with luatexja

MAIN = CV
OUTPUT_DIR = ../assets/pdf

.PHONY: all clean watch

all: $(OUTPUT_DIR)/$(MAIN).pdf

$(OUTPUT_DIR)/$(MAIN).pdf: $(MAIN).tex
	@mkdir -p $(OUTPUT_DIR)
	lualatex -interaction=nonstopmode $(MAIN).tex
	lualatex -interaction=nonstopmode $(MAIN).tex
	mv $(MAIN).pdf $(OUTPUT_DIR)/

# Quick build without moving
quick:
	lualatex -interaction=nonstopmode $(MAIN).tex

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
