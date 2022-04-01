
/* This do file contains code that generates the main figures in "Labor Rationing" (Breza, Kaur & Shamdasani) */

* Use masterdata 
	use "./data/cleandata/rationing_worker.dta", clear 
	  
* Figure 3. Size of the Experimental Hiring Shock
	sum frac_hired if vill1==1 & treat==1, d
	local mean_shocksize = r(mean)
	hist frac_hired if vill1==1 & treat==1, frac w(.01) start(0) xline(`mean_shocksize', lpattern(dash)) xtitle("Fraction of male labor force") title("Size of the Experimental Hiring Shock") ylabel(0(0.05)0.12) 
	graph export "$dir_output/rationing_fig3.pdf", replace 

* Figure 4. Impacts of Hiring Shock 
	* 1. daily wage 
		* a. lean months 
		cumul dailywagetot if treat==0 &  surv_el==1 & sample_spillover==1 & e_manwage==1 & peak==0, generate(cdf_wage_control_lean)
		cumul dailywagetot if treat==1 &  surv_el==1 & sample_spillover==1 & e_manwage==1 & peak==0, generate(cdf_wage_treat_lean)

		sort cdf_wage_control_lean cdf_wage_treat_lean
		twoway (line cdf_wage_control_lean dailywagetot if treat==0 & surv_el==1 & sample_spillover==1 & e_manwage==1, lpattern(dash) lcolor(green)) (line cdf_wage_treat_lean dailywagetot if treat==1 & surv_el==1 & sample_spillover==1 & e_manwage==1, lcolor(red)), ytitle("Fraction") legend(order(1 "Control villages" 2 "Treatment villages"))
		graph export "$dir_output/rationing_fig4_1A.pdf", replace 
		ksmirnov dailywagetot if surv_el==1 & sample_spillover==1 & e_manwage==1 & peak==0, by(treat)

		* b. semi-peak months 
		cumul dailywagetot if treat==0 & surv_el==1 & sample_spillover==1 & e_manwage==1 & peak==1, generate(cdf_wage_control_peak)
		cumul dailywagetot if treat==1 & surv_el==1 & sample_spillover==1 & e_manwage==1 & peak==1, generate(cdf_wage_treat_peak)

		sort cdf_wage_control_peak cdf_wage_treat_peak
		twoway (line cdf_wage_control_peak dailywagetot if treat==0 & surv_el==1 & sample_spillover==1 & e_manwage==1, lpattern(dash) lcolor(green)) (line cdf_wage_treat_peak dailywagetot if treat==1 & surv_el==1 & sample_spillover==1 & e_manwage==1, lcolor(red)), ytitle("Fraction") legend(order(1 "Control villages" 2 "Treatment villages"))
		graph export "$dir_output/rationing_fig4_1B.pdf", replace 		
		ksmirnov dailywagetot if surv_el==1 & sample_spillover==1 & e_manwage==1 & peak==1, by(treat)

	* 2. employment spillovers 
		* a. lean months 
		cumul e_manwage_tot if treat==0 & surv_el==1 & sample_spillover==1 & peak==0 & grid_id==1, generate(cdf_e_manwage_control_lean)
		cumul e_manwage_tot if treat==1 & surv_el==1 & sample_spillover==1 & peak==0 & grid_id==1, generate(cdf_e_manwage_treat_lean)

		sort cdf_e_manwage_control_lean cdf_e_manwage_treat_lean
		twoway (line cdf_e_manwage_control_lean e_manwage_tot if treat==0 & surv_el==1 & sample_spillover==1, lpattern(dash) lcolor(green)) (line cdf_e_manwage_treat_lean e_manwage_tot if treat==1 & surv_el==1 & sample_spillover==1, lcolor(red)), ytitle("Fraction") xlabel(0(1)7) legend(order(1 "Control villages" 2 "Treatment villages"))
		graph export "$dir_output/rationing_fig4_2A.pdf", replace 
		ksmirnov e_manwage_tot if surv_el==1 & sample_spillover==1 & peak==0 & grid_id==1, by(treat)

		* b. semi-peak months 
		cumul e_manwage_tot if treat==0 & surv_el==1 & sample_spillover==1 & peak==1 & grid_id==1, generate(cdf_e_manwage_control_peak)
		cumul e_manwage_tot if treat==1 & surv_el==1 & sample_spillover==1 & peak==1 & grid_id==1, generate(cdf_e_manwage_treat_peak)

		sort cdf_e_manwage_control_peak cdf_e_manwage_treat_peak
		twoway (line cdf_e_manwage_control_peak e_manwage_tot if treat==0 & surv_el==1 & sample_spillover==1, lpattern(dash) lcolor(green)) (line cdf_e_manwage_treat_peak e_manwage_tot if treat==1 & surv_el==1 & sample_spillover==1, lcolor(red)), ytitle("Fraction") xlabel(0(1)7) legend(order(1 "Control villages" 2 "Treatment villages")) 
		graph export "$dir_output/rationing_fig4_2B.pdf", replace 
		ksmirnov e_manwage_tot if surv_el==1 & sample_spillover==1 & peak==1 & grid_id==1, by(treat)

	* 3. aggregate employment 
		* a. lean months 
		cumul e_manwage_tot if treat==0 & surv_el==1 & peak==0 & grid_id==1, generate(cdf_e_manwage_agg_control_lean)
		cumul e_manwage_tot if treat==1 & surv_el==1 & peak==0 & grid_id==1, generate(cdf_e_manwage_agg_treat_lean)

		sort cdf_e_manwage_agg_control_lean cdf_e_manwage_agg_treat_lean
		twoway (line cdf_e_manwage_agg_control_lean e_manwage_tot if treat==0 & surv_el==1, lpattern(dash) lcolor(green)) (line cdf_e_manwage_agg_treat_lean e_manwage_tot if treat==1 & surv_el==1, lcolor(red)), ytitle("Fraction") xlabel(0(1)7) legend(order(1 "Control villages" 2 "Treatment villages"))
		graph export "$dir_output/rationing_fig4_3A.pdf", replace 
		ksmirnov e_manwage_tot if surv_el==1 & peak==0 & grid_id==1, by(treat)

		* b. semi-peak months 
		cumul e_manwage_tot if treat==0 & surv_el==1 & peak==1 & grid_id==1, generate(cdf_e_manwage_agg_control_peak)
		cumul e_manwage_tot if treat==1 & surv_el==1 & peak==1 & grid_id==1, generate(cdf_e_manwage_agg_treat_peak)

		sort cdf_e_manwage_agg_control_peak cdf_e_manwage_agg_treat_peak
		twoway (line cdf_e_manwage_agg_control_peak e_manwage_tot if treat==0 & surv_el==1, lpattern(dash) lcolor(green)) (line cdf_e_manwage_agg_treat_peak e_manwage_tot if treat==1 & surv_el==1, lcolor(red)), ytitle("Fraction") xlabel(0(1)7) legend(order(1 "Control villages" 2 "Treatment villages"))
		graph export "$dir_output/rationing_fig4_3B.pdf", replace 		
		ksmirnov e_manwage_tot if surv_el==1 & peak==1 & grid_id==1, by(treat)

	* 4. self employment 
		* a. lean months 
		cumul e_self_tot if treat==0 & surv_el==1 & sample_spillover==1 & peak==0 & avg_eself_ctrl>0 & grid_id==1, generate(cdf_e_self_control_lean)
		cumul e_self_tot if treat==1 & surv_el==1 & sample_spillover==1 & peak==0 & avg_eself_ctrl>0 & grid_id==1, generate(cdf_e_self_treat_lean)

		sort cdf_e_self_control_lean cdf_e_self_treat_lean
		twoway (line cdf_e_self_control_lean e_self_tot if treat==0 & surv_el==1 & sample_spillover==1 & grid_id==1, lpattern(dash) lcolor(green)) (line cdf_e_self_treat_lean e_self_tot if treat==1 & surv_el==1 & sample_spillover==1 & grid_id==1, lcolor(red)), ytitle("Fraction") legend(order(1 "Control villages" 2 "Treatment villages")) xlabel(0(1)7)
		graph export "$dir_output/rationing_fig4_4A.pdf", replace 
		ksmirnov e_self_tot if surv_el==1 & sample_spillover==1 & peak==0 & avg_eself_ctrl>0 & grid_id==1, by(treat)

		* b. semi-peak months 
		cumul e_self_tot if treat==0 & surv_el==1 & sample_spillover==1 & peak==1 & avg_eself_ctrl>0 & grid_id==1, generate(cdf_e_self_control_peak)
		cumul e_self_tot if treat==1 & surv_el==1 & sample_spillover==1 & peak==1 & avg_eself_ctrl>0 & grid_id==1, generate(cdf_e_self_treat_peak)

		sort cdf_e_self_control_peak cdf_e_self_treat_peak
		twoway (line cdf_e_self_control_peak e_self_tot if treat==0 & surv_el==1 & sample_spillover==1 & grid_id==1, lpattern(dash) lcolor(green)) (line cdf_e_self_treat_peak e_self_tot if treat==1 & surv_el==1 & sample_spillover==1 & grid_id==1, lcolor(red)), ytitle("Fraction") legend(order(1 "Control villages" 2 "Treatment villages")) xlabel(0(1)7)
		graph export "$dir_output/rationing_fig4_4B.pdf", replace 	
		ksmirnov e_self_tot if surv_el==1 & sample_spillover==1 & peak==1 & avg_eself_ctrl>0 & grid_id==1, by(treat)
