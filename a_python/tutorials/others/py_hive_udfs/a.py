#!/usr/bin/env python
""" prueba de funcion que devuelve matrices relacionadas """
import sys

resp = ""
for linea in sys.stdin:
        # evita el salto de linea final que agrega la consola al probar
        par_matriz = str(linea)[0:6]
        # busca la lista de matrices relacionadas 
        if par_matriz == "GF0017":
               resp = " in ('GF0017','GG0017','GG0012')"
        elif par_matriz == "GO0285":
               resp = " IN ('GO0285','GO0067','GJ0067','GG0285')"
        elif par_matriz == "GO2001":
               resp = " IN ('GO2001','GI2001')"
        elif par_matriz == "GO0150":
               resp = " IN ('GO0150','GJ0150','GO1150','GI1150','GO0265')"
        elif par_matriz == "C11060":
               resp = " IN ('C11060','GG1060')"
        elif par_matriz == "GO0034":
               resp = " IN ('GO0034','GO0006')"
        elif par_matriz == "BZ6163":
               resp = " IN ('BZ6163','BZ6369')"
        elif par_matriz == "G 9750":
               resp = " IN ('G 9750','G 9759')"
        elif par_matriz == "GO0027":
               resp = " IN ('GO0027','GG0297')"
        elif par_matriz == "G00156":
               resp = " IN ('G00156','GG0426','C16960')"
        elif par_matriz == "GO0299":
               resp = " IN ('GO0299','GG0299')"
        elif par_matriz == "GF4091":
               resp = " IN ('GF4091','GI4091','D04091')"
        elif par_matriz == "BZ2004":
               resp = " IN ('BZ2004','GG0277')"
        else:
               resp = "like '" + par_matriz[0] + "%" + par_matriz[2:6] + "'"
        print(resp)

