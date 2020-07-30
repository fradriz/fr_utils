#!/usr/bin/python2.6
# -*- coding: utf-8 -*-

#import re
import os
import subprocess
import time

#Archivos vienen con un header
#Luego:
#	Fecha: 2017-04-10 00:00:00.000 -> YYYY-MM-DD (sacar los ceros) y comprobar que YYYY = 2017, 1<=MM<=12, 1<=DD<=31 (no compruebo si el día existe)
#	Hora: HHMMSS -> Verificar que: 00<HH<24, 0<MM<60, 0<SS<60
#	IDPuntoVenta;Ticket;Ean;Cantidad;PrecioUnitario;MONTO -> Que no sean NULL.
#FECHA;HORA;IDPuntoVenta;Ticket;Ean;Cantidad;PrecioUnitario;MONTO
#2017-04-10 00:00:00.000;170956;Z939;5058129774;ddjjjjjdo900;0;0;0,01
#2017-04-10 00:00:00.000;123124;D2040;5057710836;779dpdojeje2j72;1;16;16


#Para simplificar la llamada a sistema. Py2.6.6 no tiene subprocess.check_out implementado (ok a partir de 2.7)
def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()
	
# Examina las primeras líneas (nro_lineas)del archivo para detectar separador y cantidad de campos.
def sep_campos(p,n_arch):
	nro_lineas = 10
	arch=p + n_arch							#Path+archivo
	#print("Procesando: %s" %n_arch)
	
	cmd = ("head -n %s %s|grep -o -P ';'|wc -l" %(nro_lineas,arch))
	PYC = system_call(cmd).rstrip()
	
	cmd = ("head -n %s %s|grep -o -P ','|wc -l" %(nro_lineas,arch))
	COM = system_call(cmd).rstrip()
	
	cmd = ("head -n %s %s|grep -o -P ' '|wc -l" %(nro_lineas,arch))
	ESP = system_call(cmd).rstrip()
	
	cmd = ("head -n %s %s|grep -o -P '\t'|wc -l" %(nro_lineas,arch))
	TAB = system_call(cmd).rstrip()
	#print ("PYC:%s\tCOM:%s\tESP:%s\tTABS:%s" %(PYC,COM,ESP,TAB))

	sep = {';':int(PYC), ',':int(COM),' ':int(ESP),'\t':int(TAB)}  #cast str to int para calcular el max
	
	separador=max(sep,key=sep.get)
	#print ("DELIMITADOR:'%s'" %separador)
	
	#CAMPOS POR LINEA:
	#Número de campos: head -n 10 p.csv | awk -F";" '{print NF}'
	#Para que sume todas las lineas: CANTIDAD_CAMPOS =   head -n 10 p.csv | awk -F";" '{print NF}'|awk '{s+=$1} END {print s}'
	#Cuento 10 líneas del archivo. Si CANTIDAD_CAMPOS % 0 es distinto de cero => la cantida de campos está mal = > TERMNAR EJ
	cmd = ("head -n %s %s| awk -F'%s' '{print NF}'|awk '{s+=$1} END {print s}'" %(nro_lineas,arch,separador))
	CANTIDAD_CAMPOS = int(system_call(cmd).rstrip())
	#print ("CANTIDAD_CAMPOS CONTADOS %s" %(CANTIDAD_CAMPOS))
	
	#Si las lineas consideradas tienen 8 campos pero una tiene 9 por ej, entonces el modulo de la operacion sera <> de cero -> abortar este archivo y reportar el error.
	if (CANTIDAD_CAMPOS%nro_lineas):
		print ("El modulo <> 0 Sale con error")
		return ('',0)           #Si el nro de campos es cero es un ERROR
	else:
		CANTIDAD_CAMPOS = int(CANTIDAD_CAMPOS/10)
		#print ("Modulo = 0 TODO OK - CAMPOS por LINEA = ", CANTIDAD_CAMPOS)
		return (separador,CANTIDAD_CAMPOS)

