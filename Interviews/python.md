# Preguntas de python

Usaste/usas python ? Para que tareas ?

Qué IDE usas ?

Qué Frameworks manejas ?

    Sabes PySpark ?
    
    Sabes Pandas ?


Usas Virtual environments ? Como ?


Diferencia entre una lista y una tupla ?
    - lista puede modificarse: lista = []
    - tuplas son inmodificables: tupla = ()
    - si no se va a modificar, es más performante usar tuplas


Diferencia entre lista y array ? (esta pregunta es un poco engañosa)
    - lista es la forma original de python
    - arrays son los que maneja el paquete de numpy
    

Que hace este codigo ?

lista = [1, 2, 3]

    1. resultado = [r*10 for r in lista]     
    2. resultado = (r*10 for r in lista)     
    3. list(map(lambda x:x*10, lista))  
    4. sum(map(lambda x:x+1, lista))    
    
    Rtas:
      1. Devuelve una lista: [10, 20, 30]
      2. Devuelve un generador
      3. Rta: [10, 20, 30]
      4. Rta: 9
    
Diferencias entre listas y generadores ? 

Los generadores no ponen el contenido a memoria -es un lazy evaluation- 
esto posibilita usar el resultado sin ocupar la memoria. Muy util cuando hay que trabajar con grandes volumens.

Pero: 
    * Los generadores pueden accederse solo una vez ! (cuidado !)
    * Las listas pueden indexarse, los generadores NO. ej: lista[0] es valido, pero generador[0] no.
    * Generadores se obtienen los items en orden solo una vez
     

Manejo de errores en Python.

* El siguiente ejemplo trata de abrir un archivo. Que se imprime si:
    - Se encuentra el archivo ok ?
    - No se encuentra el archivo ?
    - Se encuentra el archivo pero me queda otro error en el codigo ?

Como hay que hacer para que no llegue a imprimir FIN si hay un error ?
    * Hay que hacer un: raise FileNotFoundError("Mensaje") o raise Exception("Mensaje")

    try:
        f = open("test.txt")
        
    except FileNotFoundError:
        print("Sale por FileNotFoundError")
    
    except Exception as e:
        print(f"Sale por exception: '{e}'")
    
    else:
        print("Sale por el else'")
        
        
    print("FIN")

