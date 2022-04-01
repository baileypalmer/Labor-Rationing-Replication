
/* This do file contains code that generates the appendix tables in "Labor Rationing" (Breza, Kaur & Shamdasani) */

* Table B1. Baseline Characteristics: Sign-Ups and Non Sign-Ups 
	use "./data/cleandata/rationing_worker.dta", clear 
	foreach x of varlist bl_daysworkfut30 bl_dwagetot bl_ldwagetot bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland{
		replace `x'=. if `x'_miss==1
	}
		
	* Col 1: mean and sd for signup sample in control villages - lean season 
	eststo clear 		
	estpost sum bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1) & treat==0 & grid_id==1 & peak == 0 
	matrix mean_signup_lean=e(mean)
	matrix sd_signup_lean=e(sd)
		
	matrix pval1 = (.,.,.,.,.,.,.,.,.,.,.)
	matrix pval2 = (.,.,.,.,.,.,.,.,.,.,.)
	matrix diff_coeff1 = (.,.,.,.,.,.,.,.,.,.,.)
	matrix diff_coeff2 = (.,.,.,.,.,.,.,.,.,.,.)
	matrix diff_se1 = (.,.,.,.,.,.,.,.,.,.,.)
	matrix diff_se2 = (.,.,.,.,.,.,.,.,.,.,.)

	* Cols 2 and 3: regression coeffs and pvals for non signup sample - lean season
	areg bl_partic nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,1] = r(table)[4,1]
	matrix diff_coeff1[1,1] = _b[nonenlisted]
	matrix diff_se1[1,1] = _se[nonenlisted]
	
	areg bl_daysworkfut30 nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,2] = r(table)[4,1]
	matrix diff_coeff1[1,2] = _b[nonenlisted]
	matrix diff_se1[1,2] = _se[nonenlisted]
	
	areg bl_dwagetot nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,3] = r(table)[4,1]
	matrix diff_coeff1[1,3] = _b[nonenlisted]
	matrix diff_se1[1,3] = _se[nonenlisted]
	
	areg bl_weeklyearnings nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,4] = r(table)[4,1]
	matrix diff_coeff1[1,4] = _b[nonenlisted]
	matrix diff_se1[1,4] = _se[nonenlisted]
	
	areg bl_e_any nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,5] = r(table)[4,1]
	matrix diff_coeff1[1,5] = _b[nonenlisted]
	matrix diff_se1[1,5] = _se[nonenlisted]	

	areg bl_e_manwage nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,6] = r(table)[4,1]
	matrix diff_coeff1[1,6] = _b[nonenlisted]
	matrix diff_se1[1,6] = _se[nonenlisted]
	
	areg bl_e_publicworks nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,7] = r(table)[4,1]
	matrix diff_coeff1[1,7] = _b[nonenlisted]
	matrix diff_se1[1,7] = _se[nonenlisted]
		
	areg bl_has_hhbiz nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,8] = r(table)[4,1]
	matrix diff_coeff1[1,8] = _b[nonenlisted]
	matrix diff_se1[1,8] = _se[nonenlisted]
	
	areg bl_e_self nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,9] = r(table)[4,1]
	matrix diff_coeff1[1,9] = _b[nonenlisted]
	matrix diff_se1[1,9] = _se[nonenlisted]	
	
	areg bl_noland nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,10] = r(table)[4,1]
	matrix diff_coeff1[1,10] = _b[nonenlisted]
	matrix diff_se1[1,10] = _se[nonenlisted]
	
	areg bl_tot_hh_mem nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,11] = r(table)[4,1]
	matrix diff_coeff1[1,11] = _b[nonenlisted]
	matrix diff_se1[1,11] = _se[nonenlisted]

	* Col 4: mean and sd for signup sample in control villages - semipeak season 
	estpost sum bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem  if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1) & treat==0 & grid_id==1 & peak == 1 
	matrix mean_signup_peak=e(mean)
	matrix sd_signup_peak=e(sd)

	* Cols 5 and 6: regression coeffs and pvals for non signup sample - semipeak season
	areg bl_partic nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,1] = r(table)[4,1]
	matrix diff_coeff2[1,1] = _b[nonenlisted]
	matrix diff_se2[1,1] = _se[nonenlisted]	
	
	areg bl_daysworkfut30 nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,2] = r(table)[4,1]
	matrix diff_coeff2[1,2] = _b[nonenlisted]
	matrix diff_se2[1,2] = _se[nonenlisted]	
	
	areg bl_dwagetot nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,3] = r(table)[4,1]
	matrix diff_coeff2[1,3] = _b[nonenlisted]
	matrix diff_se2[1,3] = _se[nonenlisted]
	
	areg bl_weeklyearnings nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,4] = r(table)[4,1]
	matrix diff_coeff2[1,4] = _b[nonenlisted]
	matrix diff_se2[1,4] = _se[nonenlisted]

	areg bl_e_any nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,5] = r(table)[4,1]
	matrix diff_coeff2[1,5] = _b[nonenlisted]
	matrix diff_se2[1,5] = _se[nonenlisted]
	
	areg bl_e_manwage nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,6] = r(table)[4,1]
	matrix diff_coeff2[1,6] = _b[nonenlisted]
	matrix diff_se2[1,6] = _se[nonenlisted]
	
	areg bl_e_publicworks nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,7] = r(table)[4,1]
	matrix diff_coeff2[1,7] = _b[nonenlisted]
	matrix diff_se2[1,7] = _se[nonenlisted]

	areg bl_has_hhbiz nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,8] = r(table)[4,1]
	matrix diff_coeff2[1,8] = _b[nonenlisted]
	matrix diff_se2[1,8] = _se[nonenlisted] 
	
	areg bl_e_self nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,9] = r(table)[4,1]
	matrix diff_coeff2[1,9] = _b[nonenlisted]
	matrix diff_se2[1,9] = _se[nonenlisted]
	
	areg bl_noland nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1 , absorb(round_id) cluster(vill_id) 
	matrix pval2[1,10] = r(table)[4,1]
	matrix diff_coeff2[1,10] = _b[nonenlisted]
	matrix diff_se2[1,10] = _se[nonenlisted]
	
	areg bl_tot_hh_mem nonenlisted if surv_el==1 & (sample_hiringshock==1 | sample_spillover==1| sample_nonsignup==1) & treat==0 & grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,11] = r(table)[4,1]
	matrix diff_coeff2[1,11] = _b[nonenlisted]
	matrix diff_se2[1,11] = _se[nonenlisted]
		
	matrix colnames pval1 = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem   
	matrix colnames pval2 = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem 
	matrix colnames diff_coeff1 = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem 
	matrix colnames diff_coeff2 = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem 
	matrix colnames diff_se1 = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem 
	matrix colnames diff_se2 = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem 
	
	matrix blank = (.,.,.,.,.,.,.,.,.,.,.)
	matrix colnames blank = bl_partic bl_daysworkfut30 bl_dwagetot bl_weeklyearnings bl_e_any bl_e_manwage bl_e_publicworks bl_has_hhbiz bl_e_self bl_noland bl_tot_hh_mem 
	
	estadd matrix mean_signup_lean
	estadd matrix sd_signup_lean
	estadd matrix pval1
	estadd matrix mean_signup_peak
	estadd matrix sd_signup_peak
	estadd matrix pval2
	estadd matrix blank
	estadd matrix diff_coeff1
	estadd matrix diff_coeff2
	estadd matrix diff_se1
	estadd matrix diff_se2 
	
	esttab, noobs cells("mean_signup_lean(fmt(a3)) diff_coeff1(fmt(a3)) pval1(fmt(a3)) mean_signup_peak(fmt(a3)) diff_coeff2(fmt(a3)) pval2(fmt(a3))" "sd_signup_lean(par fmt(3)) diff_se1(par fmt(3)) blank1 sd_signup_peak(par fmt(3)) diff_se2(par fmt(3)) blank1") l nonum collabels("Sign-Ups" "Difference" "Pval" "Sign-Ups" "Difference" "Pval") replace nocons nomti
  
