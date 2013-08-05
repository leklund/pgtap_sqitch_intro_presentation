BEGIN;

  DROP SCHEMA IF EXISTS pgtap_example CASCADE;
  CREATE SCHEMA pgtap_example;

  set search_path = pgtap_example,public;

  CREATE TABLE tapper (
    id serial primary key,
    name text,
    age integer,
    underage boolean not null default true,
    created_at timestamptz not null default now(),
    admin boolean not null default false
  );

  CREATE INDEX tapper_name_idx on tapper(name);

  CREATE FUNCTION tapper_underage_manager() RETURNS TRIGGER AS
  $$
  BEGIN
    IF NEW.age > 20 THEN
      NEW.underage := FALSE;
    ELSE
      NEW.underage := TRUE;
    END IF;
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;

  CREATE TRIGGER tapper_age_check before INSERT OR UPDATE on tapper
    FOR EACH ROW EXECUTE PROCEDURE tapper_underage_manager();

  CREATE OR REPLACE FUNCTION tapper_is_underage(IN _id integer) RETURNS INTEGER AS
  $$
  SELECT CASE WHEN underage THEN 1 ELSE 0 END from pgtap_example.tapper
  WHERE id = $1;
  $$ LANGUAGE sql STABLE;


COMMIT;
