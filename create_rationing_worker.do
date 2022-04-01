
/* This do file contains code that generates rationing_worker.dta, which is used in reproducing the figures and tables in "Labor Rationing" (Breza, Kaur & Shamdasani) */

use "./data/rawdata/rationing_worker_raw.dta", clear 
	
** Generate variables 

* unique village/worker/experimental round indicator
	bys vill_id: gen vill1 = 1 if _n==1
	bys UID: gen uid1 = 1 if _n==1
	bys round_id: gen round1= 1 if _n==1

* indicator for valid grid days in baseline survey
	gen bl_valid_gridday = 0 
		* date of grid entry precedes start date of hiring shock
		replace bl_valid_gridday = 1 if grid_date<date_ws_start & surv_bl==1 

* landholdings 
	gen noland = (own_land_acres==0 & own_land_guntas==0)

	gen own_land_acres_temp = own_land_acres
		replace own_land_acres_temp = . if (own_land_acres<0 | own_land_acres==.) 
	gen own_land_guntas_temp = own_land_guntas
		replace own_land_guntas_temp = . if (own_land_guntas<0 | own_land_guntas==.)
		replace own_land_guntas_temp = own_land_guntas_temp/acretoguntaconv
	egen ownland = rowtotal(own_land_acres_temp own_land_guntas_temp), missing 
	drop own_land_acres_temp own_land_guntas_temp
	gen ownland_miss = ((own_land_acres<0 | own_land_acres==.) & (own_land_guntas<0 | own_land_guntas==.))

	gen land_share_acres_temp = land_share_acres
		replace land_share_acres_temp = . if (land_share_acres<0 | land_share_acres==.)
	gen land_share_guntas_temp = land_share_guntas
		replace land_share_guntas_temp = . if (land_share_guntas<0 | land_share_guntas==.)
		replace land_share_guntas_temp= land_share_guntas_temp/acretoguntaconv
	egen sharecropland = rowtotal(land_share_acres_temp land_share_guntas_temp), missing 
	drop land_share_acres_temp land_share_guntas_temp
	gen sharecropland_miss = ((land_share_acres<0 | land_share_acres==.) & (land_share_guntas<0 | land_share_guntas==.))
	
	egen totalland = rowtotal(sharecropland ownland), missing  
	gen totalland_miss = (ownland_miss==1 & sharecropland_miss==1)
	drop ownland_miss sharecropland_miss 

* hh members 
	egen tot_hh_mem = rowtotal(hh_mem_f hh_mem_m), missing 
	gen tot_hh_mem_miss = (tot_hh_mem==.)
	gen tot_hh_mem_nm = tot_hh_mem
		replace tot_hh_mem_nm=0 if tot_hh_mem==.
		
* occupation: farm
	gen occup_anyfarm = 0
		replace occup_anyfarm = 1 if prime_occ==1 | prime_occ==2 | sec_occ==1 | sec_occ==2
		replace occup_anyfarm = . if prime_occ==.
		
	gen occup_anyfarm_nm = 0
		replace occup_anyfarm_nm = 1 if prime_occ==1 | prime_occ==2 | sec_occ==1 | sec_occ==2
		replace occup_anyfarm_nm = 2 if prime_occ==.