* Table B2. Survey Completion in Spillover Sample	
	use "./data/rawdata/rationing_attrition.dta", clear
	
	eststo clear 
	eststo: areg surv_complete treat if surv_bl==1 & sample_spillover==1, absorb(round_id) cl(vill_id)
	sum surv_complete if e(sample)
	estadd scalar y_mean=r(mean)
	estadd local sample1 "Spillover", replace 

 	eststo: areg surv_complete treat bl_surv_complete if surv_el==1 & sample_spillover==1, absorb(round_id) cl(vill_id)
	sum surv_complete if e(sample)
	estadd scalar y_mean=r(mean)
	estadd local sample1 "Spillover", replace 

	esttab, se(3) l nostar replace stats(sample1 y_mean N, labels("Sample" "Dep Var Mean" "N (workers)")) keep(treat) nonotes mtitles("Baseline Survey Completion" "Endline Survey Completion")
	
* Table B3. Sample Sizes and Survey Completion Rates 	
	use "./data/cleandata/rationing_worker.dta", clear 

	eststo clear 
	matrix coeff_lean = (.,.,.,.,.)
	matrix mean_lean = (.,.,.,.,.)
	matrix sd_lean = (.,.,.,.,.)
	matrix coeff_peak = (.,.,.,.,.)
	matrix mean_peak = (.,.,.,.,.)
	matrix sd_peak = (.,.,.,.,.)
	matrix coeff_treat = (.,.,.,.,.)
	matrix se_lean = (.,.,.,.,.)
	matrix se_peak = (.,.,.,.,.)
	matrix se_treat = (.,.,.,.,.)

	matrix colnames coeff_lean = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames mean_lean = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames coeff_peak = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames mean_peak = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames coeff_treat = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames se_lean = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames se_peak = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames se_treat = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames sd_lean = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey
	matrix colnames sd_peak = tot_sampleframe surv_complete el_nel_tot el_nel_comp_rate frac_nonsignups_survey

	* Row 1: number of signups 

	* col 1 -  mean and sd for control vills - lean	
	areg tot_sampleframe treat treat_peak if vill1 == 1, absorb(round_id) robust
	sum tot_sampleframe if treat==0 & peak==0 & e(sample)==1
	matrix mean_lean[1,1] = r(mean)
	matrix sd_lean[1,1] = r(sd)
	
	* col 2 - diffs by treatment status - lean
	matrix coeff_lean[1,1] = _b[treat] 
	matrix se_lean[1,1] = _se[treat]

	* col 3 -  mean and sd for control vills - peak	
	sum tot_sampleframe if treat==0 & peak==1 & e(sample)==1
	matrix mean_peak[1,1] = r(mean)
	matrix sd_peak[1,1] = r(sd)
	
	* col 4 - diffs by treatment status - peak	
	lincom treat + treat_peak
	matrix coeff_peak[1,1] = r(estimate)
	matrix se_peak[1,1] = r(se)
	
	* col 5 - diffs between lean and peak for treatment vills
	matrix coeff_treat[1,1] = _b[treat_peak] 
	matrix se_treat[1,1] = _se[treat_peak]
		
	* Row 3: number of non signups 
	areg el_nel_tot treat treat_peak if vill1 == 1 & round_id > 10, absorb(round_id) robust
	
	* col 1 -  mean and sd for control vills - lean	
	sum el_nel_tot if treat==0 & peak==0 & e(sample)==1
	matrix mean_lean[1,3] = r(mean)
	matrix sd_lean[1,3] = r(sd)

	* col 2 - diffs by treatment - lean
	matrix coeff_lean[1,3] = _b[treat] 
	matrix se_lean[1,3] = _se[treat]
	
	* col 3 -  mean and sd for control vills - peak	
	sum el_nel_tot if treat==0 & peak==1 & e(sample)==1
	matrix mean_peak[1,3] = r(mean)
	matrix sd_peak[1,3] = r(sd)

	* col 4 - diffs by treatment status - peak	
	lincom treat + treat_peak
	matrix coeff_peak[1,3] = r(estimate)
	matrix se_peak[1,3] = r(se)
	
	* col 5 - diffs between lean and peak for treatment vills
	matrix coeff_treat[1,3] = _b[treat_peak] 
	matrix se_treat[1,3] = _se[treat_peak]	

	* Row 4: EL survey completion - non signups
	areg el_nel_comp_rate treat treat_peak if vill1 == 1 & round_id > 10, absorb(round_id) robust 
	
	* col 1 -  mean and sd for control vills - lean	
	sum el_nel_comp_rate if treat==0 & peak==0 & e(sample)==1
	matrix mean_lean[1,4] = r(mean)
	matrix sd_lean[1,4] = r(sd)
	
	* col 2 - diffs by treatment - lean
	matrix coeff_lean[1,4] = _b[treat] 
	matrix se_lean[1,4] = _se[treat]
	
	* col 3 -  mean and sd for control vills - peak	
	sum el_nel_comp_rate if treat==0 & peak==1 & e(sample)==1
	matrix mean_peak[1,4] = r(mean)
	matrix sd_peak[1,4] = r(sd)

	* col 4 - diffs by treatment status - peak	
	lincom treat + treat_peak
	matrix coeff_peak[1,4] = r(estimate)
	matrix se_peak[1,4] = r(se)
	
	* col 5 - diffs between lean and peak for treatment vills
	matrix coeff_treat[1,4] = _b[treat_peak] 
	matrix se_treat[1,4] = _se[treat_peak]
	
	* Row 5: share of non-signups surveyed
	areg frac_nonsignups_survey treat treat_peak if vill1 == 1 & round_id > 10, absorb(round_id) robust 
	
	* col 1 -  mean and sd for control vills - lean	
	sum frac_nonsignups_survey if treat==0 & peak==0 & e(sample)==1
	matrix mean_lean[1,5] = r(mean)
	matrix sd_lean[1,5] = r(sd)
	
	* col 2 - diffs by treatment - lean
	matrix coeff_lean[1,5] = _b[treat] 
	matrix se_lean[1,5] = _se[treat]
	
	* col 3 -  mean and sd for control vills - peak	
	sum frac_nonsignups_survey if treat==0 & peak==1 & e(sample)==1
	matrix mean_peak[1,5] = r(mean)
	matrix sd_peak[1,5] = r(sd)

	* col 4 - diffs by treatment status - peak	
	lincom treat + treat_peak
	matrix coeff_peak[1,5] = r(estimate)
	matrix se_peak[1,5] = r(se)
	
	* col 5 - diffs between lean and peak for treatment vills
	matrix coeff_treat[1,5] = _b[treat_peak] 
	matrix se_treat[1,5] = _se[treat_peak]
		
	*Row 2: EL survey completion - spillover
	use "./data/rawdata/rationing_attrition.dta", clear
 
	areg surv_complete treat treat_peak bl_surv_complete if surv_el==1 & sample_spillover==1 , absorb(round_id) cl(vill_id)
	
	* col 1 -  mean and sd for control vills - lean	
	sum surv_complete if treat==0 & peak==0 & e(sample)==1
	matrix mean_lean[1,2] = r(mean)
	matrix sd_lean[1,2] = r(sd)
	
	* col 2 - diffs by treatment - lean
	matrix coeff_lean[1,2] = _b[treat] 
	matrix se_lean[1,2] = _se[treat]
	
	* col 3 -  mean and sd for control vills - peak	
	sum surv_complete if treat==0 & peak==1 & e(sample)==1
	matrix mean_peak[1,2] = r(mean)
	matrix sd_peak[1,2] = r(sd)

	* col 4 - diffs by treatment status - peak	
	lincom treat + treat_peak
	matrix coeff_peak[1,2] = r(estimate)
	matrix se_peak[1,2] = r(se)
	
	* col 5 - diffs between lean and peak for treatment vills
	matrix coeff_treat[1,2] = _b[treat_peak] 
	matrix se_treat[1,2] = _se[treat_peak]
	
	estadd matrix coeff_lean
	estadd matrix mean_lean
	estadd matrix coeff_peak
	estadd matrix mean_peak
	estadd matrix coeff_treat
	estadd matrix se_lean
	estadd matrix se_peak
	estadd matrix se_treat
	estadd matrix sd_lean
	estadd matrix sd_peak
		
	esttab, noobs cells("mean_lean(fmt(a3)) coeff_lean(fmt(a3)) mean_peak(fmt(a3)) coeff_peak(fmt(a3)) coeff_treat(fmt(a3))" "sd_lean(par fmt(a3)) se_lean(par fmt(a3)) sd_peak(par fmt(a3)) se_peak(par fmt(a3)) se_treat(par fmt(a3))") nostar l nonum replace nocons nomti collabels("No hiring shock" "Difference" "No hiring shock" "Difference" "Lean vs Semi-Peak") 

