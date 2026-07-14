# Makefile for CV compilation
# Uses XeLaTeX for reliable CJK support on macOS

MAIN = CV
ZH = CV_zh
OUTPUT_DIR = ../assets/pdf
ENGINE ?= xelatex

.PHONY: all clean watch

all: $(OUTPUT_DIR)/$(MAIN).pdf $(OUTPUT_DIR)/$(ZH).pdf

$(OUTPUT_DIR)/$(MAIN).pdf: $(MAIN).tex
	@mkdir -p $(OUTPUT_DIR)
	$(ENGINE) -interaction=nonstopmode $(MAIN).tex
	$(ENGINE) -interaction=nonstopmode $(MAIN).tex
	mv $(MAIN).pdf $(OUTPUT_DIR)/

$(OUTPUT_DIR)/$(ZH).pdf: $(ZH).tex
	@mkdir -p $(OUTPUT_DIR)
	$(ENGINE) -interaction=nonstopmode $(ZH).tex
	$(ENGINE) -interaction=nonstopmode $(ZH).tex
	mv $(ZH).pdf $(OUTPUT_DIR)/

# Quick build and refresh the canonical PDFs in assets/pdf
quick:
	@mkdir -p $(OUTPUT_DIR)
	$(ENGINE) -interaction=nonstopmode $(MAIN).tex
	mv $(MAIN).pdf $(OUTPUT_DIR)/
	$(ENGINE) -interaction=nonstopmode $(ZH).tex
	mv $(ZH).pdf $(OUTPUT_DIR)/

zh:
	@mkdir -p $(OUTPUT_DIR)
	$(ENGINE) -interaction=nonstopmode $(ZH).tex
	mv $(ZH).pdf $(OUTPUT_DIR)/

# Watch for changes (requires inotify-tools)
watch:
	@echo "Watching for changes to $(MAIN).tex..."
	@while true; do \
		inotifywait -q -e modify $(MAIN).tex; \
		make quick; \
	done

clean:
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).out $(MAIN).pdf
	rm -f $(ZH).aux $(ZH).log $(ZH).out $(ZH).pdf
	rm -f *.aux *.log *.out

# Install dependencies on Ubuntu/Debian
install-deps:
	sudo apt-get install texlive-full texlive-lang-chinese
