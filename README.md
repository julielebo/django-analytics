
Scripts to gather data for Homework 3 of Software Metrics
========================================================

For all below, download and untar a django release (or multiple releases) and install Radon.

where a Django released is installed into a directory on your computer like:
DJANGO=~/development/Django-1.7.6
Functional, i.e. non-test, source code is considered:
* $DJANGO/django
Test source code is considered:
* $DJANGO/tests


To get LLOC (separated into non-test and test code) for each considered Django release:
========================================================
* cd into scripts/ directory
* execute:
    ./runRadon_getLLOC.sh ~/development/Django-1.7.6 ## of course, the path to your installation of Django may vary
* cd into results directory (script tells you where results went)
* for total LLOC metrics, use "tail -n *.out" to see summary data

To get CC grades (on non-test code):
========================================================
* cd into scripts/ directory
* execute:
    ./runRadon_getCCgrades.sh ~/development/Django-1.7.6 ## of course, the path to your installation of Django may vary
* cd into results directory (script tells you where results went)
* ls *cc*:
djangosrc_cc_summary.out - raw human-readable output
djangosrc_cc_json.out - raw JSON output
djangosrc_cc_json.out_grades - number of A, B, C, .., F complexity grades
djangosrc_cc_summary.out_avg_cc - average complexity of all code analyzed
djangosrc_cc_json.out_cc_filerank - sorted per max complexity score present per python file