* Table B4. Employer Characteristics
	use "./data/cleandata/rationing_employer_nodrop.dta", clear 

	eststo clear
	matrix pval1 = (.,.,.,.,.,.,.,.)
	matrix diff_coeff1 = (.,.,.,.,.,.,.,.)
	matrix diff_se1 = (.,.,.,.,.,.,.,.)
	matrix blank1 = (.,.,.,.,.,.,.,.)
	matrix pval2 = (.,.,.,.,.,.,.,.)
	matrix diff_coeff2 = (.,.,.,.,.,.,.,.)
	matrix diff_se2 = (.,.,.,.,.,.,.,.)
	matrix colnames pval1 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 	
	matrix colnames diff_coeff1 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 
	matrix colnames diff_se1 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 
	matrix colnames blank1 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 
	matrix colnames pval2 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 	
	matrix colnames diff_coeff2 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 
	matrix colnames diff_se2 = totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab 
  
   	* Col 1: mean and sd for control vills - lean 
	estpost sum totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab if grid_id==1 & peak == 0 & treat==0
	matrix mean_lean =e(mean)
	matrix sd_lean=e(sd)
	
	* Cols 2 & 3: differences by treatment status - lean  
	areg totland_w treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,1] = r(table)[4,1]
	matrix diff_coeff1[1,1] = _b[treat]
	matrix diff_se1[1,1] = _se[treat]

	areg tot_hh_mem treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,2] = r(table)[4,1]
	matrix diff_coeff1[1,2] = _b[treat]
	matrix diff_se1[1,2] = _se[treat]

	areg has_rating_mean treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,3] = r(table)[4,1]
	matrix diff_coeff1[1,3] = _b[treat]
	matrix diff_se1[1,3] = _se[treat]

	areg ever_hired_mean treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,4] = r(table)[4,1]
	matrix diff_coeff1[1,4] = _b[treat]
	matrix diff_se1[1,4] = _se[treat]

	areg partic treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,5] = r(table)[4,1]
	matrix diff_coeff1[1,5] = _b[treat]
	matrix diff_se1[1,5] = _se[treat]

	areg occupselfempagri treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,6] = r(table)[4,1]
	matrix diff_coeff1[1,6] = _b[treat]
	matrix diff_se1[1,6] = _se[treat]

	areg occupselfempnonagri treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,7] = r(table)[4,1]
	matrix diff_coeff1[1,7] = _b[treat]
	matrix diff_se1[1,7] = _se[treat]

	areg occuplab treat if grid_id==1 & peak == 0, absorb(round_id) cluster(vill_id) 
	matrix pval1[1,8] = r(table)[4,1]
	matrix diff_coeff1[1,8] = _b[treat]
	matrix diff_se1[1,8] = _se[treat]

	* Col 4: mean and sd for control vills - semipeak 
	estpost sum totland_w tot_hh_mem has_rating_mean ever_hired_mean partic occupselfempagri occupselfempnonagri occuplab if grid_id==1 & peak == 1 & treat==0
	matrix mean_peak =e(mean)
	matrix sd_peak=e(sd)

	* Cols 5 & 6: differences by treatment status - semipeak  
	areg totland_w treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,1] = r(table)[4,1]
	matrix diff_coeff2[1,1] = _b[treat]
	matrix diff_se2[1,1] = _se[treat]

	areg tot_hh_mem treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,2] = r(table)[4,1]
	matrix diff_coeff2[1,2] = _b[treat]
	matrix diff_se2[1,2] = _se[treat]

	areg has_rating_mean treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,3] = r(table)[4,1]
	matrix diff_coeff2[1,3] = _b[treat]
	matrix diff_se2[1,3] = _se[treat]

	areg ever_hired_mean treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,4] = r(table)[4,1]
	matrix diff_coeff2[1,4] = _b[treat]
	matrix diff_se2[1,4] = _se[treat]

	areg partic treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,5] = r(table)[4,1]
	matrix diff_coeff2[1,5] = _b[treat]
	matrix diff_se2[1,5] = _se[treat]

	areg occupselfempagri treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,6] = r(table)[4,1]
	matrix diff_coeff2[1,6] = _b[treat]
	matrix diff_se2[1,6] = _se[treat]

	areg occupselfempnonagri treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,7] = r(table)[4,1]
	matrix diff_coeff2[1,7] = _b[treat]
	matrix diff_se2[1,7] = _se[treat]

	areg occuplab treat if grid_id==1 & peak == 1, absorb(round_id) cluster(vill_id) 
	matrix pval2[1,8] = r(table)[4,1]
	matrix diff_coeff2[1,8] = _b[treat]
	matrix diff_se2[1,8] = _se[treat]

	estadd matrix mean_lean
	estadd matrix sd_lean 
	estadd matrix mean_peak
	estadd matrix sd_peak 
	estadd matrix pval1
	estadd matrix pval2
	estadd matrix diff_coeff1
	estadd matrix diff_coeff2
	estadd matrix diff_se1
	estadd matrix diff_se2 
	estadd matrix blank1 

	esttab, noobs cells("mean_lean(fmt(a3)) diff_coeff1(fmt(a3)) pval1(fmt(a3)) mean_peak(fmt(a3)) diff_coeff2(fmt(a3)) pval2(fmt(a3))" "sd_lean(par fmt(3)) diff_se1(par fmt(3)) blank1 sd_peak(par fmt(3)) diff_se2(par fmt(3))") l nonum collabels("No hiring shock" "Difference" "Pval" "No hiring shock" "Difference" "Pval") replace nocons nomti

