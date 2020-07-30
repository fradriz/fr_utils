#Si se quiere definir un programa que luego se puede importar desde otro programa usar lo siguiente

# Filename: s2.py

#Esta funcion se puede usar en el main o sino importarla.
def funcion_a_importar():
	#pass
	print("'funcion_a_importar' en s2.py")

#Al poner esto, si se ejecuta el programa directamente ejecuta el main. Si se importa va por el else (que se puede obviar)

print ("la variable __name__  es igual a '%s'" %__name__ )

if __name__ == '__main__':
	print ('Programa s2.py: This program is being run by itself')
else:
	print ('Programa s2.py: I am being imported from another module')
				