/* This do file contains code that generates the main figures in "Labor Rationing" (Breza, Kaur & Shamdasani) */

* Table 1: Representativeness of Study Villages
	* This table uses the 2011 Indian Population Census data covering the districts in which this study took place. This data has not been made publicly available as some variables would allow for the user to identify study villages. 

	/*
	egen TOT_SCST = rowtotal(TOT_SC TOT_ST)
	gen sh_male_pop = M_POP / TOT_POP 
	gen sh_lit_pop = TOT_LIT / TOT_POP
	gen sh_w_pop = TOT_W / TOT_POP
	gen sh_malew_w = M_W / TOT_W
	gen sh_mnw_w = TOT_MNW/ TOT_W
	gen sh_aglb_w = TOT_AGLB/ TOT_W 
	gen sh_cult_w = TOT_CULT/ TOT_W
	gen sh_hhind_w = (TOT_W - TOT_AGLB - TOT_CULT - TOT_OTH_W) / TOT_W
	gen sh_othw_w = TOT_OTH_W / TOT_W	

	label var TOT_POP "Total population"
	label var TOT_HH "Total households"
	label var TOT_SCST "Total SC/ST population"
	label var sh_male_pop "Male population share"
	label var sh_lit_pop "Literacy rate"
	label var sh_w_pop "Worker share"
	label var sh_malew_w "Male worker share"
	label var sh_mnw_w "Main worker share"
	label var sh_aglb_w "Agricultural labor share"
	label var sh_cult_w "Cultivator share"
	label var sh_hhind_w "Non-farm self-employment share"
	label var sh_othw_w "Other workers share"

	eststo clear 
	* Col 1: means of study villages 
	estpost sum TOT_POP TOT_HH TOT_SCST sh_male_pop sh_lit_pop sh_w_pop sh_malew_w sh_mnw_w sh_aglb_w sh_cult_w sh_hhind_w sh_othw_w if rationing_village==1
	matrix mean0=e(mean)
	matrix list mean0
	matrix sd0=e(sd)
	matrix list sd0

	* Col 2: means of Census villages 
	estpost sum TOT_POP TOT_HH TOT_SCST sh_male_pop sh_lit_pop sh_w_pop sh_malew_w sh_mnw_w sh_aglb_w sh_cult_w sh_hhind_w sh_othw_w if rationing_village==0
	matrix mean1=e(mean)
	matrix list mean1
	matrix sd1=e(sd)
	matrix list sd1

	* Col 3: p-values 
	matrix p = (.,.,.,.,.,.,.,.,.,.,.,.)
	matrix colnames p = TOT_POP TOT_HH TOT_SCST sh_male_pop sh_lit_pop sh_w_pop sh_malew_w sh_mnw_w sh_aglb_w sh_cult_w sh_hhind_w sh_othw_w

	ttest TOT_POP, by(rationing_village) 
	matrix p[1,1] = r(p)

	ttest TOT_HH, by(rationing_village) 
	matrix p[1,2] = r(p)

	ttest TOT_SCST, by(rationing_village) 
	matrix p[1,3] = r(p)

	ttest sh_male_pop, by(rationing_village) 
	matrix p[1,4] = r(p)

	ttest sh_lit_pop, by(rationing_village) 
	matrix p[1,5] = r(p)

	ttest sh_w_pop, by(rationing_village) 
	matrix p[1,6] = r(p)

	ttest sh_malew_w, by(rationing_village) 
	matrix p[1,7] = r(p)

	ttest sh_mnw_w, by(rationing_village) 
	matrix p[1,8] = r(p)

	ttest sh_aglb_w, by(rationing_village) 
	matrix p[1,9] = r(p)

	ttest sh_cult_w, by(rationing_village) 
	matrix p[1,10] = r(p)

	ttest sh_hhind_w, by(rationing_village) 
	matrix p[1,11] = r(p)

	ttest sh_othw_w, by(rationing_village) 
	matrix p[1,12] = r(p)

	estadd matrix mean0
	estadd matrix sd0
	estadd matrix mean1
	estadd matrix sd1
	estadd matrix p

	esttab, noobs cells("mean0(fmt(a3)) mean1(fmt(a3)) p(fmt(3))" "sd0(par fmt(3)) sd1(par fmt(3))") star(* 0.1 ** .05 *** 0.01) l nonum collabels("Study villages" "All villages" "p-val") replace nocons
	*/

