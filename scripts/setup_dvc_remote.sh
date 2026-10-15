#!/usr/bin/env bash
set -e

## Carga las variables del .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "No se encontró el archivo .env."
  exit 1
fi

dvc remote modify storage --local access_key_id "$DVC_DAGSHUB_TOKEN"
dvc remote modify storage --local secret_access_key "$DVC_DAGSHUB_TOKEN"

echo "Credenciales del remote de DVC configuradas correctamente."