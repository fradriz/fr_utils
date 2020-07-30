# Install in mac: brew install parquet-tools

# List all the commands / help
parquet-tools -h

# List first line
parquet-tools head -n 1 file.snappy.parquet 2> /dev/null

# Count rows
parquet-tools rowcount file.snappy.parquet 2> /dev/null

parquet-tools rowcount part-00000-af47702b-edad-4362-93a2-f095120bd47d-c000.snappy.parquet 2> /dev/null
Total RowCount: 5651

# Print schema
parquet-tools schema part-00000-af47702b-edad-4362-93a2-f095120bd47d-c000.snappy.parquet 2> /dev/null

parquet-tools cat part-00000-af47702b-edad-4362-93a2-f095120bd47d-c000.snappy.parquet 2> /dev/null | head

# Metadata
$ parquet-tools meta part-00000-af47702b-edad-4362-93a2-f095120bd47d-c000.snappy.parquet 2> /dev/null
file:        file:/Users/facradri/PycharmProjects/pcs-spineds-solution/embedding/embedding_census_example/census_data/dt=2018-04-02_50K/part-00000-af47702b-edad-4362-93a2-f095120bd47d-c000.snappy.parquet
creator:     parquet-mr version 1.10.0 (build 031a6654009e3b82020012a18434c582bd74c73a)
extra:       org.apache.spark.sql.parquet.row.metadata = {"type":"struct","fields":[{"name":"PEL","type":"string","nullable":true,"metadata":{}},{"name":"features","type":{"type":"udt","class":"org.apache.spark.ml.linalg.VectorUDT","pyClass":"pyspark.ml.linalg.VectorUDT","sqlType":{"type":"struct","fields":[{"name":"type","type":"byte","nullable":false,"metadata":{}},{"name":"size","type":"integer","nullable":true,"metadata":{}},{"name":"indices","type":{"type":"array","elementType":"integer","containsNull":false},"nullable":true,"metadata":{}},{"name":"values","type":{"type":"array","elementType":"double","containsNull":false},"nullable":true,"metadata":{}}]}},"nullable":true,"metadata":{}},{"name":"label","type":"double","nullable":true,"metadata":{}},{"name":"logfeatures","type":{"type":"udt","class":"org.apache.spark.ml.linalg.VectorUDT","pyClass":"pyspark.ml.linalg.VectorUDT","sqlType":{"type":"struct","fields":[{"name":"type","type":"byte","nullable":false,"metadata":{}},{"name":"size","type":"integer","nullable":true,"metadata":{}},{"name":"indices","type":{"type":"array","elementType":"integer","containsNull":false},"nullable":true,"metadata":{}},{"name":"values","type":{"type":"array","elementType":"double","containsNull":false},"nullable":true,"metadata":{}}]}},"nullable":true,"metadata":{}}]}

file schema: spark_schema
--------------------------------------------------------------------------------
PEL:         OPTIONAL BINARY O:UTF8 R:0 D:1
features:    OPTIONAL F:4
.type:       REQUIRED INT32 O:INT_8 R:0 D:1
.size:       OPTIONAL INT32 R:0 D:2
.indices:    OPTIONAL F:1
..list:      REPEATED F:1
...element:  REQUIRED INT32 R:1 D:3
.values:     OPTIONAL F:1
..list:      REPEATED F:1
...element:  REQUIRED DOUBLE R:1 D:3
label:       OPTIONAL DOUBLE R:0 D:1
logfeatures: OPTIONAL F:4
.type:       REQUIRED INT32 O:INT_8 R:0 D:1
.size:       OPTIONAL INT32 R:0 D:2
.indices:    OPTIONAL F:1
..list:      REPEATED F:1
...element:  REQUIRED INT32 R:1 D:3
.values:     OPTIONAL F:1
..list:      REPEATED F:1
...element:  REQUIRED DOUBLE R:1 D:3

row group 1: RC:5651 TS:2841104 OFFSET:4
--------------------------------------------------------------------------------
PEL:          BINARY SNAPPY DO:0 FPO:4 SZ:328528/362449/1.10 VC:5651 ENC:RLE,PLAIN,BIT_PACKED ST:[min: XY6193--HVadUTlBNnJ49auUzqlwBHs5xnnsU7bDpSWQ4LS7g, max: Xi6193zzI6DGmxPlV5rXDcuncpPLPKVl0dYBb9rmJ54yT4W0kYuFG6rcde5IcwputFPwhS, num_nulls: 0]
features:
.type:        INT32 SNAPPY DO:0 FPO:328532 SZ:77/73/0.95 VC:5651 ENC:RLE,PLAIN_DICTIONARY,BIT_PACKED ST:[min: 0, max: 0, num_nulls: 0]
.size:        INT32 SNAPPY DO:0 FPO:328609 SZ:77/73/0.95 VC:5651 ENC:RLE,PLAIN_DICTIONARY,BIT_PACKED ST:[min: 396, max: 396, num_nulls: 0]
.indices:
..list:
...element:   INT32 SNAPPY DO:0 FPO:328686 SZ:486467/498352/1.02 VC:420931 ENC:RLE,PLAIN_DICTIONARY ST:[min: 0, max: 395, num_nulls: 0]
.values:
..list:
...element:   DOUBLE SNAPPY DO:0 FPO:815153 SZ:607006/740415/1.22 VC:420931 ENC:RLE,PLAIN_DICTIONARY ST:[min: 2.0, max: 4195950.0, num_nulls: 0]
label:        DOUBLE SNAPPY DO:0 FPO:1422159 SZ:836/829/0.99 VC:5651 ENC:RLE,PLAIN_DICTIONARY,BIT_PACKED ST:[min: -0.0, max: 1.0, num_nulls: 0]
logfeatures:
.type:        INT32 SNAPPY DO:0 FPO:1422995 SZ:77/73/0.95 VC:5651 ENC:RLE,PLAIN_DICTIONARY,BIT_PACKED ST:[min: 0, max: 0, num_nulls: 0]
.size:        INT32 SNAPPY DO:0 FPO:1423072 SZ:77/73/0.95 VC:5651 ENC:RLE,PLAIN_DICTIONARY,BIT_PACKED ST:[min: 396, max: 396, num_nulls: 0]
.indices:
..list:
...element:   INT32 SNAPPY DO:0 FPO:1423149 SZ:486467/498352/1.02 VC:420931 ENC:RLE,PLAIN_DICTIONARY ST:[min: 0, max: 395, num_nulls: 0]
.values:
..list:
...element:   DOUBLE SNAPPY DO:0 FPO:1909616 SZ:629965/740415/1.18 VC:420931 ENC:RLE,PLAIN_DICTIONARY ST:[min: 1.0986122886681098, max: 15.249630570641768, num_nulls: 0]