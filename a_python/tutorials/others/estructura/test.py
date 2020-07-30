#La idea es estructurar el programa 
import sys
import s2         #Ejecuta el 'else' de s2.py

def main():
   if len(sys.argv) >= 2:
     name = sys.argv[1]
     print ("Programa test_sum.py: hay argumentos")
   else:
     name = 'World'
     print ("Programa test_sum.py: NO hay argumentos")
   print ('Programa test_sum.py: Hello', name)
   
   s2.funcion_a_importar()

if __name__ == '__main__':
	main()