* Table B5. Wage Effects using Non-Winsorized Wages  
	use "./data/cleandata/rationing_worker.dta", clear 
	
	eststo clear 
	eststo: areg ldailywagecash treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagecash if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagecash if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "No", replace 

	eststo: areg ldailywagetot treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "No", replace 
	
	eststo: areg ldailywagetot treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 
	
	eststo: areg dailywagetot treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum dailywagetot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum dailywagetot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 

	eststo: areg ldailywagetot treat treat_peakc bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	estadd scalar pval = .
	estadd scalar lincom_se = .
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 
	
	eststo: areg dailywagetot treat treat_peakc bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum dailywagetot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum dailywagetot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	estadd scalar pval = .
	estadd scalar lincom_se = .
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 

	esttab, se(3) replace nostar keep(treat*) label nonotes stats(sample1 bl_mean pval lincom_se y_mean_lean y_mean_peak  N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N (worker-days)")) nonum 

* Table B6. Treatment Effects Restricting to 7-day Recall Window 
	use "./data/cleandata/rationing_worker.dta", clear 

	eststo clear 
	eststo: areg e_manwage treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & grid_id<=7, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)	
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace

	eststo: areg ldailywagetot_w treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1 & grid_id<=7, a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 
	
	eststo: areg e_self treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eself_ctrl>0 & grid_id<=7, a(round_id) cluster(vill_id)
	sum e_self if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_self if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	
	eststo: areg e_manwage treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_post ==1 & sample_spillover==1 & grid_id<=7 [pw=weights_post], a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 

	eststo: areg ldailywagetot_w treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_post ==1 & sample_spillover==1 & e_manwage==1 & grid_id<=7 [pw=weights_post], a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace
	estadd local sample1 "Spillover", replace 

	eststo: areg e_self treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_post ==1 & sample_spillover==1 & grid_id<=7 [pw=weights_post], a(round_id) cluster(vill_id)
	sum e_self if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum e_self if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace
	estadd local sample1 "Spillover", replace 
	
	esttab, stats(sample1 bl_mean pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N (worker-days)")) se(3) replace nostar keep(treat*) l nonotes

* Table B7. Self-Employment Hours 
	use "./data/cleandata/rationing_worker.dta", clear 
	
	eststo clear
	eststo: areg e_self_hours treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eself_ctrl>0 & grid_id <=5, a(round_id) cluster(vill_id)
	sum e_self_hours if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_self_hours if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "5", replace 
	
	eststo: areg e_self_hours treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eself_ctrl>0 & grid_id <=7, a(round_id) cluster(vill_id)
	sum e_self_hours if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_self_hours if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "7", replace 
	
	eststo: areg e_selfnonagri_hours treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eselfnonagri_ctrl>0 & grid_id <=7, a(round_id) cluster(vill_id)
	sum e_selfnonagri_hours if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_selfnonagri_hours if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "7", replace 
	
	eststo: areg e_selfagri_hours treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eselfagri_ctrl>0 & grid_id <=7, a(round_id) cluster(vill_id)
	sum e_selfagri_hours if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_selfagri_hours if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "7", replace 

	eststo: areg e_selfagri_hours treat treat_peak treat_peak_landpermem_above treat_landpermem_above peak_landpermem_above landpermem_above treat_landpermem_m0 treat_peak_landpermem_m0 peak_landpermem_m0 landpermem_m0 bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eselfagri_ctrl>0 & grid_id <=7, a(round_id) cluster(vill_id)
	sum e_selfagri_hours if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_selfagri_hours if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	test treat + treat_landpermem_above = 0
		estadd scalar pval2 = r(p)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "7", replace 

	eststo: areg e_self_hours treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_post ==1 & sample_spillover==1 & grid_id <=5 & avg_eself_ctrl>0 [pw=weights_post], a(round_id) cluster(vill_id)
	sum e_self_hours if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum e_self_hours if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "5", replace 

	eststo: areg e_self_hours treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_post ==1 & sample_spillover==1  & grid_id <=7 & avg_eself_ctrl>0 [pw=weights_post], a(round_id) cluster(vill_id)
	sum e_self_hours if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum e_self_hours if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-days", replace 
	estadd local recallwindow "7", replace 
	
	esttab, stats(sample1 bl_mean recallwindow pval lincom_se y_mean_lean y_mean_peak N obslevel, labels("Sample" "Baseline controls" "Recall window (days)" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N" "Level of observations")) se(3) replace keep(treat treat_peak treat_peak_landpermem_above treat_landpermem_above) order(treat treat_landpermem_above treat_peak treat_peak_landpermem_above) l nonote nostar 

* Table B8. Self-Employment - Household Level
	use "./data/cleandata/rationing_worker.dta", clear 
 
 	eststo clear 
 	eststo: areg self_tot treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if sample_spillover==1 & surv_el==1 & avg_eself_ctrl>0 & grid_id==1, a(round_id) cluster(vill_id)
	sum self_tot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum self_tot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local obslevel "households", replace 
	estadd local bl_controls "Yes", replace

	eststo: areg self_tot treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss bl_tot_hh_mem_nm bl_tot_hh_mem_miss if sample_spillover==1 & surv_el==1 & avg_eself_ctrl>0 & grid_id==1, a(round_id) cluster(vill_id)
	sum self_tot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum self_tot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local obslevel "households", replace 
	estadd local bl_controls "Yes", replace
		
	eststo: areg self_tot treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss bl_tot_hh_mem_nm bl_tot_hh_mem_miss land_per_hh_mem_m bl_totalland_imp_nm if sample_spillover==1 & surv_el==1 & avg_eself_ctrl>0 & grid_id==1, a(round_id) cluster(vill_id)
	sum self_tot if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum self_tot if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local obslevel "households", replace 
	estadd local bl_controls "Yes", replace
	
	esttab, stats(sample1 sample2 bl_controls pval lincom_se y_mean_lean y_mean_peak N obslevel, labels("Sample" " " "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N" "Level of observations")) se(3) nostar replace keep(treat treat_peak) order(treat treat_peak) l nonotes nocons frag nonum nomti
		
* Table B9. Impact on Employers  

* Panel A 
	use "./data/cleandata/rationing_employer_nodrop.dta", clear 
	eststo clear	
	eststo: areg act_done_times treat treat_peak, a(round_id) cluster(vill)
	test treat + treat_peak==0
		estadd scalar pval= r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum act_done_times if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum act_done_times if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "emp-activity", replace 
	
	eststo: areg act_done_early treat treat_peak, a(round_id) cluster(vill)
	test treat + treat_peak==0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum act_done_early if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum act_done_early if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "emp-activity", replace 
	
	eststo: areg hire_outside_vill_m0 treat treat_peak if grid_id==1, a(round_id) cluster(vill)
	test treat + treat_peak==0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum hire_outside_vill_m0 if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hire_outside_vill_m0 if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "employer", replace 

	eststo: areg trouble_hiring treat treat_peak if grid_id==1, a(round_id) cluster(vill)
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum trouble_hiring if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum trouble_hiring if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "employer", replace 
	
	use "./data/cleandata/rationing_worker.dta", clear 
	eststo: areg rating_mean treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "No", replace 
	sum rating_mean if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum rating_mean if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "worker-day", replace 
			
	esttab, se(3) replace nostar keep(treat treat_peak) label nonotes stats(pval lincom_se y_mean_lean y_mean_peak  N obslevel, labels("Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak"  "N" "Level of observations")) frag nonote nonum nomti 

* Panel B 
	use "./data/cleandata/rationing_employer_nodrop.dta", clear 
	eststo clear 
	eststo: xi: areg act_done_times treat treat_peak i.peak*totland_w i.occupselfempagri*peak i.scst*peak i.peak*tot_hh_mem, a(round_id) cluster(vill)
	test treat + treat_peak==0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum act_done_times if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum act_done_times if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "emp-activity", replace 

	eststo: xi: areg act_done_early treat treat_peak i.peak*totland_w i.occupselfempagri*peak i.scst*peak i.peak*tot_hh_mem, a(round_id) cluster(vill)
	test treat + treat_peak==0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum act_done_early if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum act_done_early if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "emp-activity", replace 
	
	eststo: xi: areg hire_outside_vill_m0 treat treat_peak i.peak*totland_w i.occupselfempagri*peak i.scst*peak i.peak*tot_hh_mem if grid_id==1, a(round_id) cluster(vill)
	test treat + treat_peak==0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum hire_outside_vill_m0 if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hire_outside_vill_m0 if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "employer", replace 

	eststo: xi: areg trouble_hiring treat treat_peak i.peak*totland_w i.occupselfempagri*peak i.scst*peak i.peak*tot_hh_mem if grid_id==1, a(round_id) cluster(vill)	
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum trouble_hiring if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum trouble_hiring if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "employer", replace 
	
	esttab, se(3) replace nostar keep(treat treat_peak) l nonotes stats(pval lincom_se y_mean_lean y_mean_peak N obslevel, labels("Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak"  "N" "Level of observations")) nonote frag nonum nomti 

* Table B10. Employment Spillovers: Heterogeneous Impacts by Ability
	use "./data/cleandata/rationing_worker.dta", clear 
	gen high_quality = rating_std
	gen treat_high_quality = treat_rating_std
	gen peak_high_quality = peak_rating_std
	gen treat_peak_high_quality = treat_peak_rating_std
	gen high_quality_miss = rating_std_miss
	gen treat_high_quality_miss = treat_rating_std_miss
	gen peak_high_quality_miss = peak_rating_std_miss
	gen treat_peak_high_quality_miss = treat_peak_rating_std_miss
	label var high_quality "High ability proxy"
	label var treat_high_quality "Hiring shock * High ability proxy"
	label var peak_high_quality "Semi-peak * High ability proxy"
	label var treat_peak_high_quality "Hiring shock * Semi-peak * High ability proxy"

	eststo clear
	eststo: areg e_manwage treat treat_peak high_quality treat_high_quality peak_high_quality treat_peak_high_quality high_quality_miss treat_high_quality_miss peak_high_quality_miss treat_peak_high_quality_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local bl_mean "No", replace 
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace
	
	replace high_quality = bl_e_manwage_std
	replace treat_high_quality = treat_bl_e_manwage_std
	replace peak_high_quality = peak_bl_e_manwage_std
	replace treat_peak_high_quality = treat_peak_bl_e_manwage_std
	replace high_quality_miss = bl_e_manwage_std_miss
	replace treat_high_quality_miss = treat_bl_e_manwage_std_miss
	replace peak_high_quality_miss = peak_bl_e_manwage_std_miss
	replace treat_peak_high_quality_miss = treatpeak_bl_emanwagestd_miss
	
	eststo: areg e_manwage treat treat_peak high_quality treat_high_quality peak_high_quality treat_peak_high_quality high_quality_miss treat_high_quality_miss peak_high_quality_miss treat_peak_high_quality_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local bl_mean "No", replace 
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace
	
	replace high_quality = bl_dwagetot_std
	replace treat_high_quality = treat_bl_dwagetot_std
	replace peak_high_quality = peak_bl_dwagetot_std
	replace treat_peak_high_quality = treat_peak_bl_dwagetot_std
	replace high_quality_miss = bl_dwagetot_std_miss
	replace treat_high_quality_miss = treat_bl_dwagetot_std_miss
	replace peak_high_quality_miss = peak_bl_dwagetot_std_miss
	replace treat_peak_high_quality_miss = treatpeak_bl_dwagetotstd_miss
	
	eststo: areg e_manwage treat treat_peak high_quality treat_high_quality peak_high_quality treat_peak_high_quality high_quality_miss treat_high_quality_miss peak_high_quality_miss treat_peak_high_quality_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local bl_mean "No", replace 
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace
	
	esttab, stats(sample1 bl_mean pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N (worker-days)")) se(3) replace nostar l f nonotes noomit nocons nomti nonum 
		
* Table B11. Impact on Male Household Members
	use "./data/cleandata/rationing_worker.dta", clear 
	
	eststo clear 
	eststo: areg hh_m_work_labrmkt treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & hh_m_sno!=., a(round_id) cluster(vill_id)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum hh_m_work_labrmkt if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hh_m_work_labrmkt if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local sample "Spillover", replace 
	estadd local bl_mean "Yes", replace 

	* restricting to those who ever participate in LM 
	eststo: areg hh_m_work_labrmkt treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & hh_m_sno!=. & hh_m_part_markt==1, a(round_id) cluster(vill_id)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)	
	sum hh_m_work_labrmkt if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hh_m_work_labrmkt if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local sample "Spillover", replace 
	estadd local bl_mean "Yes", replace 

	eststo: areg hh_m_work_ownland treat treat_peak bl_bizagri bl_bizagri_miss bl_biznonagri bl_biznonagri_miss if surv_el==1 & sample_spillover==1 & hh_m_sno!=. , a(round_id) cluster(vill_id)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum hh_m_work_ownland if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hh_m_work_ownland if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local sample "Spillover", replace 
	estadd local bl_mean "Yes", replace
	
	eststo: areg hh_m_work_hhbiz treat treat_peak bl_bizagri bl_bizagri_miss bl_biznonagri bl_biznonagri_miss if surv_el==1 & sample_spillover==1 & hh_m_sno!=. , a(round_id) cluster(vill_id)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum hh_m_work_hhbiz if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hh_m_work_hhbiz if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local sample "Spillover", replace 
	estadd local bl_mean "Yes", replace
	
	eststo: areg hh_m_self_emp treat treat_peak bl_bizagri bl_bizagri_miss bl_biznonagri bl_biznonagri_miss i.occup_anyfarm_nm if surv_el==1 & sample_spillover==1 & hh_m_sno!=., a(round_id) cluster(vill_id)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	sum hh_m_self_emp if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum hh_m_self_emp if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local sample "Spillover", replace 
	estadd local bl_mean "Yes", replace
	
	esttab, stats(sample bl_mean pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N (workers)")) se(3) replace nostar keep(treat*) l nonotes frag nomti nonum 	

* Table B12. Differential Impacts of NREGA by Labor Market Slack
	use "./data/cleandata/rationing_nrega.dta", clear 
	global worker_controls female EducCat1 EducCat2 EducCat3 EducCat4 EducCat5 EducCat6 Age31to40 Age41to50 Age51to60
	global worker_controls_p female_p EducCat*_p Age*to*_p
	global Ag_controls C_AgYield*61*p

	eststo clear	
	eststo: areg pubworks_days NREGA NREGA_chigh high_cdays_pre_64 casual_days_month_pre_64 nonag_days_month_pre_64 self_days_month_pre_64 caswage_pre_64 caswage_pre_64_missing usualag_frac_pre_64  frac_nonag_pre_64   usualag_frac_pre_64_2  frac_nonag_pre_64_2 $worker_controls $worker_controls_p $Ag_controls i.ym missing64 [aweight=mult] , cluster(distid) absorb(distid)
	sum pubworks_days if e(sample) & round==64 & NREGA == 0
	estadd scalar treat_means=r(mean)
	test NREGA + NREGA_chigh=0
	estadd scalar test_stat=`r(p)'

	* note: wage reg has different weights 
	eststo: areg caswage_w1 NREGA NREGA_chigh high_cdays_pre_64 casual_days_month_pre_64 nonag_days_month_pre_64 self_days_month_pre_64 caswage_pre_64 caswage_pre_64_missing 	usualag_frac_pre_64  frac_nonag_pre_64  usualag_frac_pre_64_2  frac_nonag_pre_64_2 $worker_controls $worker_controls_p $Ag_controls i.ym missing64 [aweight=mult_wage] , cluster(distid) absorb(distid)
	sum caswage_w1 if e(sample) & round==64 & NREGA == 0
	estadd scalar treat_means=r(mean)
	test NREGA + NREGA_chigh=0
	estadd scalar test_stat=`r(p)'
		
	eststo: areg casual_days NREGA NREGA_chigh high_cdays_pre_64 casual_days_month_pre_64 nonag_days_month_pre_64 self_days_month_pre_64 caswage_pre_64 caswage_pre_64_missing 	usualag_frac_pre_64  frac_nonag_pre_64  usualag_frac_pre_64_2  frac_nonag_pre_64_2 $worker_controls $worker_controls_p $Ag_controls i.ym missing64 [aweight=mult] , cluster(distid) absorb(distid)
	sum casual_days if e(sample) & round==64 & NREGA == 0
	estadd scalar treat_means=r(mean)
	test NREGA + NREGA_chigh=0
	estadd scalar test_stat=`r(p)'
		
	eststo: areg agdays NREGA NREGA_chigh high_cdays_pre_64 casual_days_month_pre_64 nonag_days_month_pre_64 self_days_month_pre_64 caswage_pre_64 caswage_pre_64_missing 	usualag_frac_pre_64  frac_nonag_pre_64  usualag_frac_pre_64_2  frac_nonag_pre_64_2 $worker_controls $worker_controls_p $Ag_controls i.ym missing64 [aweight=mult] , cluster(distid) absorb(distid)
	sum agdays if e(sample) & round==64 & NREGA == 0
	estadd scalar treat_means=r(mean)
	test NREGA + NREGA_chigh=0
	estadd scalar test_stat=`r(p)'

	eststo: areg self_days_all NREGA NREGA_chigh high_cdays_pre_64 casual_days_month_pre_64 nonag_days_month_pre_64 self_days_month_pre_64 caswage_pre_64 caswage_pre_64_missing usualag_frac_pre_64  frac_nonag_pre_64  usualag_frac_pre_64_2  frac_nonag_pre_64_2 $worker_controls $worker_controls_p $Ag_controls i.ym missing64 if lpc~=0 [aweight=mult] , cluster(distid) absorb(distid)
	sum self_days_all if e(sample) & round==64 & NREGA == 0 & lpc~=0 
	estadd scalar treat_means=r(mean)
		test NREGA + NREGA_chigh=0
	estadd scalar test_stat=`r(p)'
		
	esttab, se(3) replace starlevels(* 0.10 ** 0.05 *** .01) keep(NREGA NREGA_chigh) label nonotes stats(treat_means test_stat N, labels("Control Mean" "Test: NREGA + NREGA x High Cas. Empl." "Observations")) nostar

* Table B13. Treatment Effects Using All Experimental Rounds
	use "./data/cleandata/rationing_worker_nodrop.dta", clear 

	eststo clear 
	eststo: areg ldailywagetot_w treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1, det
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 

	eststo: areg e_manwage treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	estadd local bl_mean "Yes", replace 
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 

	eststo: areg e_manwage treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss if surv_el ==1 [pw=weights_el], a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0 [aweight=weights_el]
	estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1 [aweight=weights_el]
	estadd scalar y_mean_peak=r(mean) 
	estadd local sample1 "Full Village Sample", replace 
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 

	eststo: areg e_self treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & sample_spillover==1 & avg_eself_ctrl>0, a(round_id) cluster(vill_id)
	sum e_self if e(sample) & treat==0 & peak==0 
	estadd scalar y_mean_lean=r(mean)
	sum e_self if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 

	eststo: areg e_wanted treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_wanted if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_wanted if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace
	estadd local sample1 "Spillover", replace 

	eststo: areg e_prefer treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)	
	sum e_prefer if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_prefer if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace
	estadd local sample1 "Spillover", replace 

	esttab, se(3) replace nostar keep(treat*) label nonotes stats(sample1 bl_mean pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N (worker-days)")) nonum nomti frag 

