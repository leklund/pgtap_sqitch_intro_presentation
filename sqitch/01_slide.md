!SLIDE subsection
<div class="page_header">
<h1>sqitch</h1>
<h2>sane database change management</h2>
</div>

!SLIDE bullets incremental transition=toss
# What is sqitch?

* Standalone change management system
* Native SQL
* sqitch + git + change

!SLIDE

# Why not migrations?

* they use an incomplete language
* numbered scipts are hard to track
* application specific (what happens when you need a function for 2 apps)

!SLIDE bullets incremental transition=toss
# sqitch philosophy

* no opinions
* native scripting
* cross-project dependency resolution
* no numbering
* distribution bundling
* future: VCS integration

.notes independent on ORM. changes can deoend on other changes. names not numbers.
.notes vcs integration will eventually interface with your vcs to create a plan
!SLIDE bullets incremental transition=toss
# sqitch philosophy

* reduced duplication
* built-in conifguration
* iterative development
* deployment planning
* git-style interface

!SLIDE bullets incremental transition=wipe
# sqitch terms

* change
* tag
* state
* plan
* add
* deploy

.notes change: unit of change in the db
.notes tag: think tag (alias for a single change)
.notes state: current state of db relative the plane
.notes plan: plan of deployment (order of changes with dependencies)


!SLIDE bullets incremental transition=wipe
# sqitch terms

* revert
* rebase
* rework
* verify
* committer
* planner


!SLIDE center
# get started

create a git repo

![new repo](images/01_sqitch_init.png)


!SLIDE center
# get started

init sqitch

![sqitch init](images/02_sqitch_init.png)


!SLIDE center
# sqitch configuration defaults

![sqitch conf](images/03_sqitch_conf.png)

!SLIDE center
# configuration

Tell sqitch who you are:

    $ sqitch config --user user.name '*'
    $ sqitch config --user user.email '*'

The --user flag will make changes to ~/.sqitch/sqitch.conf

![user conf](images/05_user_conf.png)

!SLIDE

# first change

sqitch add changename -n note

![sqitch add](images/04_base_schema.png)

!SLIDE command
# deploy/base\_schema.sql

    @@@ sql
    -- Deploy base_schema for sqitch_example
    BEGIN;

      CREATE SCHEMA sqex;

    COMMIT;

!SLIDE command
# revert/base\_schema.sql

    @@@ sql
    -- Revert base_schema for sqitch_example
    BEGIN;

      DROP SCHEMA sqex;

    COMMIT;

!SLIDE command
# verify/base\_schema.sql

    @@@ sql
    -- Verify base_schema for sqitch_example
    BEGIN;

      SELECT pg_catalog.has_schema_privilege(
        'sqex', 'usage'
      );

    COMMIT;

!SLIDE center
# first sqitch deploy

The first deploy will also create the sqitch schema and the associated meta-data tables that track sqitch activity. 

![deploy](images/06_deploy.png)

!SLIDE center
# verification
You can verify on the actual database as shown below, but you don't have to. That's the beauty of the verify script.

![dn](images/09_dn.png)

!SLIDE center
# revert and new config settings

![deploy](images/07_deploy2.png)

!SLIDE center
# sqitch status

In this case all changes have been deployed:

![status](images/08_status.png)

!SLIDE center
#sqitch log

only showing the last 3 changes. The log can also be filtered by event, committer, date, and change name.

![log](images/11_log.png)

!SLIDE center smaller
#sqitch metadata

Sqitch also records events in it's own set of metadata tables:

![log](images/10_events.png)
