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

![new repo](images/01_sqitch_init.png)


!SLIDE center
# get started

![sqitch init](images/02_sqitch_init.png)


!SLIDE center
# sqitch conf

![sqitch conf](images/03_sqitch_conf.png)