* Table 2. Baseline Characteristics 

* Panel A: worker-level 
	use "./data/cleandata/rationing_worker.dta", clear
	foreach x of varlist bl_noland bl_e_any bl_e_manwage bl_dwagetot bl_e_publicworks bl_has_hhbiz bl_e_self bl_daysworkfut30 {
	replace `x'=. if `x'_miss==1
	}

	* Col 1: mean and s.d. in control villages 
		eststo clear  
		estpost sum bl_noland bl_tot_hh_mem bl_e_any bl_e_manwage bl_dwagetot bl_e_publicworks bl_has_hhbiz bl_e_self bl_daysworkfut30 if surv_el==1 & sample_spillover==1 & treat==0 & grid_id==1
		matrix mean_control=e(mean)
		matrix list mean_control
		matrix sd_control=e(sd)
		matrix list sd_control

	* Col 2: difference across treatment and control villages 
		matrix diff_coeff = (.,.,.,.,.,.,.,.,.)
		matrix colnames diff_coeff = bl_noland bl_tot_hh_mem bl_e_any bl_e_manwage bl_dwagetot bl_e_publicworks bl_has_hhbiz bl_e_self bl_daysworkfut30
		matrix diff_se = (.,.,.,.,.,.,.,.,.)
		matrix colnames diff_se = bl_noland bl_tot_hh_mem bl_e_any bl_e_manwage bl_dwagetot bl_e_publicworks bl_has_hhbiz bl_e_self bl_daysworkfut30

		areg bl_noland treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,1] = _b[treat]
		matrix diff_se[1,1] = _se[treat]

		areg bl_tot_hh_mem treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,2] = _b[treat]
		matrix diff_se[1,2] = _se[treat]

		areg bl_e_any treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,3] = _b[treat]
		matrix diff_se[1,3] = _se[treat]

		areg bl_e_manwage treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,4] = _b[treat]
		matrix diff_se[1,4] = _se[treat]

		areg bl_dwagetot treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,5] = _b[treat]
		matrix diff_se[1,5] = _se[treat]

		areg bl_e_publicworks treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,6] = _b[treat]
		matrix diff_se[1,6] = _se[treat]

		areg bl_has_hhbiz treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,7] = _b[treat]
		matrix diff_se[1,7] = _se[treat]

		areg bl_e_self treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,8] = _b[treat]
		matrix diff_se[1,8] = _se[treat]

		areg bl_daysworkfut30 treat if surv_el==1 & sample_spillover==1 & grid_id==1, absorb(round_id) cluster(vill_id) 
		matrix diff_coeff[1,9] = _b[treat]
		matrix diff_se[1,9] = _se[treat]

		estadd matrix mean_control
		estadd matrix sd_control
		estadd matrix diff_coeff
		estadd matrix diff_se

		esttab, noobs cells("mean_control(fmt(3)) diff_coeff(fmt(3))" "sd_control(par fmt(3)) diff_se(par fmt(3))") nostar l nonum collabels("No hiring shock" "Difference") replace nocons nomti 

	* Sample size for table notes 
 		count if surv_el==1 & sample_spillover==1 & grid_id==1