* employment variables (grid day level)
	* worked 
	gen e_worked = (work_status==1)
	
	* manual labor in agriculture or non-agriculture
	gen e_manlab = (activity_code==2 | activity_code==2.1 | activity_code==4 )
	
	* self-employment - own farm or business
	gen e_self = (activity_code==1 | activity_code==3 )

	* any activity (including domestic duties)
	gen e_any = (work_status==1 | (work_status==0 & activity_code==9))

	* earned a wage
	gen e_wage = (wage_type== -98 | (wage_type>=1 & wage_type<=5))
	
	* manual labor for a wage
	gen e_manwage = e_wage*e_manlab
		* exclude work done under hiring shock in later rounds 
		replace e_manwage = 0 if e_worksite==1 & surv_el==1
	
	* self-employment - in agri
	gen e_selfagri = (activity_code==1)

	* self-employment - in nonagri
	gen e_selfnonagri = (activity_code==3)
	
	* public works
	gen e_publicworks = (activity_code==5)

	* wanted a job - NSS defn
	gen e_wanted = (activity_code==7)

	* hours 
	gen hours = tot_hr_wrk_hh + tot_hr_wrk_mm/60
		* this was not collected in one experimental round

	foreach x of varlist e_self e_selfagri e_selfnonagri {
		gen `x'_hours = hours if `x'==1
		replace `x'_hours = 0 if `x'==0
	}

	* would have prefered a daily wage job over what they did, unless they had a wage job that day 
	gen e_prefer = (accept_dailywageoffer==1 & e_manwage==0)

* employment variables at endline (cumulative over all grid days)
	bys UID: egen e_manwage_tot = sum(e_manwage) if surv_el==1
		* standardize to 7 grid days
		replace e_manwage_tot = (e_manwage_tot/tot_grid_days) * 7

	bys UID: egen e_self_tot = sum(e_self) if surv_el==1
		* standardize to 7 grid days
		replace e_self_tot = (e_self_tot/tot_grid_days) * 7

	bys UID: egen e_selfagri_tot = sum(e_selfagri) if surv_el==1
		* standardize to 7 grid days
		replace e_selfagri_tot = (e_selfagri_tot/tot_grid_days) * 7

* total self-employment (household level)
	egen self_tot = rowtotal(e_self_tot e_self_hh_tot)
		* e_self_hh_tot not collected across all workers in some early rounds 
		replace self_tot=. if round_id <9 | round_id==11

* total hired labor on farm at endline (household level)
	gen h_agri = (hiring_activity_code >0 & hiring_activity_code<10) | (hiring_activity_code>11 & hiring_activity_code<16)
		replace h_agri=. if hiring_activity_code<0 | hiring_activity_code==.
	bys UID: egen h_agri_any = max(h_agri) if surv_el==1 

	egen temp = rowtotal(hiring_wage_m hiring_wage_f)
	gen temp2 = temp*hiring_days
	bys UID: egen temp3 = sum(temp2) if h_agri==1 & surv_el==1
	bys UID: egen h_agri_hire = max(temp3) if surv_el==1
		replace h_agri_hire = 0 if hiring_past30==0
		replace h_agri_hire = 0 if hiring_past30 > 0 & hiring_past30!=. & h_agri_any==0 
	drop temp* 	

* total labor use on farm in past 7 days (household level)
	gen h_agri_hire7 = (h_agri_hire/30)*7
	* hh ag self-emp + own ag self-emp + hired ag labor 
	egen farm_labor_tot = rowtotal(e_selfagri_hh_tot e_selfagri_tot h_agri_hire7)
		*e_selfagri_hh_tot not collected across all workers in some early rounds 
		replace farm_labor_tot=. if round_id <9 | round_id==11
		
* male household members employment variables (household level)
	egen hh_m_self_emp = rowtotal(hh_m_work_ownland hh_m_work_hhbiz), missing

* daily wage 
	gen gotdailywage = (wage_type==1)
	gen cashamt = wage_cash
	replace cashamt = 0 if cashamt<0 | cashamt>=.
	gen inkamt = wage_inkind
	replace inkamt = 0 if inkamt<0 | inkamt>=.

	gen dailywagecash = cashamt if gotdailywage==1
	gen dailywageink = inkamt if gotdailywage==1
	gen dailywagetot = dailywagecash + dailywageink

	* winsorize at 99 percentile 
	gen dailywagecash_w = dailywagecash if (surv_el==1 | surv_post==1) & e_manwage==1
		sum dailywagecash if (surv_el==1 | surv_post==1) & e_manwage==1, d
		replace dailywagecash_w = r(p99) if dailywagecash_w>r(p99) & dailywagecash_w!=.

	gen dailywagetot_w = dailywagetot if (surv_el==1 | surv_post==1) & e_manwage==1
		sum dailywagetot if (surv_el==1 | surv_post==1) & e_manwage==1, d
		replace dailywagetot_w = r(p99) if dailywagetot_w>r(p99) & dailywagetot_w!=.

