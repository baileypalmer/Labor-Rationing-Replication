/* 
This do file contains code that does the following: 
Step 1: installs STATA packages 
Step 2: generates the data sets used in reproducing the figures and tables in "Labor Rationing" (Breza, Kaur & Shamdasani)
Step 3: replicates all the main figures in "Labor Rationing" (Breza, Kaur & Shamdasani)
Step 4: replicates all the main tables in "Labor Rationing" (Breza, Kaur & Shamdasani)
Step 5: replicates all the appendix figures in "Labor Rationing" (Breza, Kaur & Shamdasani)
Step 6: replicates all the appendix tables in "Labor Rationing" (Breza, Kaur & Shamdasani)
*/

clear all 
set more off 

* Set directory for data and code 
	* This must be modified by the user 
	global dir <<insert directory here>>
	cd "$dir"

* Set directory for output  
	global dir_output <<insert directory here>>

* Step 1: Install packages 
 	do "./code/install_packages.do"

* Step 2: Create analysis data
	* Worker data  
	do "./code/create_rationing_worker.do"
	do "./code/create_rationing_worker_nodrop.do"

	* Employer data 
	do "./code/create_rationing_employer.do"
	do "./code/create_rationing_employer_nodrop.do"

	* NREGA data  
	do "./code/create_rationing_nrega.do"	

* Step 3: Generate main figures of paper
	do "./code/rationing_figures.do"

* Step 4: Generate main tables of paper 
	do "./code/rationing_tables.do"

* Step 5: Generate appendix figures of paper 
	do "./code/rationing_appendix_figures.do"

* Step 6: Generate appendix tables of paper 
	do "./code/rationing_appendix_tables.do"

	