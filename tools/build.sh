#!/bin/bash
set -eu

# Add TeX Live to PATH
export PATH="/opt/texlive/bin:$PATH"

# Clean previous build
rm -rf build

mkdir -p build

# Copy bib file to root for BibTeX
cp bibliography/references.bib .

# Compile IEEE (BibTeX)
echo "[build] Compiling IEEE"
latexmk -silent -file-line-error -outdir=build -bibtex -pdf main_ieee.tex

# Compile ACM (BibTeX)
echo "[build] Compiling ACM"
latexmk -silent -file-line-error -outdir=build -bibtex -pdf main_acm.tex

# Compile APA7 (no bibliography)
echo "[build] Compiling APA7"
latexmk -silent -file-line-error -outdir=build -pdf main_apa7.tex

echo "[build] PDFs available in build/"