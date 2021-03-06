cap label var vill1 "Unique village indicator"
cap label var uid1 "Unique worker indicator"
cap label var round1 "Unique experimental round indicator"

cap label var bl_valid_gridday "Valid grid day in baseline survey"

cap label var occup_anyfarm_nm "Occupation: Farm"

cap label var tot_hh_mem "Total HH members (age 12+)"
cap label var tot_hh_mem_m "HH Members (male, age 12+)"
cap label var tot_hh_mem_miss "Total HH members (age 12+) - missing indicator"
cap label var tot_hh_mem_nm "Total HH members (age 12+) - non missing"

cap label var hourlywagetot_w "Hourly total wage"
cap label var hours "Hours per day"

cap label var e_manwage "Hired wage employment"
cap label var e_manwage_tot "Hired wage employment"
cap label var e_manlab "Hired employment"
cap label var e_self "Self employment"
cap label var e_self_tot "Self employment"
cap label var e_selfnonagri "Self empl: non-agri"
cap label var e_selfagri "Self empl: agri"
cap label var e_wanted "Invol unempl (traditional)"
cap label var e_prefer "Invol unempl (alternate)"
cap label var e_worked "Any work"
cap label var e_publicworks "Public works employment"

cap label var self_tot "HH self employment"
cap label var farm_labor_tot "Total farm labor"
cap	label var lab_peracre_w "Labor use per acre (winsorized)"

cap label var gotdailywage "Received daily wage"
cap label var dailywagetot "Total wage"
cap label var ldailywagecash "Log cash wage"
cap label var ldailywagetot "Log total wage"
cap label var ldailywageink "Log in-kind wages"

cap label var dailywagetot_w "Total wage"
cap label var ldailywagecash_w "Log cash wage"
cap label var ldailywagetot_w "Log total wage"

cap label var emp_expect_work_days_w "Expected days of work"

cap label var peak "Semi-peak"
cap label define season 1 "Semi-peak" 0 "Lean"
cap label val peak season 

cap label var peakc "Empl. Level"
cap label var treat_peakc "Hiring Shock * Empl. Level"

cap label var treat_peak "Hiring shock * Semi-peak"
cap label var peak_nonsignup "Semi-peak * No sign up (NSU)"
cap label var treat_nonsignup "Hiring shock * No sign up (NSU)"
cap label var treat_nonsignup_peak "Hiring shock * Semi-peak * No sign up (NSU)"

cap label var frac_hired "Size of the hiring shock"
cap label var frac_signup "Fraction of sign-ups"
cap label var lf_estim "Estimated size of male casual labor force"

cap label var avg_eself_ctrl "Average self-emp in control village"
cap label var avg_eselfagri_ctrl "Average agri self-emp in control village"
cap label var avg_eselfnonagri_ctrl "Average non-agri self-emp in control village"
cap label var avg_emanwage_month "Average hired wage employment by month"

cap label var bl_partic "Ever participate in labor market"
cap label var bl_noland "Landless"
cap label var bl_totalland_imp "Total land owned at baseline (imputed)"
cap label var bl_totalland_imp_nm "Total land owned at baseline (imputed)"
cap label var bl_tot_hh_mem "HH Members (age 12+)"
cap label var bl_e_any "Any activity"
cap label var bl_e_manwage "Employment rate: Hired wage employment"
cap label var bl_dwagetot "Total wage (Rs.)"
cap label var bl_ldwagetot "Log total wage (Rs.)"
cap label var bl_e_publicworks "Public works employment"
cap label var bl_e_self "Self employment"
cap label var bl_daysworkfut30 "Days would like to work in labor market (in next 30 days)"

cap label var bl_noland_miss "Landless - missing indicator"
cap label var bl_e_manwage_miss "Employment rate: Hired wage employment - missing indicator"
cap label var bl_e_any_miss "Any activity - missing indicator"
cap label var bl_e_publicworks_miss "Public works employment - missing indicator"
cap label var bl_e_self_miss "Self employment - missing indicator"
cap label var bl_dwagetot_miss "Total wage (Rs.) - missing indicator"
cap label var bl_ldwagetot_miss "Log total wage (Rs.) - missing indicator"
cap label var bl_daysworkfut30_miss "Days would like to work in labor market (in next 30 days) - missing indicator"

cap label var bl_has_hhbiz "Has HH business"
cap label var bl_biznonagri "Has HH business (non-agri)"
cap label var bl_bizagri "Has HH business (agri)"
cap label var bl_bizagri_miss "Has HH business (agri) - missing indicator"
cap label var bl_biznonagri_miss "Has HH business (non-agri) - missing indicator"
cap label var bl_has_hhbiz_miss "Has HH business - missing indicator"