* hourly wage
	gen hourlywagetot = dailywagetot/hours
	gen hourlywagetot_w = dailywagetot_w/hours

* log wage
	gen ldailywagecash = log(dailywagecash)
	gen ldailywageink = log(dailywageink)
	gen ldailywagetot = log(dailywagetot)
	gen ldailywagecash_w = log(dailywagecash_w)
	gen ldailywagetot_w = log(dailywagetot_w)

* worker-employer interactions
	* winsorize at 95 percentile
	gen emp_expect_work_days_w = emp_expect_work_days
	sum emp_expect_work_days if surv_el==1 & sample_spillover==1 & grid_id==1, d 
	replace emp_expect_work_days_w = r(p95) if emp_expect_work_days_w > r(p95) & emp_expect_work_days_w!=.

* peak variable	
	egen temp = mean(e_manwage) if surv_el==1 & sample_signup==1 & sample_hiringshock==0 & treat==0 & survey_not_complete==0, by(month_el)
	egen avg_emanwage_ctrl = max(temp), by(round_id)
	sum avg_emanwage_ctrl if round1==1, det
	gen peak = (avg_emanwage_ctrl>=r(p50)) 
	* continuous version 
	gen peakc = avg_emanwage_ctrl

* average hired wage employment rate (control villages) by month 
	bys month_el: egen avg_emanwage_month = max(temp)
	drop temp

* fraction of labor force who sign up (size of hiring shock)
	* in experimental rounds where we did census, we have lcount 
	gen frac_signup_temp = tot_signedup/lcount if have_census==1
		* impute with median, separately by peak and lean
		sum frac_signup_temp if vill1==1 & peak==0, det 
		replace frac_signup_temp = r(p50) if frac_signup_temp==. & peak==0
		sum frac_signup_temp if vill1==1 & peak==1, det 
		replace frac_signup_temp = r(p50) if frac_signup_temp==. & peak==1

	* Implied population size of casual male laborers in each village
	gen lf_estim = lcount if round_id>=29
		replace lf_estim = tot_signedup/frac_signup_temp if round_id<29
	gen frac_signup = tot_sampleframe/lf_estim
	drop frac_signup_temp

	gen frac_hired = tot_recruited/lf_estim

	gen frac_nonsignups_survey  = el_nel_tot/lf_estim
	replace frac_nonsignups_survey = el_nel_tot/hhcount if round_id>=29

* avg self-emp in control village (by experimental round)
	capture drop temp 
	egen temp = mean(e_self) if surv_el==1 & sample_signup==1 & sample_hiringshock==0 & treat==0, by(round_id)
	egen avg_eself_ctrl = max(temp), by(round_id)
	drop temp 

	egen temp = mean(e_selfagri) if surv_el==1 & sample_signup==1 & sample_hiringshock==0 & treat==0, by(round_id)
	egen avg_eselfagri_ctrl = max(temp), by(round_id)
	drop temp  
	
	egen temp = mean(e_selfnonagri) if surv_el==1 & sample_signup==1 & sample_hiringshock==0 & treat==0, by(round_id)	
	egen avg_eselfnonagri_ctrl = max(temp), by(round_id)	
	drop temp  

** Baseline covariates at worker-level 

* ever participate in labor market?
	gen temp1_bl = parti_lm==1 if surv_bl==1 & bl_valid_gridday==1
	gen temp1_el = parti_lm==1 if surv_el==1
	egen temp2_bl = max(temp1_bl), by(UID)
	egen temp2_el = max(temp1_el), by(UID)
	gen bl_partic = temp2_bl 
		replace bl_partic = temp2_el if temp2_bl==.
	drop temp*

