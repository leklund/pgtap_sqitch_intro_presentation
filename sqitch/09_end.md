!SLIDE incremental
# A few custom verifications

I've added a few custom <a href="https://gist.github.com/leklund/6165100">plgpsql functions</a> to help with verification so that one does not have to use `select 1/count(*)` expressions to test for existence of objects.

* `select verify_index_exists( 'idx', 'schema');`
* `select verify_index_exists( ARRAY['idx1', 'idx2', 'schema');`
* `select verify_trigger_exists( 'chk_trigger', 'table');`

.notes First draft of the functions here: https://gist.github.com/leklund/6165100 (need to update to default to public and and a function to check the function body for a string)


!SLIDE
# <a href="http://sqitch.org">sqitch</a> resources

* <a href="https://metacpan.org/module/sqitchtutorial">sqitch postgresql tutorial</a>
* <a href="http://www.pgcon.org/2013/schedule/events/615.en.html">Agile Database Development</a>
* <a href="http://search.cpan.org/~dwheeler/App-Sqitch-0.973/lib/sqitch.pod">Sqitch POD</a>

