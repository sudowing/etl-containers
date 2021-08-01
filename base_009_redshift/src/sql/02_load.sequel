BEGIN;
LOCK public.some_table IN EXCLUSIVE MODE;
\copy public.some_table (field1, field2, field3) FROM 'input/source_file.psv' DELIMITER '|';
COMMIT;