* days would like work in next 30 days
	gen temp = days_would_like_work if surv_bl==1 & days_would_like_work!=. & bl_valid_gridday==1
	egen bl_daysworkfut30 = max(temp), by(UID)
	gen bl_daysworkfut30_miss = (bl_daysworkfut30==.)
		replace bl_daysworkfut30 = 0 if bl_daysworkfut30==. 
	drop temp*

* e_manwage
	egen temp = mean(e_manwage) if surv_bl==1 & bl_valid_gridday==1, by(UID)
	egen bl_e_manwage = max(temp), by(UID)
	gen bl_e_manwage_miss = (bl_e_manwage==.)
		replace bl_e_manwage = 0 if bl_e_manwage==.
	drop temp*

* e_any
	egen temp = mean(e_any) if surv_bl==1 & bl_valid_gridday==1, by(UID)
	egen bl_e_any = max(temp), by(UID)
	gen bl_e_any_miss = (bl_e_any==.)
		replace bl_e_any = 0 if bl_e_any==.
	drop temp*

* e_publicworks
	egen temp = mean(e_publicworks) if surv_bl==1 & bl_valid_gridday==1, by(UID)
	egen bl_e_publicworks = max(temp), by(UID)
	gen bl_e_publicworks_miss = (bl_e_publicworks==.)
		replace bl_e_publicworks = 0 if bl_e_publicworks==.
	drop temp*

* e_self 
	egen temp = mean(e_self) if surv_bl==1 & bl_valid_gridday==1, by(UID)
	egen bl_e_self = max(temp), by(UID)
	gen bl_e_self_miss = (bl_e_self==.)
	* impute 0 if missing
	replace bl_e_self = 0 if bl_e_self==.
	drop temp*
	
* daily wage
	egen temp = mean(dailywagetot) if surv_bl==1 & e_manwage==1 & bl_valid_gridday==1, by(UID)
	egen bl_dwagetot = max(temp), by(UID)
	gen bl_dwagetot_miss = (bl_dwagetot==.)
		replace bl_dwagetot = 0 if bl_dwagetot==.
	gen bl_ldwagetot = log(bl_dwagetot)
	gen bl_ldwagetot_miss = (bl_ldwagetot==.)
		replace bl_ldwagetot = 0 if bl_ldwagetot==.
	drop temp* 

* weekly earnings 
	egen temp1 = sum(dailywagetot) if surv_bl==1 & e_manwage == 1, by(UID)
	egen bl_weeklyearnings = max(temp1), by(UID)
	replace bl_weeklyearnings = (bl_weeklyearnings/tot_grid_days) * 7
	drop temp1

* land 
	gen temp = (noland==1) if surv_bl==1
		replace temp=. if (own_land_acres==. & own_land_guntas==.) & surv_bl==1
	bys UID: egen bl_noland = max(temp)
	gen bl_noland_miss = (bl_noland==.)

	gen temp2=totalland if surv_bl==1
	egen bl_totalland=max(temp2), by(UID)

	gen temp3=totalland_miss if surv_bl==1
	egen bl_totalland_miss=max(temp3), by(UID)
		replace bl_totalland_miss=1 if bl_totalland_miss==.
	gen bl_totalland_nm = bl_totalland
		replace bl_totalland_nm=0 if bl_totalland==.

	* impute with endline values if missing at baseline 
	gen temp4 = totalland if (surv_el==1 | surv_post==1)
	egen temp5 = max(temp4), by(UID)
	gen bl_totalland_imp = bl_totalland 
		replace bl_totalland_imp = temp5 if bl_totalland_miss==1
	gen bl_totalland_imp_nm = bl_totalland_imp
		replace bl_totalland_imp_nm=0 if bl_totalland_imp==.
	drop temp* 

	egen tot_hh_mem_m = max(hh_mem_m), by(UID)
	gen land_per_hh_mem_m = bl_totalland_imp/tot_hh_mem_m
	gen landpermem_m0 = (land_per_hh_mem_m==0)
	
