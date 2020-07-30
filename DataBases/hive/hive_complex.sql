-- Create array-struct in Hive
--      collect_list(): to create an array. Is necessary to group the fields.
--      named_struct(): to create structs, within the array or just only a struct.

CREATE TABLE db_name.table_name
STORED AS PARQUET AS
SELECT
    st.id as id,
    collect_list(
        named_struct (
            'Field_01', st.field1,
            'Struct_within', named_struct(
                    'Field_02',st.field2,
                    'Field_03',st.field3,
             ),
            'Field_04',st.field4,
         )
     ) as arbitrary_array_name
FROM
    source_table st
GROUP BY st.id;

-- Array size: In hive is possible to check the size of an array using the 'size' UDF.
--              This way is much faster than counting records inside the array.
SELECT
    tn.id,
    size(tn.array_1) array_1_size,
    size(tn.array_2) array_2_size
FROM
    table_name tn
limit 100;