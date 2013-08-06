!SLIDE subsection transition=fade

# Draft Workflow

!SLIDE incremental

# Some conventions

* Changes for each schema is contained in it's own directory. Ex: `deploy/public/new_func.sql` or `deploy/reporting/new_report.sql`
* Tests are similiary namespaced
* Pull the latest copy of the develop branch and run all the tests before starting any new work.
* for larger bits of work use a feature branch

!SLIDE incremental
# Get up-to-date

* checkout develop branch and pull the latest and greatest
* run sqitch status on your development and test databases
* if there are changes to be deployes, run sqitch deploy
* using pg\_prove, run the tests to make sure everything is good to go.

!SLIDE incremental

# Test first. Query later

* create a new test for every change you plan to make
* if it' s a rework. rework the test to fail first
* actually write some tests BEFORE writing adding the sqitch change

!SLIDE incremental

# Make it pass

* sqitch add or rework the changes
* write your deploy/revert/verify
* deploy the locally and run your tests
* git commit and push
* sqitch tag and deploy to staging

!SLIDE incremental

# Deploy to production

* git flow release (for the automated tagging)
* git push
* sqitch deploy to production

!SLIDE incremental

# When can I revert?

* on your local development database, whenever you want
* on staging, only before it's been deployed to production
* on production, hopefully never.
