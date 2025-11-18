@echo off
echo Compilando plantillas sin latexmk...

echo.
echo === Compilando IEEE ===
xelatex -interaction=nonstopmode -shell-escape -output-directory=build main_ieee.tex
if %ERRORLEVEL% neq 0 (
    echo Error compilando IEEE - primera pasada
    goto :error
)

biber build/main_ieee.bcf
if %ERRORLEVEL% neq 0 (
    echo Advertencia: Error con biber IEEE
)

xelatex -interaction=nonstopmode -shell-escape -output-directory=build main_ieee.tex
if %ERRORLEVEL% neq 0 (
    echo Error compilando IEEE - segunda pasada
    goto :error
)

echo IEEE compilado exitosamente: build/main_ieee.pdf

echo.
echo === Compilando ACM ===
xelatex -interaction=nonstopmode -shell-escape -output-directory=build main_acm.tex
if %ERRORLEVEL% neq 0 (
    echo Error compilando ACM - primera pasada
    goto :error
)

bibtex build/main_acm.aux
if %ERRORLEVEL% neq 0 (
    echo Advertencia: Error con bibtex ACM
)

xelatex -interaction=nonstopmode -shell-escape -output-directory=build main_acm.tex
if %ERRORLEVEL% neq 0 (
    echo Error compilando ACM - segunda pasada
    goto :error
)

echo ACM compilado exitosamente: build/main_acm.pdf

echo.
echo === Compilando APA7 ===
xelatex -interaction=nonstopmode -shell-escape -output-directory=build main_apa7.tex
if %ERRORLEVEL% neq 0 (
    echo Error compilando APA7 - primera pasada
    goto :error
)

biber build/main_apa7.bcf
if %ERRORLEVEL% neq 0 (
    echo Advertencia: Error con biber APA7
)

xelatex -interaction=nonstopmode -shell-escape -output-directory=build main_apa7.tex
if %ERRORLEVEL% neq 0 (
    echo Error compilando APA7 - segunda pasada
    goto :error
)

echo APA7 compilado exitosamente: build/main_apa7.pdf

echo.
echo === TODAS LAS PLANTILLAS COMPILADAS EXITOSAMENTE ===
dir build\*.pdf
goto :end

:error
echo.
echo === ERROR EN LA COMPILACION ===
echo Revise los mensajes de error anteriores
exit /b 1

:end
echo.
echo Compilacion completada exitosamente.