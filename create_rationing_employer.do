
/* This do file contains code that generates rationing_employer.dta, which is used in reproducing the main figures and tables in "Labor Rationing" (Breza, Kaur & Shamdasani) */
			
use "./data/rawdata/rationing_employer_raw.dta", clear

** Generate variables 

* occupation categories 
	gen temp = (prime_occ==1 | prime_occ==2 | sec_occ==1 | sec_occ==2)
	egen occupselfempagri = max(temp), by(empid)
	drop temp 
	
	gen temp = (prime_occ==3 | prime_occ==4 | sec_occ==3 | sec_occ==4)
	egen occupselfempnonagri = max(temp), by(empid)
	drop temp 

	gen temp = (prime_occ==5 | prime_occ==6 | sec_occ==5 | sec_occ==6)
	egen occuplab = max(temp), by(empid)
	drop temp 

* caste 
	gen temp = social_category
	egen temp2 = max(temp), by(empid)
	gen scst = (temp2==1 | temp2==2)
	drop temp* 

* household members
	egen tot_hh_mem = rowtotal(hh_mem_f hh_mem_m), missing 

* land
	gen totland_w = totland 
	sum totland if grid_id==1, d 
	replace totland_w = r(p99) if totland_w > r(p99) & totland_w !=.

* indicator for activities that took place prior to the start of the hiring shock
	gen flag_activity_preshock = (hiring_date < date_ws_start)
		replace flag_activity_preshock=. if hiring_date==.

* keep observations where activity took place after the start of the hiring shock
	keep if flag_activity_preshock==0

* activity location: inside the village 
	gen hiring_invillage = (hiring_location==1)
		replace hiring_invillage=. if hiring_location ==.

* hired worker count 
	egen hiring_wage_tot = rowtotal(hiring_wage_m hiring_wage_f)

* daily wage
	gen paiddailywage  = (hiring_wage_type ==1)
	gen dailywagecash = hiring_wage_cash if paiddailywage==1
	gen temp = hiring_wage_inkind/hiring_wage_tot
	gen temp2 = temp if paiddailywage==1
	egen dailywagetot = rowtotal(dailywagecash temp2), missing 
	drop temp*  

	* winsorize at 99 percentile 
	gen dailywagecash_w = dailywagecash
	sum dailywagecash, d
		replace dailywagecash_w = r(p99) if dailywagecash_w > r(p99) & dailywagecash_w!=.
	
	gen dailywagetot_w = dailywagetot
	sum dailywagetot, d 
		replace dailywagetot_w = r(p99) if dailywagetot_w > r(p99) & dailywagetot_w!=.

* log wage
	gen ldailywagecash_w = log(dailywagecash_w)
	gen ldailywagetot_w = log(dailywagetot_w)
		
* hired from inside village
	gen hiring_wrkrs_ownvlg_m_binary = .
		replace hiring_wrkrs_ownvlg_m_binary = 1 if hiring_wrkrs_ownvlg_m>0 & hiring_wrkrs_ownvlg_m!=.
		replace hiring_wrkrs_ownvlg_m_binary = 0 if hiring_wrkrs_ownvlg_m==0 & hiring_wrkrs_ownvlg_m!=.
	bys empid: egen hire_inside_vill_m = max(hiring_wrkrs_ownvlg_m_binary)

* hired from outside village
	gen hiring_wrkrs_outsidevill = (hiring_wrkrs_live==2 | hiring_wrkrs_live==4)
		replace hiring_wrkrs_outsidevill = . if hiring_wrkrs_live==. | hiring_wrkrs_live<0

	gen hiring_wrkrs_outvlg_m_binary = .
		replace hiring_wrkrs_outvlg_m_binary = 1 if hiring_wrkrs_outvlg_m>0 & hiring_wrkrs_outvlg_m!=.
		replace hiring_wrkrs_outvlg_m_binary = 0 if hiring_wrkrs_outvlg_m==0 & hiring_wrkrs_outvlg_m!=.
	bys empid: egen hire_outside_vill = max(hiring_wrkrs_outsidevill)
	bys empid: egen hire_outside_vill_m = max(hiring_wrkrs_outvlg_m_binary)

	gen hire_outside_vill_m0 = hire_outside_vill_m
	replace hire_outside_vill_m0 = 0 if hire_outside_vill_m0==.

** Drop variables that are not required in analysis 
	drop hiring_past30 hiring_activity_code hiring_date date_ws_start hiring_location hiring_wage_m hiring_wage_f hiring_wage_type hiring_wage_cash hiring_wage_inkind hh_mem_f hh_mem_m social_category acretoguntaconv hiring_wage_tot paiddailywage totland hire_outside_vill hiring_wrkrs_live hiring_wrkrs_ownvlg_m hiring_wrkrs_outvlg_m hiring_wrkrs_ownvlg_m_binary hiring_wrkrs_outvlg_m_binary hiring_wrkrs_outsidevill hiring_wrkrs_ownvlg_m hiring_wrkrs_outvlg_m hire_inside_vill_m hire_outside_vill_m prime_occ sec_occ dailywagecash dailywagetot dailywagecash_w dailywagetot_w
	
** Label all variables 
	do "./code/label_vars_rationing_employer.do"

save "./data/cleandata/rationing_employer.dta", replace 
