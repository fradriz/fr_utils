#!/bin/sh

#unrar x Tickets_Marzo_2.rar;unrar x Tickets_Marzo_3.rar;unrar x Tickets_Marzo_4.rar;unrar x Tickets_Marzo_5.rar;unrar x Tickets_Marzo_6.rar
# unrar x ORIGEN/ARCHIVO DESTINO - unrar x Tickets_Mayo_4.csv csvs/

echo "==========================================="
echo -n "Comienzo: "
date
echo "==========================================="

ORIGEN="/export/home/fxr47/scentia/"
DESTINO="/export/home/fxr47/scentia/csvs/"

#Mido cuanto tarda la ejecución. Tiempo a epoch
start_time=$(date +%s)

for i in $(ls Tickets*); do
        echo "unrar x $ORIGEN$i"
		unrar x $ORIGEN$i $DESTINO
#		echo "hola"
#        #cp $i $i.copia
done

#echo "Delay para pruebas de medicion de tiempo"
#sleep 2

finish_time=$(date +%s)
echo "Time duration: $((finish_time - start_time)) secs."

#Si el tiempo de ejecución es de horas, combiene usar un formato de HH:MM:SS
segundos=$((finish_time - start_time))
#segundos=10800
hms=`date -d "1970-01-01 $segundos sec" +"%H:%M:%S"`
echo "Time duration: $hms H:M:S"

echo "==========================================="
echo -n "Fin: "
date
echo "==========================================="


