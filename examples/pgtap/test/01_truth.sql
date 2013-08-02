BEGIN;

  SELECT plan(1);

  SELECT ok(true, 'true is true');

  SELECT * FROM finish();

ROLLBACK;