* Panel B: village-level 
	eststo clear   
	matrix b2 = (.)
	matrix colnames b2 = frac_signup 
	matrix se2 = (.)
	matrix colnames se2 = frac_signup  
	matrix mean_control_v= (.)
	matrix colnames mean_control_v = frac_signup 
	matrix sd_control_v=(.)
	matrix colnames sd_control_v = frac_signup 

	areg frac_signup treat if vill1==1, absorb(round_id) 
	matrix b2[1,1] = _b[treat]
	matrix se2[1,1] = _se[treat]
 	sum frac_signup if treat==0 & vill1==1
	matrix mean_control_v[1,1] = r(mean)
	matrix sd_control_v[1,1] = r(sd) 

	* Sample size for table notes 
		count if vill1==1

	estadd matrix mean_control_v
	estadd matrix sd_control_v
	estadd matrix b2
	estadd matrix se2

	esttab, noobs cells("mean_control_v(fmt(a3)) b2(fmt(a3))" "sd_control_v(par fmt(3)) se2(par fmt(3))") nostar l nonum collabels(none) replace nocons frag nomti 

	* The subsequent rows in this panel are generated using the 2011 Indian Population Census data. This data has not been made publicly available as some variables would allow for the user to identify study villages. 
	/*
	areg tot_hh treat, absorb(round_id) 
	matrix b2[1,2] = _b[treat]
	matrix se2[1,2] = _se[treat]
 	sum tot_hh if treat==0
	matrix mean_control_v[1,2] = r(mean)
	matrix sd_control_v[1,2] = r(sd) 

	areg tot_scst treat, absorb(round_id) 
	matrix b2[1,3] = _b[treat]
	matrix se2[1,3] = _se[treat]
 	sum tot_scst if treat==0
	matrix mean_control_v[1,3] = r(mean)
	matrix sd_control_v[1,3] = r(sd) 

	areg sh_lit_pop treat, absorb(round_id) 
	matrix b2[1,4] = _b[treat]
	matrix se2[1,4] = _se[treat]
 	sum sh_lit_pop if treat==0
	matrix mean_control_v[1,4] = r(mean)
	matrix sd_control_v[1,4] = r(sd) 

	areg sh_w_pop treat, absorb(round_id) 
	matrix b2[1,5] = _b[treat]
	matrix se2[1,5] = _se[treat]
	sum sh_w_pop if treat==0
	matrix mean_control_v[1,5] = r(mean)
	matrix sd_control_v[1,5] = r(sd) 

	areg sh_mnw_w treat, absorb(round_id) 
	matrix b2[1,6] = _b[treat]
	matrix se2[1,6] = _se[treat]
	sum sh_mnw_w if treat==0
	matrix mean_control_v[1,6] = r(mean)
	matrix sd_control_v[1,6] = r(sd) 
	*/
	
