ENGINE ?= xelatex
OUTDIR  ?= build

ifeq ($(ENGINE),xelatex)
ENGINE_FLAG = -pdfxe
else ifeq ($(ENGINE),lualatex)
ENGINE_FLAG = -pdflua
else
ENGINE_FLAG = -pdf
endif

COMMON = $(ENGINE_FLAG) -shell-escape -outdir=$(OUTDIR)

all: ieee acm apa7

ieee:
	latexmk $(COMMON) main_ieee.tex

acm:
	latexmk $(COMMON) -bibtex main_acm.tex

apa7:
	latexmk $(COMMON) main_apa7.tex

clean:
	latexmk -C -outdir=$(OUTDIR)