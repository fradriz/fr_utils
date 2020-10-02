# Personal Library
I use this repo as a personal library. Also, I use it to build a Python library that needs to be installed.

Some items included: PySpark, Python, SQL (Athena, Hive, etc), Databricks Tutorial, aws & git CLI among others.

## Install it
cd ~/../fr_utils/&& python3 -m pip install .
# cd ~/repos/data-engineering-utils/ && python3 -m pip install . --user

## Directory structure

    fr_utils
    ├── BigData
    │   ├── PySpark
    │   │   ├── PySparkCheatSheet.pdf
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
    │   │       ├── DataBricks
    │   │       │   ├── DBCs
    │   │       │   │   ├── ETL-Part-1-1.3.1-SPNC-AWS.dbc
    │   │       │   │   ├── ETL-Part-1-1.3.1-SPNC-MSA.dbc
    │   │       │   │   ├── ETL-Part-2-1.3.1-SPNC-AWS.dbc
    │   │       │   │   ├── ETL-Part-2-1.3.1-SPNC-MSA.dbc
    │   │       │   │   ├── ETL-Part-3-1.1.1-SPNC-AWS.dbc
    │   │       │   │   ├── ETL-Part-3-1.1.1-SPNC-MSA.dbc
    │   │       │   │   ├── MLflow-AWS.dbc
    │   │       │   │   ├── MLflow-AZU.dbc
    │   │       │   │   ├── Structured-Streaming-1.3.1-SPNC-AWS.dbc
    │   │       │   │   └── Structured-Streaming-1.3.1-SPNC-MSA.dbc
    │   │       │   ├── ETL_01
    │   │       │   │   ├── ETL1\ 02\ -\ ETL\ Process\ Overview.html
    │   │       │   │   ├── ETL1\ 03\ -\ Connecting\ to\ S3.html
    │   │       │   │   ├── ETL1\ 04\ -\ Connecting\ to\ JDBC.html
    │   │       │   │   ├── ETL1\ 05\ -\ Applying\ Schemas\ to\ JSON\ Data.html
    │   │       │   │   ├── ETL1\ 06\ -\ Corrupt\ Record\ Handling.html
    │   │       │   │   └── ETL1\ 07\ -\ Loading\ Data\ and\ Productionalizing.html
    │   │       │   ├── ETL_02
    │   │       │   │   ├── ETL2\ 01\ -\ Course\ Overview\ and\ Setup.html
    │   │       │   │   ├── ETL2\ 02\ -\ Common\ Transformations.html
    │   │       │   │   ├── ETL2\ 03\ -\ User\ Defined\ Functions.html
    │   │       │   │   ├── ETL2\ 04\ -\ Advanced\ UDFs.html
    │   │       │   │   ├── ETL2\ 05\ -\ Joins\ and\ Lookup\ Tables.html
    │   │       │   │   ├── ETL2\ 06\ -\ Database\ Writes.html
    │   │       │   │   └── ETL2\ 07\ -\ Table\ Management.html
    │   │       │   └── ETL_03
    │   │       │       ├── ETL3\ 02\ -\ Streaming\ ETL.html
    │   │       │       ├── ETL3\ 03\ -\ Runnable\ Notebooks.html
    │   │       │       ├── ETL3\ 04\ -\ Scheduling\ Jobs\ Programatically.html
    │   │       │       ├── ETL3\ 05\ -\ Job\ Failure.html
    │   │       │       ├── ETL3\ 06\ -\ ETL\ Optimizations.html
    │   │       │       └── ETL3_03_runnablesNBs
    │   │       │           ├── Runnable-1.html
    │   │       │           ├── Runnable-2.html
    │   │       │           ├── Runnable-3.html
    │   │       │           └── Runnable-4.html
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
    │   │       ├── pySparkTutorial
    │   │       │   ├── 02_MoviesRDDs.ipynb
    │   │       │   ├── 03_SparkDataFrames.html
    │   │       │   ├── 03_SparkDataFrames.ipynb
    │   │       │   ├── Data-ML-100k--master
    │   │       │   │   ├── README.md
    │   │       │   │   └── ml-100k
    │   │       │   │       ├── README
    │   │       │   │       ├── allbut.pl
    │   │       │   │       ├── mku.sh
    │   │       │   │       ├── u.data
    │   │       │   │       ├── u.genre
    │   │       │   │       ├── u.info
    │   │       │   │       ├── u.item
    │   │       │   │       ├── u.occupation
    │   │       │   │       ├── u.user
    │   │       │   │       ├── u1.base
    │   │       │   │       ├── u1.test
    │   │       │   │       ├── u2.base
    │   │       │   │       ├── u2.test
    │   │       │   │       ├── u3.base
    │   │       │   │       ├── u3.test
    │   │       │   │       ├── u4.base
    │   │       │   │       ├── u4.test
    │   │       │   │       ├── u5.base
    │   │       │   │       ├── u5.test
    │   │       │   │       ├── ua.base
    │   │       │   │       ├── ua.test
    │   │       │   │       ├── ub.base
    │   │       │   │       └── ub.test
    │   │       │   └── pySparkTutorial.ipynb
    │   │       └── scala
    │   │           ├── scala.sh
    │   │           └── testing_scala.py
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
    │   │   ├── hive_complex_select.sql
    │   │   ├── hive_create_tables.sql
    │   │   └── hive_show.sql
    │   ├── impala
    │   │   └── impala_metadata.sql
    │   ├── oracle
    │   └── vertica
    ├── Interviews
    │   ├── aws.md
    │   ├── big_data.md
    │   ├── databricks.md
    │   ├── general_es.md
    │   ├── python.md
    │   └── sql.md
    ├── README.md
    ├── a_python
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
    │   ├── Virtual_Environments.sh
    │   ├── __init__.py
    │   ├── apps
    │   │   ├── AWSs3Purge.py
    │   │   ├── __init__.py
    │   │   ├── adding_sparse_vectors.py
    │   │   ├── aisj.py
    │   │   ├── batch.py
    │   │   ├── csv_schema_update.py
    │   │   ├── f.py
    │   │   └── lambda_function.py
    │   ├── data_engUtils
    │   │   ├── __init__.py
    │   │   ├── aws_utils.py
    │   │   ├── dashboard_utils.py
    │   │   ├── emr_cluster.py
    │   │   ├── gral_utils.py
    │   │   └── pyspark_utils.py
    │   └── tutorials
    │       ├── DScienceTutorial
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
    │       ├── PythonGoodPractices
    │       │   ├── GoodPractices.docx
    │       │   ├── Python-GoodPractices.html
    │       │   └── Python-GoodPractices.ipynb
    │       ├── Tutoriales_R_Python.txt
    │       ├── objets
    │       │   ├── OO_2.html
    │       │   ├── OO_2.ipynb
    │       │   ├── Python\ OOP.ipynb
    │       │   ├── Python+OOP.html
    │       │   ├── python_fundamentals_classes.html
    │       │   └── python_fundamentals_classes.ipynb
    │       ├── others
    │       │   ├── Basic\ and\ capture_nb.html
    │       │   ├── Data\ Munging.ipynb
    │       │   ├── Data+Munging.html
    │       │   ├── ML_python_y_R.py
    │       │   ├── charla_python_jeremyAchin.txt
    │       │   ├── ejerciciosConCSVs
    │       │   │   ├── check_csvFile.py
    │       │   │   ├── ejerciciosConCSVs.html
    │       │   │   ├── ejerciciosConCSVs.ipynb
    │       │   │   ├── p.csv
    │       │   │   ├── procesar_csv
    │       │   │   │   ├── Archivos\ (csv,\ txt,\ etc).ipynb
    │       │   │   │   ├── inicial.csv
    │       │   │   │   ├── inicial.txt
    │       │   │   │   ├── leerme.txt
    │       │   │   │   └── procesar_csv.zip
    │       │   │   ├── syc.sh
    │       │   │   └── u_rar.sh
    │       │   ├── estructura
    │       │   │   ├── __pycache__
    │       │   │   │   └── s2.cpython-35.pyc
    │       │   │   ├── estructura_pies.zip
    │       │   │   ├── s2.py
    │       │   │   ├── t.py
    │       │   │   ├── t2.py
    │       │   │   └── test.py
    │       │   ├── links_interesantesDataScience.txt
    │       │   └── py_hive_udfs
    │       │       ├── 00_test.py
    │       │       ├── a.py
    │       │       ├── b.py
    │       │       ├── blog_hive.py
    │       │       └── cc.py
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
    │       └── pytexas2015
    │           ├── PyTexas\ 2015\ ML\ Tutorial\ --\ Speaker\ Deck.url
    │           ├── pytexas-ml-tutorial.pdf
    │           ├── pytexas2015-ml-master
    │           │   ├── 0-Exploration.ipynb
    │           │   ├── 1-Feature_extraction.ipynb
    │           │   ├── 2-Modeling.ipynb
    │           │   ├── 3-Validation.ipynb
    │           │   ├── 4-Ensemble.ipynb
    │           │   ├── README.md
    │           │   └── environment.yml
    │           ├── pytexas2015-ml-master.zip
    │           └── pytexas_notas.txt
    ├── aws
    │   ├── clone_repo.sh
    │   ├── copy_data_across_accounts.sh
    │   ├── emr_bootstrap.sh
    │   └── lambda.md
    ├── git
    │   ├── git_cli.sh
    │   ├── modify_critical_branch.sh
    │   └── new_branch.sh
    ├── notes.md
    ├── others
    │   ├── bash_cron_time.sh
    │   ├── main_json.sh
    │   ├── many_cmds.sh
    │   ├── sed_useful_cmds.sh
    │   ├── ssh.sh
    │   └── system_commands.py
    └── setup.py
