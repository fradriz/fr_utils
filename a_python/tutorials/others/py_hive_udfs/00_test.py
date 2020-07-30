#!/usr/bin/env python

''' Recibir dos campos y devolver: campo1_campo2 
	hadoop fs -copyFromLocal -f ./c.py /user/cambrian/ops_dev/efx/paraguay/py_efx_indicadores/fpy/c.py 
	
	Probar: 
	 ./c.py
	INPUT: hola    chau
	SALIDA: hola_chau
	HIVE:
	1)
	select 
        transform (tipo_documento, ficha) using 'hdfs:///user/cambrian/ops_dev/efx/paraguay/py_efx_indicadores/fpy/c.py' as (ficha,new_field)
    from uy_efx_indicadores limit 10
	
	Devuelve: ficha new_field (los dos campos combinados)
	
	2)
	with temp_table as (
		select 
			transform (tipo_documento, ficha) using 'hdfs:///user/cambrian/ops_dev/efx/paraguay/py_efx_indicadores/fpy/c.py' as (ficha,new_field)
		from uy_efx_indicadores
	)
	
	select
		uy.tipo_documento,
		uy.ficha,
		t.new_field
	from 
		temp_table t join uy_efx_prod.uy_efx_indicadores uy on t.ficha=uy.ficha
	limit 10
	
	Salen tres campos: uy.tipo_documento, uy.ficha y t.new_field
	'''

import sys

for linea in sys.stdin:
  linea = linea.strip()
  campo = linea.split('\t')
  #Para imprimir los campos el separador es \t
  print("%s\t%s_%s" % (campo[1],campo[0],campo[1]))