cap label var land_per_hh_mem_m "Land/HH Member (m, age 12+)"
cap label var landpermem_above "Above Median Land Per Capita"
cap label var treat_peak_landpermem_above "Hiring shock* Semi-peak * Above Median Land Per Capita"
cap label var treat_landpermem_above "Hiring shock * Above Median Land Per Capita"
cap label var peak_landpermem_above "Semi-peak * Above Median Land Per Capita"
cap label var treat_peak_landpermem_above "Hiring shock * Semi-peak * Above Median Land/HH Member"
cap label var treat_landpermem_m0 "Hiring shock * Landless"
cap label var treat_peak_landpermem_m0 "Hiring shock * Semi-peak * Landless"
cap label var peak_landpermem_m0 "Semi-peak * Landless"
cap label var landpermem_m0 "Landless"

cap label var bl_dwagetot_v "Total wage (Rs.) - village"	
cap label var bl_e_manwage_v "Employment rate: Hired wage employment - village"
cap label var bl_dwagetot_v_miss "Total wage (Rs.) - village - missing indicator"
cap label var bl_e_manwage_v_miss "Employment rate: Hired wage employment - village - missing indicator"
cap label var bl_weeklyearnings "Weekly wage earnings"

cap	label var bl_tot_hh_mem_miss "Total HH members (age 12+) at baseline - missing indicator"
cap	label var bl_tot_hh_mem_nm "Total HH members (age 12+) at baseline - non missing"

cap label var hh_m_self_emp "Self employment"

cap label var bl_partic "Ever participate in casual labor market"
cap label var bl_tot_hh_mem "HH members (age 12+)"

cap label var e_self_hours "Self emp"
cap	label var e_selfagri_hours "Self: agri"
cap	label var e_selfnonagri_hours "Self: non-agri"

cap	label var rating_mean "Worker Rating"

cap	label var treat "Hiring shock"
cap	label var treat_peak "Hiring shock * Semi-peak"
cap	label var e_self "Self employment"
cap	label var e_worked "Any work"
cap	label var e_publicworks "Public works employment" 

cap	label var frac_nonsignups_survey "Share of Non Sign-Ups Surveyed"

cap	label var rating_std "Worker rating standardised by lean period in spillover sample"
cap	label var rating_std_miss "Worker rating standardised by lean period in spillover sample - missing indicator"
cap	label var bl_dwagetot_std "Total wage standardised by lean period in spillover sample"
cap	label var bl_dwagetot_std_miss"Total wage standardised by lean period in spillover sample - missing indicator"
cap	label var bl_e_manwage_std "Empl. rate standardised by lean period in spillover sample"
cap	label var bl_e_manwage_std_miss "Empl. rate standardised by lean period in spillover sample"

cap	label var peak_rating_std "Worker rating * Semi-peak"
cap	label var treat_rating_std "Worker rating * Hiring shock"
cap	label var treat_peak_rating_std "Worker rating * Semi-peak * Hiring shock"
cap	label var peak_rating_std_miss "Worker rating * Semi-peak - missing indicator"
cap	label var treat_rating_std_miss "Worker rating * Hiring shock - missing indicator"
cap	label var treat_peak_rating_std_miss "Worker rating * Semi-peak * Hiring shock - missing indicator"
cap	label var treat_bl_dwagetot_std "Total wage * Hiring shock"
cap	label var treat_peak_bl_dwagetot_std "Total wage * Semi-peak * Hiring shock"
cap	label var peak_bl_dwagetot_std "Total wage * Semi-peak"
cap	label var treat_bl_dwagetot_std_miss "Total wage * Hiring shock - missing indicator"
cap	label var peak_bl_dwagetot_std_miss "Total wage * Semi-peak - missing indicator"
cap	label var treatpeak_bl_dwagetotstd_miss "Total wage * Semi-peak * Hiring shock- missing indicator"
cap	label var treat_bl_e_manwage_std "Empl. rate * Hiring shock"
cap	label var treat_peak_bl_e_manwage_std "Empl. rate * Semi-peak * Hiring shock"
cap	label var peak_bl_e_manwage_std "Empl. rate * Semi-peak"
cap	label var treat_bl_e_manwage_std_miss "Empl. rate * Hiring shock - missing indicator"
cap	label var peak_bl_e_manwage_std_miss "Empl. rate * Semi-peak - missing indicator"
cap	label var treatpeak_bl_emanwagestd_miss "Empl. rate * Semi-peak * Hiring shock - missing indicator"

