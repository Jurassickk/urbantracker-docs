# Dockerfile para compilar documentos LaTeX con XeLaTeX usando TeX Live
FROM ghcr.io/xu-cheng/texlive-full:latest

# Actualizar TeX Live y asegurar herramientas necesarias
RUN tlmgr update --self \
	&& tlmgr install latexmk biber \
	&& tlmgr update --all

# Establecer el directorio de trabajo
WORKDIR /latex

# Comando por defecto (se sobrescribe en docker-compose)
CMD ["bash"]
