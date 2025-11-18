# Plantilla LaTeX — Investigación aplicada (IEEE + ACM + APA7)

Este repositorio genera **tres PDFs** desde el mismo contenido: **IEEE**, **ACM** y **APA7**.

## Dependencias
- Docker Desktop (Windows/macOS) o Docker Engine (Linux)
- Conexión a internet (la primera vez se descargará la imagen `texlive-full`, ~6 GB)

No necesitas instalar LaTeX localmente: todo sucede dentro del contenedor.

## Estructura
```
articulo-aplicada/
  Dockerfile          docker-compose.yml   compile.bat
  latexmkrc           README.md            tools/build.sh
  main_*.tex          includes/            sections/
  bibliography/       tables/              code/
```

Las secciones (`sections/*.tex`) se **comparten** entre formatos. Cada *main* define portada y estilo.

## Uso rápido (Docker)
```powershell
# 1) Construir la imagen (solo la primera vez o tras cambios en Dockerfile)
docker compose build latex

# 2) Compilar los tres formatos mediante Docker
docker compose run --rm latex

# En Windows puedes usar el wrapper
.\\compile.bat

# Los PDFs quedan en build/
```

Si necesitas una compilación limpia, elimina el contenido de `build/` y vuelve a ejecutar el comando.

**Configuración de resaltado de código**:
- Por defecto usa `listings` (`\mintedfalse` en `includes/preamble_common.tex`)
- Para usar `minted`: cambie `\mintedfalse` → `\mintedtrue` (requiere Python + pygments)

## Rellenar metadatos
- **IEEE**: edite autores/afiliaciones en `main_ieee.tex`.
- **ACM**: complete `\author`, `\affiliation`, `\email` en `main_acm.tex`.
- **APA7**: complete `\shorttitle`, `\author`, `\affiliation` en `main_apa7.tex`.

## Bibliografía
Agregue o edite referencias en `bibliography/references.bib`.
- IEEE/APA: `biblatex` + `biber` → `\printbibliography`
- ACM: `natbib`/`BibTeX` → `\bibliographystyle{ACM-Reference-Format}` + `\bibliography{bibliography/references}`

## Licencia
Por defecto, **CC BY 4.0** (ajuste si lo desea).

## Reproducibilidad
Incluimos una **plantilla de checklist** en `sections/A1_apendices.tex` y rutas para guardar scripts/datasets en `code/`, `tables/`, `graphics/`.

## Solución de problemas comunes


### Errores de compilación
- **APA7**: Puede mostrar warnings sobre definiciones duplicadas, pero genera el PDF correctamente
- **Bibliografía vacía**: Normal si no hay citas en el documento
- **Minted no disponible**: La plantilla usa `listings` automáticamente como fallback

### Forzar compilación
Si hay errores menores que no impiden la generación del PDF:
```bash
latexmk -pdfxe -shell-escape -outdir=build -f main_apa7.tex
```

## Gráficas y tablas

### Tamaños recomendados para gráficas
Para evitar que las gráficas se salgan del formato, use estos tamaños **optimizados**:

```latex
% Gráficas simples (barras, scatter)
\includegraphics[width=0.48\textwidth]{graphics/archivo.pdf}

% Gráficas complejas (radar, correlaciones)
\includegraphics[width=0.45\textwidth]{graphics/archivo.pdf}

% Gráficas de evolución temporal (líneas múltiples)
\includegraphics[width=0.5\textwidth]{graphics/archivo.pdf}

% Para formato single-column (ACM, APA7) - pueden ser más grandes
\includegraphics[width=0.7\textwidth]{graphics/archivo.pdf}

% Para formato IEEE (columna doble) - máximo recomendado
\includegraphics[width=0.48\textwidth]{graphics/archivo.pdf}
```

**Regla general**: Para IEEE (2 columnas) usar **máximo 0.5\textwidth**. Para formatos single-column (ACM/APA7) se puede usar hasta **0.7\textwidth**.

### Tablas anchas
Para tablas que exceden el ancho de página, **reduzca columnas** y use `\small`:

```latex
\begin{table}[htbp]
\centering
\caption{Título de la tabla}
\label{tab:etiqueta}
\small  % Hace el texto más pequeño
\begin{tabular}{lccc}  % Menos columnas = mejor ajuste
% contenido de la tabla
\end{tabular}
\end{table}
```

**Solo como último recurso** use `\resizebox` (puede hacer el texto ilegible):

```latex
\resizebox{\textwidth}{!}{%
\begin{tabular}{lccccc}
% contenido de la tabla
\end{tabular}%
}
```

### Generación automática de gráficas
Las gráficas se generan ejecutando:
```bash
python code/generate_figures.py
```

Esto crea archivos PDF optimizados para LaTeX en `graphics/` y archivos PNG para vista previa.

---

> Este repositorio fue generado automáticamente por ChatGPT a partir del **Prompt Maestro v2** incluido en `PROMPT.md`.
