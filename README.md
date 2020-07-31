# Personal Library
I use this repo as a personal library. Also, I use it to build a Python library that needs to be installed.

## Install it

cd ~/../fr_utils/&& python3 -m pip install .
# cd ~/repos/data-engineering-utils/ && python3 -m pip install . --user

## Directory structure

    fr_utils
    ├── BigData
    │   ├── PySpark
    │   │   ├── PySparkCheatSheet.pdf
    │   │   ├── scala.sh
    │   │   ├── set_spark.py
    │   │   ├── spark_submit.sh
    │   │   ├── training
    │   │   │   ├── 00_setting_up_env.txt
    │   │   │   ├── 1.0_BD_SparkAndHadoop.ipynb
    │   │   │   ├── 1.1_IntroToSpark.ipynb
    │   │   │   ├── 1.2_IntroToSpark.ipynb
    │   │   │   ├── benchmarks
    │   │   │   │   ├── 01_PythonVsPython.ipynb
    │   │   │   │   └── 02_PythonVsPython.ipynb
    │   │   │   ├── curso.txt
    │   │   │   ├── fonts.ipynb
    │   │   │   ├── img
    │   │   │   │   ├── cluster-overview.png
    │   │   │   │   └── query_plan.png
    │   │   │   └── notes.md
    │   │   └── tutorials
    │   │       ├── PandasUDF_UDAF.ipynb
    │   │       ├── RepartitionAndCoalsce.html
    │   │       ├── RepartitionAndCoalsce.ipynb
    │   │       ├── TKE
    │   │       │   ├── 01_identityResolution
    │   │       │   │   ├── IdentityResolution.html
    │   │       │   │   └── IdentityResolution.ipynb
    │   │       │   ├── 02_SegmentStandardization
    │   │       │   │   ├── StandardSegments.html
    │   │       │   │   └── StandardSegments.ipynb
    │   │       │   ├── 03_JoinTaxonomy
    │   │       │   │   ├── JoinTaxonomy.html
    │   │       │   │   └── JoinTaxonomy.ipynb
    │   │       │   ├── TakeHomeExam_Readme1st.html
    │   │       │   ├── TakeHomeExam_Readme1st.ipynb
    │   │       │   ├── outputs
    │   │       │   │   ├── 01_id_resolution_DF.csv
    │   │       │   │   ├── 02_SegmentStandarization_ARRAY_DF_SAMPLE.csv
    │   │       │   │   ├── 02_SegmentStandarization_DF.csv
    │   │       │   │   └── 03_JoinTaxonomy_SAMPLE_DF.csv
    │   │       │   └── solution
    │   │       │       ├── 01_IdentityResolution.html
    │   │       │       ├── 02_SegmentStandarization.html
    │   │       │       └── 03_JoinTaxonomy.html
    │   │       ├── cache_persist.html
    │   │       ├── cache_persist.ipynb
    │   │       └── pySparkTutorial
    │   │           ├── 02_MoviesRDDs.ipynb
    │   │           ├── 03_SparkDataFrames.html
    │   │           ├── 03_SparkDataFrames.ipynb
    │   │           ├── Data-ML-100k--master
    │   │           │   ├── README.md
    │   │           │   └── ml-100k
    │   │           │       ├── README
    │   │           │       ├── allbut.pl
    │   │           │       ├── mku.sh
    │   │           │       ├── u.data
    │   │           │       ├── u.genre
    │   │           │       ├── u.info
    │   │           │       ├── u.item
    │   │           │       ├── u.occupation
    │   │           │       ├── u.user
    │   │           │       ├── u1.base
    │   │           │       ├── u1.test
    │   │           │       ├── u2.base
    │   │           │       ├── u2.test
    │   │           │       ├── u3.base
    │   │           │       ├── u3.test
    │   │           │       ├── u4.base
    │   │           │       ├── u4.test
    │   │           │       ├── u5.base
    │   │           │       ├── u5.test
    │   │           │       ├── ua.base
    │   │           │       ├── ua.test
    │   │           │       ├── ub.base
    │   │           │       └── ub.test
    │   │           └── pySparkTutorial.ipynb
    │   ├── emr.md
    │   ├── environment_for_pyspark.sh
    │   ├── files
    │   │   ├── compress_files.md
    │   │   └── s3_dist_cp.sh
    │   ├── hadoop
    │   │   ├── hadoop_commands.sh
    │   │   ├── hadoop_list_files.sh
    │   │   └── yarn_jobs.sh
    │   └── parquet_tools.sh
    ├── DataBases
    │   ├── athena
    │   │   ├── athena.sql
    │   │   ├── athena_costs.sql
    │   │   ├── athena_create_json.sql
    │   │   └── athena_describe.sql
    │   ├── aws_instance_costs.md
    │   ├── hive
    │   │   ├── hive_alter.sql
    │   │   ├── hive_complex.sql
    │   │   ├── hive_create_tables.sql
    │   │   └── hive_show.sql
    │   ├── impala
    │   │   └── impala_metadata.sql
    │   ├── oracle
    │   └── vertica
    ├── README.md
    ├── a_python
    │   ├── Virtual_Environments.sh
    │   ├── UnitTest
    │   │   ├── __init__.py
    │   │   ├── __pycache__
    │   │   ├── my_sum
    │   │   │   ├── __init__.py
    │   │   │   └── __pycache__
    │   │   │       └── __init__.cpython-37.pyc
    │   │   ├── readme.md
    │   │   └── tests
    │   │       ├── __pycache__
    │   │       │   └── test_sum.cpython-37.pyc
    │   │       ├── test_sum.py
    │   │       └── test_sum.pyc
    │   ├── __init__.py
    │   ├── apps
    │   │   ├── AWSs3Purge.py
    │   │   ├── adding_sparse_vectors.py
    │   │   ├── app1.py
    │   │   ├── csv_schema_update.py
    │   │   └── lambda_function.py
    │   ├── de_utils
    │   │   ├── aws_utils.py
    │   │   ├── gral_utils.py
    │   │   └── pyspark_utils.py
    │   └── tutoriales
    │       ├── DScienceTutorial
    │       │   ├── A\ Complete\ Tutorial\ to\ Learn\ Data\ Science\ with\ Python\ from\ Scratch.url
    │       │   ├── Tutorial\ Python\ 00.html
    │       │   ├── Tutorial\ Python\ 01.ipynb
    │       │   ├── Tutorial+Python+00.html
    │       │   ├── Tutorial+Python+01.html
    │       │   └── leerme.txt
    │       ├── Decorators
    │       │   ├── Decorators.html
    │       │   └── Decorators.ipynb
    │       ├── MapReduceListasTuplasEtc
    │       │   ├── Map,\ reduce,\ filter,\ lambda.ipynb
    │       │   ├── Map,+reduce,+filter,+lambda.html
    │       │   ├── Python_Listas-Tuples-Dict-comprehension-map.html
    │       │   ├── Python_Listas-Tuples-Dict-comprehension-map.ipynb
    │       │   ├── Untitled.ipynb
    │       │   ├── lists_vs_generators
    │       │   │   ├── lists_vs_generators.html
    │       │   │   └── lists_vs_generators.ipynb
    │       │   ├── py_regex.html
    │       │   ├── py_regex.ipynb
    │       │   ├── python_fundamentals_basic_modules.html
    │       │   └── python_fundamentals_basic_modules.ipynb
    │       ├── PyPackages.md
    │       ├── PythonBuenasPracticas
    │       │   ├── Python-BuenasPracticas.html
    │       │   ├── Python-BuenasPracticas.ipynb
    │       │   └── buenas\ practicas\ pythonEFX.docx
    │       ├── Tutoriales_R_Python.txt
    │       ├── objetos
    │       │   ├── OO_2.html
    │       │   ├── OO_2.ipynb
    │       │   ├── Python\ OOP.ipynb
    │       │   ├── Python+OOP.html
    │       │   ├── python_fundamentals_classes.html
    │       │   └── python_fundamentals_classes.ipynb
    │       ├── pandas_numpy
    │       │   ├── CheatSheet_numpy_scipy_pandas.pdf
    │       │   ├── Datacamp-Pandas.ipynb
    │       │   ├── Intro\ to\ Pandas.html
    │       │   ├── Intro\ to\ Pandas.ipynb
    │       │   ├── Intro+to+Pandas.html
    │       │   ├── Numpy.html
    │       │   └── Pandas.html
    │       ├── pydata101
    │       │   ├── AmazonReviews.ipynb
    │       │   ├── Baseball.ipynb
    │       │   ├── BostonHousing
    │       │   │   ├── BostonHousingData.ipynb
    │       │   │   ├── housing.data
    │       │   │   └── housing.names
    │       │   ├── pydata101-master.zip
    │       │   ├── pydata101.txt
    │       │   └── sklearn_examples.ipynb
    │       ├── pytexas2015
    │       │   ├── PyTexas\ 2015\ ML\ Tutorial\ --\ Speaker\ Deck.url
    │       │   ├── pytexas-ml-tutorial.pdf
    │       │   ├── pytexas2015-ml-master
    │       │   │   ├── 0-Exploration.ipynb
    │       │   │   ├── 1-Feature_extraction.ipynb
    │       │   │   ├── 2-Modeling.ipynb
    │       │   │   ├── 3-Validation.ipynb
    │       │   │   ├── 4-Ensemble.ipynb
    │       │   │   ├── README.md
    │       │   │   └── environment.yml
    │       │   ├── pytexas2015-ml-master.zip
    │       │   └── pytexas_notas.txt
    │       └── varios
    │           ├── Basic\ and\ capture_nb.html
    │           ├── Data\ Munging.ipynb
    │           ├── Data+Munging.html
    │           ├── ML_python_y_R.py
    │           ├── charla_python_jeremyAchin.txt
    │           ├── ejerciciosConCSVs
    │           │   ├── check_csvFile.py
    │           │   ├── ejerciciosConCSVs.html
    │           │   ├── ejerciciosConCSVs.ipynb
    │           │   ├── p.csv
    │           │   ├── procesar_csv
    │           │   │   ├── Archivos\ (csv,\ txt,\ etc).ipynb
    │           │   │   ├── inicial.csv
    │           │   │   ├── inicial.txt
    │           │   │   ├── leerme.txt
    │           │   │   └── procesar_csv.zip
    │           │   ├── syc.sh
    │           │   └── u_rar.sh
    │           ├── estructura
    │           │   ├── __pycache__
    │           │   │   └── s2.cpython-35.pyc
    │           │   ├── estructura_pies.zip
    │           │   ├── s2.py
    │           │   ├── t.py
    │           │   ├── t2.py
    │           │   └── test.py
    │           ├── links_interesantesDataScience.txt
    │           └── py_hive_udfs
    │               ├── 00_test.py
    │               ├── a.py
    │               ├── b.py
    │               ├── blog_hive.py
    │               └── cc.py
    ├── git
    │   ├── git_cli.sh
    │   ├── modify_critial_branch.sh
    │   └── new_branch.sh
    ├── notes.md
    ├── others
    │   ├── aisj.py
    │   ├── bash_cron_time.sh
    │   ├── clone_repo.sh
    │   ├── emr_bootstrap.sh
    │   ├── main_json.sh
    │   ├── sed_useful_cmds.sh
    │   ├── ssh.sh
    │   └── system_commands.py
    └── setup.py
