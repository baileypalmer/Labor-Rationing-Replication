
/* This do file contains code that generates rationing_nrega_worker.dta and rationing_nrega.dta. These two data sets are used in reproducing Appendix Table 11 and Appendix Figures 6 and 7 in "Labor Rationing" (Breza, Kaur & Shamdasani) */
	
use "./data/rawdata/NREGA_preperiod_data", clear
	
* Collapse data to individual level 
	collapse (max) hiredemp mult month month_bin nonag_self usualag usualcas (sum) casual_days unempl_days self_days (mean) lpc caswage_w_pre, ///
		by(round statename districtname hid indiv)

* Collapse data to round-district-month level
	//weight by multiplier
	gen casual_days_Mult = casual_days*mult
	gen unempl_days_Mult = unempl_days*mult
	gen self_days_Mult = self_days*mult
	gen nonag_days_Mult = hiredemp*mult
	gen nonag_self_days_Mult = nonag_self*mult
	gen usualag_Mult = usualag*mult
	gen usualcas_Mult = usualcas*mult
	gen caswage_Mult = caswage_w_pre*mult
	gen mult_wage = mult*(caswage_Mult~=.)
	gen numind = 1

save "./data/cleandata/rationing_nrega_worker.dta", replace
	
	collapse (sum) usualag_Mult usualcas_Mult nonag_days_Mult casual_days_Mult unempl_days_Mult ///
		self_days_Mult nonag_self_days_Mult mult numind caswage_Mult mult_wage, ///
		by(round statename districtname month month_bin)

	//generate unweighted vars again
	gen casual_days = casual_days_Mult/mult
	gen unempl_days = unempl_days_Mult/mult
	gen self_days = self_days_Mult/mult
	gen nonag_days = nonag_days_Mult/mult
	gen nonag_self_days = nonag_self_days_Mult/mult
	gen usualag_frac = usualag_Mult/mult
	gen caswage_pre = caswage_Mult/mult_wage

***** Generate heterogeneity and control variables from pre-period, district-level data
* Collapse data to district level - controls 
	preserve
	collapse (mean) nonag_days casual_days unempl_days self_days nonag_self_days usualag_frac mult, by(statename districtname)
	rename usualag_frac usualag_frac_pre
	gen frac_nonag_pre = (nonag_days + nonag_self_days)/(casual_days +self_days)

	save "./data/cleandata/NREGA_pre_frac_ag.dta", replace
	restore
	
* Collapse data to district-month level - labor market heterogeneity variable
	preserve
	collapse (mean) nonag_days casual_days unempl_days self_days nonag_self_days usualag_frac caswage_pre (sum) numind, by(statename districtname month)
		* Collapse across rounds

	su numind, detail
		
	rename casual_days casual_days_month_pre
	su casual_days_month_pre, detail
	return list
	local cas_median = r(p50)

	rename nonag_days nonag_days_month_pre
	su nonag_days_month_pre, detail
	return list
	local nonag_median = r(p50)
	
	rename self_days self_days_month_pre
	su self_days_month_pre, detail
	return list
	local self_median = r(p50)

	gen high_cdays_pre = (casual_days_month_pre>`cas_median')
	label var high_cdays_pre "Above median casual employment district x month"

	save "./data/cleandata/NREGA_pre_month_casual_labor.dta", replace
	restore

************************************************************************

* Merge in the heterogeneity data sets into main data 	
	use "./data/rawdata/NREGA_panel.dta", clear

	merge m:1 statename districtname using "./data/cleandata/NREGA_pre_frac_ag.dta", assert(2 3) keep(3) nogen
	/* drop if _merge==2
	assert _merge==3 
	drop _merge */

	merge m:1 statename districtname month using "./data/cleandata/NREGA_pre_month_casual_labor.dta", ///
		assert(1 2 3) keep(1 3)
	/* drop if _merge==2 */
	gen no_monthpre_match = (_merge==1)
	drop _merge

	//zero pre-period days in NREGA if you don't match 
	foreach var of varlist high_cdays_pre casual_days_month_pre nonag_days_month_pre self_days_month_pre {
		replace `var'=0 if no_monthpre_match==1
	}
	/* replace high_cdays_pre=0 if no_monthpre_match==1
	replace casual_days_month_pre=0 if no_monthpre_match==1
	replace nonag_days_month_pre=0 if no_monthpre_match==1
	replace self_days_month_pre=0 if no_monthpre_match==1 */

* Generate interaction terms 
	label var NREGA "Program"
	gen missing64 = (round==64)*no_monthpre_match
	gen casual_days_month_pre64 = (round==64)*casual_days_month_pre
	gen nonag_days_month_pre64 = (round==64)*nonag_days_month_pre

	
	gen NREGA_chigh = NREGA * high_cdays_pre
	gen high_cdays_pre_64 = high_cdays_pre*(round==64)
	label var NREGA_chigh "Program x cas high"
		
* Generate variables
	foreach var of varlist female EducCat1 EducCat2 EducCat3 EducCat4 EducCat5 ///
		EducCat6 Age31to40 Age41to50 Age51to60 {
			gen `var'_p = `var'*(round==64)
		}
	/* gen female_p = female*(round==64)
	gen EducCat1_p = EducCat1*(round==64)
	gen EducCat2_p = EducCat2*(round==64)
	gen EducCat3_p = EducCat3*(round==64)
	gen EducCat4_p = EducCat4*(round==64)
	gen EducCat5_p = EducCat5*(round==64)
	gen EducCat6_p = EducCat6*(round==64)
	gen Age31to40_p = Age31to40*(round==64)
	gen Age41to50_p = Age41to50*(round==64)
	gen Age51to60_p = Age51to60*(round==64) */

	gen self_days_all = self_days + domduties_days

	* Redefine weights for wage -- only uses info from days when there is work.
	gen mult_wage = mult*casual_days
	gen ym = round*100 + month

	gen casual_days_month_pre_64 = casual_days_month_pre*(round==64)
	gen nonag_days_month_pre_64 = nonag_days_month_pre*(round==64)
	*gen unempl_days_month_pre_64 = unempl_days_month_pre*(round==64) 
	gen self_days_month_pre_64 = self_days_month_pre*(round==64)
	replace self_days_month_pre_64=0 if missing64==1

	gen caswage_pre_64 = caswage_pre*(round==64)
	gen caswage_pre_64_missing = (caswage_pre_64==.) if missing64~=.
	replace caswage_pre_64=0 if caswage_pre_64_missing==1

	gen usualag_frac_pre_64 = usualag_frac_pre*(round==64)
	gen frac_nonag_pre_64 =  frac_nonag_pre*(round==64)
    gen usualag_frac_pre_64_2 = usualag_frac_pre_64^2  
    gen frac_nonag_pre_64_2 = frac_nonag_pre_64^2
	
* Label variables 
	label var caswage_w1 "Casual Wage"
	label var agdays "Casual Agri. Days"
	label var self_days_all "Self-Empl. Days"
	label var pubworks_days "Public Works Days"
	label var NREGA "NREGA"
	label var NREGA_chigh "NREGA x High Casual Employment"
	label var lpc "Land per Capita"

save "./data/cleandata/rationing_nrega.dta", replace