* labor and farm size
	gen lab_peracre = farm_labor_tot/bl_totalland_imp
	gen lab_peracre_w = lab_peracre
		sum lab_peracre if grid_id==1 & surv_bl==1 & sample_signup==1, d 
		replace lab_peracre_w = r(p99) if lab_peracre_w>r(p99) & lab_peracre_w!=.

* hh members
	gen temp=tot_hh_mem if surv_bl==1
	egen bl_tot_hh_mem=max(temp), by(UID)
	drop temp
	
	gen bl_tot_hh_mem_miss = (bl_tot_hh_mem==.)
	gen bl_tot_hh_mem_nm = bl_tot_hh_mem
		replace bl_tot_hh_mem_nm=0 if bl_tot_hh_mem==.

* household business
	gen temp = (bl_totalland > 0) if bl_totalland!=. 
	egen bl_owntotalland = max(temp), by(UID)		

	gen bl_bizagri = 0
		replace bl_bizagri = 1 if (bl_owntotalland==1 | occup_anyfarm==1)
	gen bl_bizagri_miss = (bl_owntotalland==. & occup_anyfarm==.)
	drop temp* 

	gen temp = (self_emp_act>=0 & self_emp_act!=.) if surv_bl==1
	egen bl_biznonagri = max(temp), by(UID)
	gen bl_biznonagri_miss = (bl_biznonagri==.)
		replace bl_biznonagri = 0 if bl_biznonagri==.
	drop temp* 

	gen bl_has_hhbiz = max(bl_bizagri, bl_biznonagri)
	gen bl_has_hhbiz_miss = min(bl_bizagri_miss, bl_biznonagri_miss)
	
** Baseline covariates at village-level 

* wages 
	egen temp1 = mean(dailywagetot) if surv_bl==1 & e_manwage==1 & bl_valid_gridday==1, by(vill_id)
	egen bl_dwagetot_v = max(temp1), by(vill_id)
	gen bl_dwagetot_v_miss = (bl_dwagetot_v==.)
		replace bl_dwagetot_v = 1 if bl_dwagetot_v==.
	drop temp*

* employment 
	egen temp1 = mean(e_manwage) if surv_bl==1 & bl_valid_gridday==1, by(vill_id)
	egen bl_e_manwage_v = max(temp1), by(vill_id)
	gen bl_e_manwage_v_miss = (bl_e_manwage_v==.)
		replace bl_e_manwage_v = 0 if bl_e_manwage_v==.
	drop temp*
	