* Table 3. Wage Effects
	use "./data/cleandata/rationing_worker.dta", clear
	
	eststo clear 
	eststo: areg ldailywagecash_w treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagecash_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagecash_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
	estadd scalar pval = r(p)
	estadd scalar pval2 = .
	estadd scalar pval3 = .	
	estadd scalar pval4 = .
	estadd local sample_l1 "Spillover", replace 
	estadd local bl_mean "No", replace 
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local levelobs "worker-days", replace 

	eststo: areg ldailywagetot_w treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
	estadd scalar pval = r(p)
	estadd scalar pval2 = .
	estadd scalar pval3 = .	
	estadd scalar pval4 = .
	estadd local sample_l1 "Spillover", replace 
	estadd local bl_mean "No", replace 
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local levelobs "worker-days", replace 

	eststo: areg ldailywagetot_w treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
	estadd scalar pval = r(p)
	estadd scalar pval2 = .
	estadd scalar pval3 = .	
	estadd scalar pval4 = .
	estadd local sample_l1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local levelobs "worker-days", replace 

	eststo: areg dailywagetot_w treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum dailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum dailywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
	estadd scalar pval = r(p)
	estadd scalar pval2 = .
	estadd scalar pval3 = .	
	estadd scalar pval4 = .
	estadd local sample_l1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local levelobs "worker-days", replace 

	eststo: areg ldailywagetot_w treat treat_peakc bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	estadd scalar pval = .
	estadd scalar pval2 = .
	estadd scalar pval3 = .	
	estadd scalar pval4 = .
	estadd local sample_l1 "Spillover", replace 
	estadd local bl_mean "Yes", replace 
	lincom treat + treat_peak
	estadd scalar lincom_se = . 
	estadd local levelobs "worker-days", replace 

	eststo: areg ldailywagetot_w treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & e_manwage==1 & (sample_spillover==1 | sample_nonsignup==1) [pw=weights_el], a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0 [aweight = weights_el]
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1 [aweight = weights_el]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd scalar pval2 = .
		estadd scalar pval3 = .	
		estadd scalar pval4 = .	
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local sample_l1 "All Potential", replace 
	estadd local sample_l2 "Workers", replace  
	estadd local bl_mean "Yes", replace 
	estadd local levelobs "worker-days", replace

	eststo: areg ldailywagetot_w treat treat_peak treat_nonsignup treat_nonsignup_peak sample_nonsignup peak_nonsignup bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & e_manwage==1 & (sample_spillover==1 | sample_nonsignup==1) [pw=weights_el], a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0 [aweight = weights_el]
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1 [aweight = weights_el]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	test treat + treat_nonsignup = 0
		estadd scalar pval2 = r(p)
	test treat_peak + treat + treat_nonsignup + treat_nonsignup_peak=0
		estadd scalar pval3 = r(p)
	test treat_nonsignup + treat_nonsignup_peak=0
		estadd scalar pval4 = r(p)	
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local sample_l1 "All Potential", replace 
	estadd local sample_l2 "Workers", replace
	estadd local bl_mean "Yes", replace 
	estadd local levelobs "worker-days", replace 

	use "./data/cleandata/rationing_employer.dta", clear 

	eststo: areg ldailywagetot_w treat treat_peak if hiring_invillage==1 & (ldailywagecash_w>0 & ldailywagecash_w!=.), a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak==0
		estadd scalar pval = r(p)
		estadd scalar pval2 = .
		estadd scalar pval3 = .	
		estadd scalar pval4 = .
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local bl_mean "No", replace 
	estadd local sample_l1 "Village", replace 
	estadd local sample_l2 "Employers", replace 
	estadd local levelobs "employer-activity", replace 

	esttab, se(3) replace nostar keep(treat* sample_nonsignup peak_nonsignup) order(treat treat_peak treat_peakc treat_nonsignup treat_nonsignup_peak peak_nonsignup sample_nonsignup) stats(sample_l1 sample_l2 bl_mean pval lincom_se pval2 pval3 pval4 y_mean_lean y_mean_peak N levelobs, labels("Sample" " " "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Pval: Shock + Shock* Non Sign-Ups (NSU)" "Pval: Shock + Shock*Semi-peak +  Shock*NSU  + Shock*Semi-peak*NSU" "Pval: Shock*NSU + Shock*Semi-peak*NSU" "Control mean: lean" "Control mean: semi-peak"  "N" "Level of observations")) l nonotes 

