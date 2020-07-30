#!/bin/bash

# link: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html#toc11
# crear multiples archivos para prueba: touch prueba{1..9}.txt
# Pasar de segundos a hhmmss: date -d "1970-01-01 10800 sec" +"%H:%M:%S"
# Pasar hora a epoch

#Para ejecutar un comando a multiples archivos en un directorio:
echo "==========================================="
echo -n "Start: "
date
echo "==========================================="

#Mido cuanto tarda la ejecución. Tiempo a epoch
start_time=$(date +%s)

# shellcheck disable=SC2045
for i in $(ls test1*); do
        echo item: $i
        #cp $i $i.copia
done

echo "Delay para pruebas de medicion de tiempo"
sleep 2

finish_time=$(date +%s)
echo "Time duration: $((finish_time - start_time)) secs."

#Si el tiempo de ejecución es de horas, conviene usar un formato de HH:MM:SS
segundos=$((finish_time - start_time))
#segundos=10800
hms=`date -d "1970-01-01 $segundos sec" +"%H:%M:%S"`
echo "Time duration: $hms H:M:S"

echo "==========================================="
echo -n "Fin: "
date
echo "==========================================="

