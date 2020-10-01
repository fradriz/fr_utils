# Preguntas de Big Data


# Spark
Te costo resolver el Take-Home-Exam ? 

Qué es lo que ya habias manejado ?

Porque parquet es mejor que csv ?
    * Parquet trabaja con snappy (u otro) para comprimir datos
    * Parquet soporta datos complejos como structs o arrays
    * Parquet tiene el schema incorporado en la metadata por lo que no necesita inferir el schema.
    * Parquet es columnar y spark optimiza las queries.
    
    Ventaja de csv: es más fácil de leer para los humandos.

Que significa lazy evaluation en Spark ?

    * Spark tiene:
        - transformation: join, groupBy, etc
        - actions: min, count(), write(), first()
    Lazy: significa que no va a realizar ningun trabajo hasta que se realice una acción. Es decir, las transformaciones
    parece que son muy rápidas pero en realidad Spark no las ejecuta hasta que se realice una acción.


Que es una UDF ?

UDFs: Es lo mismo usar una UDF que una built-in function (una función pre-definida de Spark) ?
    - Ventajas / desventajas ?
    - Cual sería el problema ?
    
Que es una UDAF ?


Sabes lo que es un broadcast join ?
    El ejercicio de Nico se podria haber mejorado analizando el tamaño de los DF y usando broadcast 
    (aunque spark lo hace solo por default, quizas hay que analizar valores defualt para el broadcast automatico)

Cuando conviene usar inferSchema='true' ? Cuando no ?



# Hadoop
Trabajaste con hadoop ?

Qué sabes de MapReduce ?

MapReduce vs Spark ?
