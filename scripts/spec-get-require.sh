for i in specs/*
do
  cat ${i}/*.spec | egrep -i '^(requires|buildrequires)' | cut -d ':' -f 2- | tr -s ' ' '\n' | sort -n | uniq > requires/${i##*/}.specreqs
done
