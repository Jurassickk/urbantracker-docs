# latexmk configuration for unified outdir and shell-escape
$out_dir = 'build';
$bibtex_use = 2;  # Use biber instead of bibtex by default
$pdflatex  = 'pdflatex -interaction=nonstopmode -shell-escape %O %S';
$lualatex  = 'lualatex -interaction=nonstopmode -shell-escape %O %S';
$xelatex   = 'xelatex -interaction=nonstopmode -shell-escape %O %S';