#Escribir las filas que estan bien en un archivo <nombre>_ok.csv (Ej. Tickets_Abril_1_ok.csv
#Escribir las filas que están mal en un archivo <nombre>_err (Ej. Tickets_Abril_1_err.csv) (poner con la fila el tipo de error detectado)
#Escribir un archivo que indique: Nombre de archivo;Separador;Cantidad de campos;#Filas_OK;#Filas_ERR
def check_lineas(i_path,n_archivo,sep,fields, nro_arch):
	output_path=i_path + 'output/'

	archivo=i_path + n_archivo
	csv_file = open(archivo, 'r')
	
	#Archivo para escribir los errores
	ppn_archivo = n_archivo.split('.')        #Si quiero usar solo la primer parte sin el 'csv'
	err_arch_aux=output_path + ppn_archivo[0] + '_err.' + ppn_archivo[1]	#Tiene q quedar Tickets_Abril_1_err.csv
	err_arch = open(err_arch_aux, 'w')	
	
	#Archivo para escribir la salida OK
	#ok_arch_aux=output_path + ppn_archivo[0] + '_ok.' + ppn_archivo[1]	#Tiene q quedar Tickets_Abril_1_ok.csv
	#ok_arch = open(ok_arch_aux, 'w')

	#Archivo para escribir estadisticas finales (lo abro como append porque tengo que agregar datos en c/archivo)
	estad_arch_aux=output_path + 'brief.csv'	#Tiene q quedar brief.csv
	estad_arch = open(estad_arch_aux, 'a')	
	
	fila=0
	errores=0
	comienzo_arch=time.time()
	for row in csv_file:    
		#row=row.rstrip()                           #rstrip == chomp
		#print ('Fila %s: %s' %(fila,row)); 
		fila += 1
		if (fila%10000000 == 0):             #Para que me muestre el avance c/10 M de registros
			print("%s, fila %s" %(n_archivo,fila))
		col = row.split(sep)
		#print("Cantidad de fields: %s\n" %len(col))
		if (fields != len(col)):
			#print("Linea %s: #Columnas incorrecto: %s - MANDAR LINEA A LOG DE ERRORES" %(fila,errores))
			#print("Fila con problemas: %s" %col)
			errores+=1
			err_msg=("%s: fila nro %s - # campos incorrecto\n" %(n_archivo,fila))
			err_arch.write(err_msg)
		else:
			#print("Linea %s: Cantidad de fields correcta - Seguir verificando" %fila)
			
			#Verificar las columnas
			if (col[0]==''):       #Si es null
				print("FECHA NULL")
				err_msg=("%s: fila nro %s - Fecha NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
			
			if (col[1]==''):
				print("HORA NULL")
				err_msg=("%s: fila nro %s - Hora NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
			
			if (col[2]==''):
				print("IDPuntoVenta NULL")
				err_msg=("%s: fila nro %s - IDPuntoVenta NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
			
			if (col[3]==''):
				print("Ticket NULL")
				err_msg=("%s: fila nro %s - Ticket NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
			
			if (col[4]==''):
				print("Ean NULL")
				err_msg=("%s: fila nro %s - Ean NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
				
			if (col[5]==''):
				print("Cantidad NULL")
				err_msg=("%s: fila nro %s - Cantidad NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
				
			if (col[6]==''):
				print("PrecioUnitario NULL")
				err_msg=("%s: fila nro %s - PrecioUnitario NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
				
			if (col[7]==''):
				print("\MONTO NULL")
				err_msg=("%s: fila nro %s - MONTO NULL\n" %(n_archivo,fila))
				err_arch.write(err_msg)
				errores+=1
				
			#FECHA = col[0]
			#FECHA = re.compiler().search(col[0])
			#HORA = col[1]
			#EAN = col[2]
			#MONTO_UNITARIO = col[3]
			#print("VALOR COLUMNA: %s" %col)
			
			#ok_arch.write(row)
	
	fin_arch = time.time()
	
	#Se escriben estadisticas del archivo:
	#Header: Nro de Archivo, Nombre,Delimitador,total de filas, Errores,Tiempo de procesamiento(segs)
	print("Nro de Archivo %s Nombre %s\tDelimitador:'%s'\tCantidad de filas: %s\tErrores: %s\tTiempo en segs %s" %(nro_arch,n_archivo,sep,fila,errores,fin_arch - comienzo_arch))
	
	estad_arch.write("%s;%s;'%s';%s;%s;%s\n" %(nro_arch,n_archivo,sep,fila,errores,(fin_arch - comienzo_arch)))
	
	csv_file.close()           #Cerrar el archivo cuando no se use mas
	err_arch.close()
	#ok_arch.close()
	estad_arch.close()
			


###### Main ##########
if __name__ == '__main__':
	path='/export/home/fxr47/scentia/csvs/'
	start_time = time.time()
	
	cmd = ("ls Tickets_*.csv")
	#cmd = ("ls Tickets_Abril_*.csv")
	#cmd = ("ls Tickets_Abril_1.csv")
	#cmd = ("ls p.csv")
	
	lista_archivos = (system_call(cmd)).rstrip()
	#print("Lista archivos %s" %lista_archivos)
	
	my_list=lista_archivos.split('\n') #Si no hago esto no funciona
	#print("Lista archivos %s" %my_list)
	
	nro_archivo=0
	for nombre_archivo in my_list:
		nro_archivo += 1
		print("%s) procesando %s" %(nro_archivo,nombre_archivo))
		
		#Calcular el delimitador y cantidad de campos por linea del archivo.
		delimitador,campos = sep_campos(path, nombre_archivo)
		
		if (campos == 0):         #Esto es un error en la cantidad de campos (del principio) debe saltear el archivo
			print("El nro de campos es incorrecto salteando archivo '%s'" %nombre_archivo)
			cmd = ("echo '%s: Nro de campos incorrecto en las primeras filas - no se procesa el archivo' >> %s" %(nombre_archivo,path+'output/err_campos.txt'))
			system_call(cmd)
		else:
			#Verifica linea por linea -esto tarda-
			check_lineas(path,nombre_archivo,delimitador,campos,nro_archivo)
		
	end_time = time.time()
	print("--- Tiempo de ejecución: %s seconds ---" % (end_time - start_time))
	
	#print ("Archivo: %s \t Delimitador:'%s' \t Campos por linea: %s" %(nombre_archivo,delimitador,campos))
	#print ("--FIN by KILL --"); os.kill()
	#print("---OK----: %s" %estad_arch)	
		#estad_arch.write("TEST: %s" %archivo);estad_arch.close()
		
		#print ("--FIN by KILL --"); os.kill()	
	
