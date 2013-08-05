BEGIN;

  SET search_path=pgtap_example, public;

  SELECT plan(10);

  -- SELECT has_function( :schema, :function, :args, :description );

  SELECT has_function('pgtap_example', 'tapper_underage_manager',
    'tapper_underage_manager() should exist' );
  SELECT has_function('pgtap_example', 'tapper_is_underage', ARRAY['integer'],
    'tapper_is_underage(int) should exist' );

  SELECT hasnt_function('pgtap_example', 'tapper_is_underage', ARRAY['varchar'],
    'tapper_is_underage(varchar) should not exists' );

  -- SELECT function_returns( :schema, :function, :args, :type, :description );
  SELECT function_returns('pgtap_example', 'tapper_is_underage', ARRAY['integer'], 'boolean',
    'tapper_is_underage(int) should return boolean' );

  -- SELECT has_trigger( :schema, :table, :trigger, :description );
  SELECT has_trigger('pgtap_example', 'tapper', 'tapper_age_check',
    'Trigger tapper_age_check should exists on table tapper' );

  -- SELECT function_lang_is( :schema, :function, :language, :description );

  SELECT function_lang_is('pgtap_example', 'tapper_underage_manager', 'plpgsql',
    'tapper_underage_manager should be plpgsql' );

  SELECT function_lang_is('pgtap_example', 'tapper_is_underage', 'sql',
    'tapper_age_check should be sql' );

  -- INSERT a couple rows to test.
  INSERT INTO tapper (id, name, age) VALUES (1, 'arthur dent', 42), (2, 'zaphod beeblebrox', 17);

  -- OK
  SELECT ok(NOT tapper_is_underage(1), 'tapper_is_underage should return false for age 42');
  SELECT ok(tapper_is_underage(2), 'tapper_is_underage should return true for age 17');

  UPDATE tapper set age = 21 WHERE id = 2;

  SELECT ok(NOT tapper_is_underage(2), 'tapper_is_underage should return false after age update');



ROLLBACK;

