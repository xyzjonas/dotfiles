if [[ -z $1 ]]; then
  echo "specify a dump file!"
  exit 1
fi
pg_restore -v -h 127.0.0.1 -p 5431 -d smelt -U smelt < $1
