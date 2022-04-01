
/* This do file contains code that generates the appendix figures in "Labor Rationing" (Breza, Kaur & Shamdasani) */
	  
* Appendix Figure A.3. Average Hired Wage Employment Rate by Month
	use "./data/cleandata/rationing_worker.dta", clear

	bys month_el: gen month_el_uniq = _n==1
	sum avg_emanwage_month if month_el_uniq==1, d

	twoway bar avg_emanwage_month month_el if month_el_uniq==1, xlabel(1(1)12) ylabel(0(0.05)0.3) title("") ytitle("Average Hired Wage Employment") xtitle("") barwidth(0.8) xlabel(1 "Jan." 2 "Feb." 3 "Mar." 4 "Apr." 5 "May." 6 "Jun." 7 "Jul." 8 "Aug." 9 "Sep." 10 "Oct." 11 "Nov." 12 "Dec.")
	graph export rationing_appendix_fig3.pdf, replace 

* Appendix Figure A.4. Inverse Farm-Size Relationship
	use "./data/cleandata/rationing_worker.dta", clear 

	sum  bl_totalland_imp if grid_id==1 & surv_bl==1 & sample_signup==1, d
	lpoly lab_peracre_w bl_totalland_imp if grid_id==1 & surv_bl==1 & sample_signup==1 & bl_totalland_imp<=r(p99), ci noscatter cl(village) degree(2) xtitle("Acres") ytitle("Labor use per acre") title("")
	graph export rationing_appendix_fig4.pdf, replace 

* Appendix Figure A.5. Job take-up
	* Data for this figure comes from Breza, Emily, Supreet Kaur & Nandita Krishnaswamy. 2019. "Propping Up the Wage Floor: Collective Labor Supply without Unions." National Bureau of Economic Research Working Paper No. 25880
 	
* Appendix Figure A.6. India-wide Variation in Employment by District and Month

* Panel A: Average Casual Employment Across Districts
	use "./data/cleandata/rationing_nrega_worker.dta", clear
	keep if round==61
	keep if usualag==1
	drop if statename=="Andaman & Nicobar Islands" | statename=="Dadra & Nagar Haveli" | statename=="Daman & Diu" | statename=="Delhi" | statename=="Goa"

	collapse (sum) casual_days_Mult mult, by(round statename districtname)
	gen casual_days = casual_days_Mult/mult

	set scheme s1mono
	label var casual_days "Average Casual Days Worked (per week)"
	hist casual_days
	graph export rationing_appendix_fig6a.pdf, replace 

* Panel B: Percent Increase in Casual Employment from Lowest to Highest Month Across States
	use "./data/cleandata/rationing_nrega_worker.dta", clear
	keep if round==61
	keep if usualag==1
	drop if statename=="Andaman & Nicobar Islands" | statename=="Dadra & Nagar Haveli" | statename=="Daman & Diu" | statename=="Delhi" | statename=="Goa"
	drop if month==.

	collapse (sum) casual_days_Mult mult , by(statename month)

	gen casual_days = casual_days_Mult/mult	
	
	set scheme s1mono
	bysort statename : egen min_casdays = min(casual_days)
	bysort statename : egen max_casdays = max(casual_days)

	* Ratio: Maximal to Minimal Casual Employment by Month
	gen max_to_min_casdays = max_casdays / min_casdays

	gen perc_max_to_min_casdays = (max_to_min_casdays-1)
	gen perc_max_to_min_casdays_tc = perc_max_to_min_casdays
		sum perc_max_to_min_casdays, d 
		replace perc_max_to_min_casdays_tc = 5 if perc_max_to_min_casdays >=5 & perc_max_to_min_casdays!=.
	label var perc_max_to_min_casdays_tc "Percent Increase from Lowest to Highest Employment Month by State"

	hist perc_max_to_min_casdays_tc if month==1 & perc_max_to_min_casdays<10, width(0.4) xlabel(1 "100%" 2 "200%" 3 "300%" 4 "400%" 5 ">500%")
	graph export rationing_appendix_fig6b.pdf, replace 

* Appendix Figure A.7. Average Weekly Days in Public Works by Month
	use "./data/cleandata/rationing_nrega.dta", clear 
	keep if round==64 & NREGA==1
	drop if statename=="Andaman & Nicobar Islands" | statename=="Dadra & Nagar Haveli" | statename=="Daman & Diu" | statename=="Delhi" | statename=="Goa"
	keep if age>=16 & age<66
	gen public_Mult = pubworks_days * mult
		
	drop if month==.
	
	collapse (sum) public_Mult mult, by(month)	
	gen public_days = public_Mult/mult
	
	label define month 1 "Jan." 2 "Feb." 3 "Mar." 4 "Apr." 5 "May" 6 "Jun." 7 "Jul." 8 "Aug" 9 "Sep." 10 "Oct." 11 "Nov." 12 "Dec."
	label values month month
	sort month
	graph bar public_days, over(month) ytitle("Average Weekly Public Works Days")
	graph export rationing_appendix_fig7.pdf, replace 

