#!/bin/sh

#Chequear separador y campos en los primeros 10 registros de cada archivo.


# -- Separador --
#for i in $(ls Tickets*); do
for i in $(ls Tickets_Abril_1.csv); do
		TAB=`head $i |grep -o -P "\t"|wc -l`
		PYC=`head $i |grep -o -P ';'|wc -l`
		COM=`head $i |grep -o -P ','|wc -l`
		ESP=`head $i |grep -o -P ' '|wc -l`
		
		if [[ $TAB > $PYC ]] 
		then 
			SEP='TAB' 
		else 
			SEP=';'			
		fi
done

echo "Cantidad de Punto y coma: $PYC"
echo "Cantidad de comas: $COM"
echo "Cantidad de TABS: $TAB"
echo "Cantidad de espacios: $ESP"

echo "Separador es $SEP"

