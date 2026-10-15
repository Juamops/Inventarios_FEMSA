#!/usr/bin/env bash
#
# dvc_encrypt_add.sh
#
# Cifra un archivo de datos con `age` y lo trackea con DVC.
# El archivo original NUNCA se sube a Git ni a DVC, solo la versión cifrada.
#
# Uso:
#   ./scripts/dvc_encrypt_add.sh data/raw/ratings.csv
#
set -e

## Validaciones
if [ -z "$1" ]; then
  echo "Uso: $0 <ruta-al-archivo-a-cifrar>"
  exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]; then
  echo "ERROR: No se encontró el archivo '$INPUT_FILE'."
  exit 1
fi

if [ ! -f ".age/recipients.txt" ]; then
  echo "ERROR: No se encontró .age/recipients.txt."
  exit 1
fi

if ! command -v age &> /dev/null; then
  echo "ERROR: 'age' no está instalado."
  exit 1
fi

if ! command -v dvc &> /dev/null; then
  echo "ERROR: 'dvc' no está instalado o no está en el PATH."
  exit 1
fi

ENCRYPTED_FILE="${INPUT_FILE}.age"

## Encriptación
echo "Encriptando '$INPUT_FILE'..."
age -R .age/recipients.txt -o "$ENCRYPTED_FILE" "$INPUT_FILE"

## Trackeo con DVC
#echo "Trackeando '$ENCRYPTED_FILE' con DVC..."
#dvc add "$ENCRYPTED_FILE"

#echo ""
#echo "Listo. Archivos a commitear en Git:"
#echo "  git add ${ENCRYPTED_FILE}.dvc $(dirname "$ENCRYPTED_FILE")/.gitignore"
#echo "  git commit -m 'Trackear $(basename "$INPUT_FILE") cifrado con DVC'"
#echo ""
#echo "IMPORTANTE: Verifica que '$INPUT_FILE' (sin encriptar) esté en .gitignore"
#echo "y no aparezca en 'git status' antes de hacer commit."
