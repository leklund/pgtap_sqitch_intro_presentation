!SLIDE subsection transition=fade

<div class='page_header'>
<h1>pgTAP</h1>
<h2>Unit Testing for PostgreSQL</h2>
</div>

!SLIDE bullets incremental
# What is pgTAP?

* A suite of database functions that make it easy to write TAP-emitting unit tests in `psql` scripts or xUnit-style tests.

.notes These are all written in plpgsql. Works best when used with pg\_prove, a perl app to run all the tests.
!SLIDE bullets incremental
# err. What's TAP?

* TAP, the Test Anything Protocol, is a simple text-based interface between testing modules in a test harness. TAP started life as part of the test harness for Perl but now has implementations in C/C++, Python, PHP, Perl.
* TAP output looks like

!SLIDE transition=scrollUp

    @@@ shell
    TAP version 13
    1..4
    ok 1 - Input file opened
    not ok 2 - First line of the input valid
      ---
      message: 'First line invalid'
      severity: fail
      data:
        got: 'Flirble'
        expect: 'Fnible'
      ...
    ok 3 - Read the rest of the file
    not ok 4 - Summarized correctly # TODO Not written yet
      ---
      message: "Can't make summary yet"
      severity: todo
      ...

!SLIDE bullets incremental transition=scrollDown

# Who shot who with the what now?

* TAP format is verbose but is both human and computer readable.
* the format is language agnostic. works with perl, phython, php, etc.
* Luckily, pgTAP also has a TAP consumer in pg\_prove

!SLIDE bullets incremental transition=wipe small

# Why pgTAP?

* TDD SQL!
* Allows actual testing of your database and not just through an ORM or an applicaiton level API. (less work)
* easily perform schema validation.
* In a multi-tenant database (multiple apps, multiple schemas) some functions may be global and pgTAP provides a central way to test not application specific.

!SLIDE
# Installation

1. Download, build, test, and install from here: http://pgxn.org/dist/pgtap/
2. brew install pgtap
3. OR, run the pgtap.sql file against your test database. THe file can be found in the kaboom sqitch repository in the vendor directory.

!SLIDE
# simple test example

You need to tell pgTAP how many tests you are running. And when the tests are complete, you need to clean up after yourself.

    @@@ SQL
    BEGIN;
      SELECT plan(1);

      SELECT ok(true, 'true is true');

      SELECT * finish();

    ROLLBACK;

!SLIDE commandline incremental
# run that test
    $ pg_prove -v 01_truth.sql
    01_truth.sql ..
    1..1
    ok 1 - true is true
    ok
    All tests successful.
    Files=1, Tests=1,  0 wallclock secs ( 0.02 usr +  0.01 sys =  0.03 CPU)
    Result: PASS

!SLIDE bullets incremental transition=fade
# I love it when a plan comes together

* the `plan()` function declares how many tests your script is going to run to protect against premature failure.
* At the end of your script, you should call `SELECT * FROM finish()` to tell pgTAP that test are complete. This will output diagnostics and perform cleanup.

!SLIDE smaller
# testing a schema

    @@@ SQL
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

!SLIDE commandline incremental
# run that schema test

    $pg_prove -v 02_schema_test.sql
    examples/pgtap/test/02_schema_test.sql ..
    1..4
    ok 1 - pgtap_example schema should exist
    ok 2 - table tapper should exist
    ok 3 - Column tapper(id) should be a primary key
    ok 4 - table tapper should have certain columns
    ok
    All tests successful.
    Files=1, Tests=4,  0 wallclock secs ( 0.02 usr +  0.01 sys =  0.03 CPU)
    Result: PASS

!SLIDE bullets incremental smaller

# you can test EVERYTHING!

* `SELECT ok(:boolean, :description);`
* `SELECT matches(:have, :regex, :description);`
* `SELECT throws_ok(:sql, :errcode, :ermsg, :description);`
* `SELECT results_eq(:sql, :sql OR :array ,  :description);`
* `SELECT columns_are(:schema, :table, :columns, :description);`
* `SELECT has_index(:schema, :table, :index, :columns );`
* `SELECT col_has_default(:schema, :table, :column, :description);`

!SLIDE

# more examples

* ./examples/pgtap/

.notes this is where we'll work through the function test example. 

# more documtentation

* <a href="http://pgtap.org/documentation.html">pgTAP docs</a>
* <a href="http://vimeo.com/7972197">pgTap best practices vimeo</a>
* <a href="http://www.slideshare.net/justatheory/pgtap-best-practices">pgTap best practices slides</a>
* <a href="http://www.pgcon.org/2013/schedule/events/615.en.html">agile database development presentation</a>

# not covered

* xUnit style testing.
* custom tests. 

.notes xUnit style testing allows all your tests to be functions stored in a testing schema rather than sql scripts. The tests can then be run from within a psql console.