* Table 4. Alternate Measures of Wages and Wage Contract
	use "./data/cleandata/rationing_worker.dta", clear

	eststo clear 
	eststo: areg hourlywagetot_w treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1, a(round_id) cluster(vill_id)
	sum hourlywagetot_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum hourlywagetot_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-day", replace 

	eststo: areg hours treat treat_peak if surv_el==1 & sample_spillover==1 & e_manwage==1 & gotdailywage==1, a(round_id) cluster(vill_id)
	sum hours if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum hours if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker-day", replace 

	eststo: areg emp_expect_work_days_w treat treat_peak if surv_el==1 & sample_spillover==1 & grid_id==1, a(round_id) cluster(vill_id)
	sum emp_expect_work_days_w if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum emp_expect_work_days_w if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker", replace 

	eststo: areg emp_approach_loan treat treat_peak if surv_el==1 & sample_spillover==1 & grid_id==1, a(round_id) cluster(vill_id)
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	sum emp_approach_loan if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum emp_approach_loan if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker", replace

	eststo: areg emp_paid_directly treat treat_peak if surv_el==1 & sample_spillover==1 & grid_id==1, a(round_id) cluster(vill_id)
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	sum emp_paid_directly if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum emp_paid_directly if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker", replace 

	eststo: areg emp_get_advance treat treat_peak if surv_el==1 & sample_spillover==1 & grid_id==1, a(round_id) cluster(vill_id)
	test treat+treat_peak=0
		estadd scalar pval = r(p)
	sum emp_get_advance if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum emp_get_advance if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local obslevel "worker", replace 

	esttab, se(3) replace nostar keep(treat treat_peak) l nonotes stats(sample1 pval lincom_se y_mean_lean y_mean_peak N obslevel, labels("Sample" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak"  "N" "Level of observations")) nonote 

* Table 5. Employment Spillovers 
	use "./data/cleandata/rationing_worker.dta", clear

	eststo clear 
	eststo: areg e_manwage treat treat_peak if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_controls "No", replace 

	eststo: areg e_manwage treat treat_peak bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace
	estadd local bl_controls "Yes", replace 

	eststo: areg e_manwage treat treat_peakc bl_ldwagetot bl_dwagetot_miss bl_e_manwage bl_e_manwage_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	estadd scalar pval = .
	estadd scalar lincom_se = . 
	estadd local sample1 "Spillover", replace 
	estadd local bl_controls "Yes", replace 

	esttab, stats(sample1 bl_controls pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak"  "Control mean: lean" "Control mean: semi-peak" "N (worker-days)")) se(3) replace nostar keep(treat*) l nonotes 		
	
* Table 6. Aggregate Employment Effects and Crowd-Out
	use "./data/cleandata/rationing_worker.dta", clear

	eststo clear 
	eststo: areg e_manwage treat treat_peak bl_ldwagetot bl_ldwagetot_miss bl_e_manwage bl_e_manwage_miss bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss if surv_el==1 [pw=weights_el], a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0 [aweight= weights_el] 
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1 [aweight= weights_el] 
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)	 
	estadd local sample1 "Full Village", replace 
	estadd local sample2 "Sample", replace 	
	estadd local bl_controls "Yes", replace 
	estadd local levelobs "worker-days", replace 

	eststo: areg e_manwage treat treat_peakc bl_ldwagetot bl_ldwagetot_miss bl_e_manwage bl_e_manwage_miss bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss if surv_el==1 [pw=weights_el], a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0 [aweight= weights_el] 
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1 [aweight= weights_el] 
		estadd scalar y_mean_peak=r(mean)
	estadd scalar pval = .
	estadd scalar lincom_se = .
	estadd local sample1 "Full Village", replace 
	estadd local sample2 "Sample", replace 		
	estadd local bl_controls "Yes", replace 
	estadd local levelobs "worker-days", replace 

	* collapse data to village-day level 
		keep if surv_el==1 & ws_open==1
		replace bl_dwagetot = . if bl_dwagetot==0 & bl_dwagetot_miss==1
		replace bl_ldwagetot = . if bl_ldwagetot==0 & bl_dwagetot_miss==1
		replace bl_e_manwage = . if bl_e_manwage==0 & bl_e_manwage_miss==1
		
		gen ones = 1
		collapse (sum) count_e=ones (mean) e_manwage treat treat_peak bl_e_manwage bl_dwagetot (median) round_id ws_total_attendance peak lf_estim bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss [pweight=weights_el], by(vill_id grid_date) 

		gen bl_ldwagetot_miss = (bl_dwagetot==.)
		gen bl_ldwagetot = log(bl_dwagetot)
			replace bl_ldwagetot=0 if bl_ldwagetot_miss ==1
		
		gen bl_e_manwage_miss = (bl_e_manwage==.)
			replace bl_e_manwage=0 if bl_e_manwage_miss==1
		
		gen e_worksite = ws_total_attendance/lf_estim 
		gen e_worksite_peak = e_worksite*peak 

		label var treat "Hiring shock"
		label var treat_peak "Hiring shock * Semi-peak"
		label var e_manwage "Hired wage empl."
		label var e_worksite "Hiring shock empl."
		label var e_worksite_peak "Hiring shock empl. * Semi-peak"

	eststo: areg e_manwage treat treat_peak bl_e_manwage bl_ldwagetot bl_e_manwage_miss bl_ldwagetot_miss bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss [aweight=count_e], a(round_id) cl(vill_id)
	test treat + treat_peak=0
		estadd scalar pval = r(p)
	sum e_manwage if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Full Village", replace 
	estadd local sample2 "Sample", replace 	
	estadd local bl_controls "Yes", replace 
	estadd local regtype "RF", replace 
	estadd local levelobs "village-days", replace 

	eststo: areg e_worksite treat treat_peak bl_e_manwage bl_ldwagetot bl_e_manwage_miss bl_ldwagetot_miss bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss [aweight=count_e], a(round_id) cl(vill_id)
	test treat + treat_peak=0
	estadd scalar pval = r(p)
	sum e_worksite if e(sample) & treat==0 & peak==0
	estadd scalar y_mean_lean=r(mean)
	sum e_worksite if e(sample) & treat==0 & peak==1
	estadd scalar y_mean_peak=r(mean)
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)
	estadd local sample1 "Full Village", replace 
	estadd local sample2 "Sample", replace 	
	estadd local bl_controls "Yes", replace 	
	estadd local regtype "FS", replace 
	estadd local levelobs "village-days", replace 

	eststo: ivregress 2sls e_manwage (e_worksite e_worksite_peak = treat treat_peak) bl_e_manwage bl_ldwagetot bl_e_manwage_miss bl_ldwagetot_miss bl_dwagetot_v bl_dwagetot_v_miss bl_e_manwage_v bl_e_manwage_v_miss i.round_id [aweight=count_e], cl(vill_id)
	test e_worksite + e_worksite_peak=0
		estadd scalar pval = r(p)
	lincom e_worksite + e_worksite_peak
		estadd scalar lincom_se = r(se) 
	sum e_manwage if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	estadd local sample1 "Full Village", replace 
	estadd local sample2 "Sample", replace 	
	estadd local bl_controls "Yes", replace
	estadd local regtype "IV", replace 
	estadd local levelobs "village-days", replace 

	esttab, stats(sample1 sample2 bl_controls pval lincom_se y_mean_lean y_mean_peak regtype N levelobs, labels("Sample" " " "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "Specification" "N" "Level of observations")) se(3) replace nostar keep(treat* e_worksite e_worksite_peak) nonotes l 

* Table 7. Impact 2 Weeks After End of Hiring Shock 
	use "./data/cleandata/rationing_worker.dta", clear

	eststo clear
	eststo: areg ldailywagetot_w treat treat_peak if sample_spillover==1 & surv_post==1 & e_manwage==1 [pw=weights_post], a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_controls "No", replace

	eststo: areg ldailywagetot_w treat treat_peak bl_e_manwage bl_e_manwage_miss bl_ldwagetot bl_dwagetot_miss if sample_spillover==1 & surv_post==1 & e_manwage==1 [pw=weights_post], a(round_id) cluster(vill_id)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum ldailywagetot_w if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_controls "Yes", replace

	eststo: areg e_manwage treat treat_peak bl_e_manwage bl_e_manwage_miss bl_ldwagetot bl_dwagetot_miss if sample_spillover==1 & surv_post==1 [pw=weights_post], a(round_id) cluster(vill_id)
	sum e_manwage if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum e_manwage if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_controls "Yes", replace 

	eststo: areg e_self treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if sample_spillover==1 & surv_post==1 [pw=weights_post], a(round_id) cluster(vill_id)
	sum e_self if e(sample) & treat==0 & peak==0 [aweight= weights_post]
		estadd scalar y_mean_lean=r(mean)
	sum e_self if e(sample) & treat==0 & peak==1 [aweight= weights_post]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local bl_controls "Yes", replace

	esttab, se(3) replace nostar keep(treat*) l nonotes stats(sample1 bl_controls pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N (worker-days)"))

* Table 8. Self-employment
	use "./data/cleandata/rationing_worker.dta", clear

	eststo clear
	eststo: areg e_self treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if sample_spillover==1 & surv_el==1 & avg_eself_ctrl>0, a(round_id) cluster(vill_id)
	sum e_self if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_self if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p) 
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local bl_mean "Yes", replace 
	estadd local obslevel "worker-days", replace

	eststo: areg e_selfnonagri treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if sample_spillover==1 & surv_el==1 & avg_eselfnonagri_ctrl>0, a(round_id) cluster(vill_id)
	sum e_selfnonagri if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_selfnonagri if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local bl_mean "Yes", replace 
	estadd local obslevel "worker-days", replace 

	eststo: areg e_selfagri treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if sample_spillover==1 & surv_el==1 & avg_eselfagri_ctrl>0, a(round_id) cluster(vill_id)
	sum e_selfagri if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_selfagri if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local bl_mean "Yes", replace 
	estadd local obslevel "worker-days", replace 

	eststo: areg e_selfagri treat treat_peak treat_peak_landpermem_above treat_landpermem_above peak_landpermem_above landpermem_above treat_landpermem_m0 treat_peak_landpermem_m0 peak_landpermem_m0 landpermem_m0 bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if sample_spillover==1 & surv_el==1 & avg_eselfagri_ctrl>0, a(round_id) cluster(vill_id)
	sum e_selfagri if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
	sum e_selfagri if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
		estadd scalar pval = r(p)
	test treat + treat_landpermem_above = 0
		estadd scalar pval2 = r(p)
	lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "Spillover", replace 
	estadd local sample2 " ", replace 
	estadd local obslevel "worker-days", replace 
	
	eststo: areg e_selfnonagri treat treat_peak bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & (sample_spillover==1 | sample_nonsignup==1) & avg_eselfnonagri_ctrl>0 [pw=weights_el], a(round_id) cluster(vill_id)
	sum e_selfnonagri if e(sample) & treat==0 & peak==0 [aweight= weights_el]
	estadd scalar y_mean_lean=r(mean)
	sum e_selfnonagri if e(sample) & treat==0 & peak==1 [aweight= weights_el]
		estadd scalar y_mean_peak=r(mean)
	test treat + treat_peak = 0
	estadd scalar pval = r(p)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "All Potential", replace 
	estadd local sample2 "Workers", replace 
	estadd local obslevel "worker-days", replace
	lincom treat + treat_peak
	estadd scalar lincom_se = r(se)

	eststo: areg e_selfagri treat treat_peak treat_peak_landpermem_above treat_landpermem_above peak_landpermem_above landpermem_above treat_landpermem_m0 treat_peak_landpermem_m0 peak_landpermem_m0 landpermem_m0 bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & (sample_spillover==1 | sample_nonsignup==1) & avg_eselfagri_ctrl>0 [pw=weights_el], a(round_id) cluster(vill_id)
	sum e_selfagri if e(sample) & treat==0 & peak==0 [aweight= weights_el]
	estadd scalar y_mean_lean=r(mean)
	sum e_selfagri if e(sample) & treat==0 & peak==1 [aweight= weights_el]
	estadd scalar y_mean_peak=r(mean) 
	test treat + treat_peak = 0
	estadd scalar pval = r(p)
	estadd local bl_mean "Yes", replace 
	estadd local sample1 "All Potential", replace 
	estadd local sample2 "Workers", replace 
	test treat + treat_landpermem_above = 0
	estadd scalar pval2 = r(p)
	estadd local obslevel "worker-days", replace 
		lincom treat + treat_peak
	estadd scalar lincom_se = r(se)

	eststo: areg farm_labor_tot treat treat_peak treat_peak_landpermem_above treat_landpermem_above peak_landpermem_above landpermem_above treat_landpermem_m0 treat_peak_landpermem_m0 peak_landpermem_m0 landpermem_m0 bl_biznonagri bl_biznonagri_miss bl_bizagri bl_bizagri_miss if surv_el==1 & (sample_spillover==1 | sample_nonsignup==1) & avg_eselfagri_ctrl>0 & grid_id==1 [pw=weights_el], a(round_id) cluster(vill_id)
	test treat+treat_peak=0
	estadd scalar pval = r(p)
	estadd local sample1 "All Potential", replace 
	estadd local sample2 "Workers", replace 
	estadd local bl_mean "Yes", replace 
	sum farm_labor_tot if e(sample) & treat==0 & peak==0 [aweight= weights_el]
	estadd scalar y_mean_lean=r(mean)
	sum farm_labor_tot if e(sample) & treat==0 & peak==1 [aweight= weights_el]
	estadd scalar y_mean_peak=r(mean)
	estadd local obslevel "households", replace 
		lincom treat + treat_peak
	estadd scalar lincom_se = r(se)

	esttab, stats(sample1 sample2 bl_mean pval lincom_se y_mean_lean y_mean_peak N obslevel, labels("Sample" " " "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak" "N" "Level of observations")) se(3) replace nostar keep(treat treat_peak treat_peak_landpermem_above treat_landpermem_above) order(treat treat_landpermem_above treat_peak treat_peak_landpermem_above) l nonotes nomti

* Table 9. Measuring Involuntary Unemployment
	use "./data/cleandata/rationing_worker.dta", clear

	eststo clear 
 	eststo: areg e_worked treat treat_peak if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
		sum e_worked if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
		sum e_worked if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
		test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd local bl_mean "No", replace
		estadd local sample1 "Spillover", replace 
		lincom treat + treat_peak
		estadd scalar lincom_se = r(se)

	eststo: areg e_worked treat treat_peak bl_e_manwage bl_e_manwage_miss bl_ldwagetot bl_dwagetot_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
		sum e_worked if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
		sum e_worked if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
		test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd local bl_mean "Yes", replace
		estadd local sample1 "Spillover", replace 
		lincom treat + treat_peak
		estadd scalar lincom_se = r(se)
	
	eststo: areg e_wanted treat treat_peak if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
		sum e_wanted if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
		sum e_wanted if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
		test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd local bl_mean "No", replace
		estadd local sample1 "Spillover", replace 
		lincom treat + treat_peak
		estadd scalar lincom_se = r(se)

	eststo: areg e_wanted treat treat_peak bl_e_manwage bl_e_manwage_miss bl_ldwagetot bl_dwagetot_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)
		sum e_wanted if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
		sum e_wanted if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
		test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd local bl_mean "Yes", replace
		estadd local sample1 "Spillover", replace 
		lincom treat + treat_peak
		estadd scalar lincom_se = r(se)

	eststo: areg e_prefer treat treat_peak if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)	
		sum e_prefer if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
		sum e_prefer if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
		test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd local bl_mean "No", replace
		estadd local sample1 "Spillover", replace 
		lincom treat + treat_peak
		estadd scalar lincom_se = r(se)

	eststo: areg e_prefer treat treat_peak bl_e_manwage bl_e_manwage_miss bl_ldwagetot bl_dwagetot_miss if surv_el==1 & sample_spillover==1, a(round_id) cluster(vill_id)	
		sum e_prefer if e(sample) & treat==0 & peak==0
		estadd scalar y_mean_lean=r(mean)
		sum e_prefer if e(sample) & treat==0 & peak==1
		estadd scalar y_mean_peak=r(mean)
		test treat + treat_peak = 0
		estadd scalar pval = r(p)
		estadd local bl_mean "Yes", replace
		estadd local sample1 "Spillover", replace 
		lincom treat + treat_peak
		estadd scalar lincom_se = r(se)

	esttab, stats(sample1 bl_mean pval lincom_se y_mean_lean y_mean_peak N, labels("Sample" "Baseline controls" "Pval: Shock + Shock*Semi-peak" "SE: Shock + Shock*Semi-peak" "Control mean: lean" "Control mean: semi-peak"  "N (worker-days)")) se(3) replace nostar keep(treat*) l nonotes 

	* Are the coefficients in cols 3 and 5 different from each other?
	eststo clear 
	reg e_wanted treat treat_peak i.round_id if surv_el==1 & sample_spillover==1
	eststo reg1 
	
	reg e_prefer treat treat_peak i.round_id if surv_el==1 & sample_spillover==1
	eststo reg2 

	suest reg1 reg2, cluster(vill_id)
	test [reg1_mean]treat=[reg2_mean]treat
