.PHONY: phony

GRAPHVIZ_FILES = $(shell find ./graphviz -name '*.dot')
FIGURES = $(shell find ./figures -name '*.svg')

PANDOCFLAGS =                        \
  --table-of-contents                \
  --pdf-engine=xelatex               \
  --from=markdown                    \
  --number-sections                  \
  --indented-code-classes=javascript \
  --highlight-style=monochrome       \
  -V mainfont="Palatino"             \
  -V documentclass=report            \
  -V papersize=A5                    \
  -V geometry:margin=1in

HTML_FLAGS =                         \
	--template=./templates/book.html   \
	--self-contained

all: phony output/book.pdf

epub: phony output/book.epub

html: phony output/book.html

figures: phony
	./bin/figures

output/%.pdf: %.md $(FIGURES) Makefile | output
	pandoc $< -o $@ $(PANDOCFLAGS)

output/%.epub: %.md $(FIGURES) Makefile | output
	pandoc $< -o $@ $(PANDOCFLAGS)

output/%.html: %.md $(FIGURES) Makefile | output
	pandoc $< -o $@ $(HTML_FLAGS) $(PANDOCFLAGS)

output:
	mkdir ./output

clean: phony
	rm -rf ./output

open: phony output/book.pdf
	open output/book.pdf