** Interaction terms for analysis 
	gen treat_peak = treat*peak
	gen treat_peakc = treat*peakc

	/* gen treat_nonsignup = treat*sample_nonsignup
	gen treat_nonsignup_peak = treat_peak*sample_nonsignup
	gen peak_nonsignup = peak * sample_nonsignup

	gen peak_landpermem_m0 = peak*landpermem_m0
	gen treat_peak_landpermem_m0 = treat_peak*landpermem_m0
	gen treat_landpermem_m0 = treat*landpermem_m0 */

	sum land_per_hh_mem_m if surv_el==1 & sample_spillover==1 & avg_eselfagri_ctrl>0 & land_per_hh_mem_m>0, d
	gen landpermem_above = (land_per_hh_mem_m>r(p50))
	/* gen treat_landpermem_above = treat*landpermem_above
	gen peak_landpermem_above = peak*landpermem_above
	gen treat_peak_landpermem_above = treat_peak*landpermem_above */

	foreach var in sample_nonsignup landpermem_m0 landpermem_above {
		foreach inter in peak treat treat_peak {
			gen `inter'_`var' = `inter'*`var' 
		}
	}


** Drop incomplete surveys 
	drop if survey_not_complete!=0
	
* Standardize variables  
	sum rating_mean if surv_el==1 & sample_spillover==1 & grid_id ==1 & peak ==0, d 
	gen rating_std = (rating_mean - r(mean))/r(sd)
	gen rating_std_miss = rating_std ==. 

	foreach var in bl_dwagetot bl_e_manwage {
		sum `var' if surv_el==1 & sample_spillover==1 & grid_id ==1 & peak ==0, d
		gen `var'_std = (`var' - r(mean))/r(sd)
		gen `var'_std_miss = `var'_std ==. 
	}

		
	/* sum bl_dwagetot if surv_el==1 & sample_spillover==1 & grid_id ==1 & peak ==0, d
	gen bl_dwagetot_std = (bl_dwagetot - r(mean))/r(sd)
	gen bl_dwagetot_std_miss = bl_dwagetot_std ==. 
	
	sum bl_e_manwage if surv_el==1 & sample_spillover==1 & grid_id ==1 & peak ==0, d
	gen bl_e_manwage_std = (bl_e_manwage - r(mean))/r(sd)
	gen bl_e_manwage_std_miss = bl_e_manwage_std ==.  */
	
	* generate interaction terms 
	foreach var in rating_std bl_dwagetot_std bl_e_manwage_std ///
		rating_std_miss bl_dwagetot_std_miss bl_e_manwage_std_miss {
		foreach inter in peak treat treat_peak {
			gen `inter'_`var' = `inter'*`var' 
		}
	}

/* 	gen peak_rating_std = peak*rating_std 
	gen treat_rating_std = treat*rating_std
	gen treat_peak_rating_std = treat_peak*rating_std	
	gen peak_rating_std_miss = peak*rating_std_miss
	gen treat_rating_std_miss = treat*rating_std_miss
	gen treat_peak_rating_std_miss = treat_peak*rating_std_miss
	
	gen treat_bl_dwagetot_std = bl_dwagetot_std*treat
	gen treat_peak_bl_dwagetot_std = bl_dwagetot_std*treat_peak 
	gen peak_bl_dwagetot_std = bl_dwagetot_std*peak
	gen treat_bl_dwagetot_std_miss = bl_dwagetot_std_miss*treat
	gen peak_bl_dwagetot_std_miss = bl_dwagetot_std_miss*peak
	gen treatpeak_bl_dwagetotstd_miss = bl_dwagetot_std_miss*treat_peak
	
	gen treat_bl_e_manwage_std = bl_e_manwage_std*treat
	gen treat_peak_bl_e_manwage_std = bl_e_manwage_std*treat_peak 
	gen peak_bl_e_manwage_std = bl_e_manwage_std*peak
	gen treat_bl_e_manwage_std_miss = bl_e_manwage_std_miss*treat
	gen peak_bl_e_manwage_std_miss = bl_e_manwage_std_miss*peak
	gen treatpeak_bl_emanwagestd_miss = bl_e_manwage_std_miss*treat_peak */
	
	
** Drop variables that are not required in analysis 
	drop parti_lm wage_type wage_cash wage_inkind accept_dailywageoffer days_would_like_work land_share_acres land_share_guntas own_land_acres own_land_guntas work_status activity_code h_agri_hire7 tot_hr_wrk_hh tot_hr_wrk_mm hiring_past30 hiring_activity_code hiring_days hiring_wage_m hiring_wage_f acretoguntaconv lcount noland ownland h_agri h_agri_any h_agri_hire cashamt inkamt sharecropland totalland totalland_miss e_selfagri_hh_tot e_self_hh_tot tot_signedup tot_recruited e_manlab dailywagecash dailywageink hourlywagetot dailywagecash_w avg_emanwage_ctrl bl_owntotalland survey_not_complete bl_totalland bl_totalland_miss bl_totalland_nm hhcount e_selfagri_tot e_any e_wage occup_anyfarm lab_peracre
	
** Label all variables 
	do "./code/label_vars_rationing_worker.do"

** Save data set
	save "./data/cleandata/rationing_worker.dta", replace 

