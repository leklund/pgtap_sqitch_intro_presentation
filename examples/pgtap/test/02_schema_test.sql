BEGIN;
  SET search_path=pgtap_example, public;

  SELECT plan(4);
  SELECT has_schema( 'pgtap_example', 
    'pgtap_example schema should exist');
  SELECT has_table(  'tapper', 'table tapper should exist');
  SELECT col_is_pk(  'tapper', 'id' );
  SELECT columns_are('tapper',
    ARRAY['id', 'name', 'age', 'underage',
          'created_at', 'admin'],
    'table tapper should have certain columns');

  SELECT * FROM finish();

ROLLBACK;
