
/* -------------------------------------------------------------
	
	EC2 EMPRICAL EXERCISE

	Tejesh Pradhan 
 
	tpradhan@worldbank.org
		
	This version: May 18, 2021

 -------------------------------------------------------------*/ 
 
#delimit;
clear;
clear matrix;
set matsize 11000;
set more off;
capture log close;
set scheme plotplainblind;

global directory "C:\Users\wb514820\Downloads\EC2_empirical_exercise-master\";





/* ANS 2A */

import excel "$directory\01_rawdata\Zimbabwe_children_under5_interview.xlsx", sheet("Zimbabwe_children_under5_interv") firstrow clear;

tab1 EC*;


/* ANS 2B */

label define binary 1 "Yes" 0 "No";

foreach var of varlist EC* {;
recode `var' (2 8 9 = 0);
label values `var' binary;
};

tab1 EC* child_age_years;


/* ANS 2C */

local sumvars EC*;
eststo all: quietly estpost summarize `sumvars', detail;
eststo three: quietly estpost summarize `sumvars' if child_age_years == 3, detail;
eststo four: quietly estpost summarize `sumvars' if child_age_years == 4, detail;

esttab all three four using "$directory\Descriptive Statistics.csv", title(Summary statistics) label replace mtitle("All" "Three years old" "Four years old") cells("count(pattern(1 1) label(N)) mean(pattern(1 1) fmt(2) label(Mean)) p50(pattern(1 1) fmt(2) label(Median))") noobs;


/* ANS 2D */

egen index = rowmean(EC6-EC15);
label variable index "Index";


/* ANS 2E */

alpha EC6-EC15, reverse(EC10 EC14 EC15);
alpha EC6-EC15, reverse(EC10 EC14 EC15) item;


/* ANS 2F */

gen birthdate = date(child_birthday, "MDY");
format interview_date birthdate %td;

order birthdate, after(child_birthday);

gen age_mth = round((interview_date - birthdate)/(365/12));
label variable age_mth "Age at interview (Months)";

bys age_mth: egen mean_index = mean(index);
label variable mean_index "Average value of overall index (EC6-EC15) for across ages in months";

twoway (line mean_index age_mth, sort), ytitle(Index) xtitle(Age in months) title(Average value of overall index (EC6-EC15) for across ages in months);
graph export "$directory\line_mean_index_overall.png", replace;


/* ANS 2G */

gen index_math = EC8;
label variable index_math "Index - Math";

egen index_lit_math = rowmean(EC6-EC8);
label variable index_lit_math "Index - Literacy and Math";

egen index_phy = rowmean(EC9-EC10);
label variable index_phy "Index - Physical";

egen index_learn = rowmean(EC11-EC12);
label variable index_learn "Index - Learning";

egen index_socio = rowmean(EC13-EC15);
label variable index_socio "Index - Socio-emotional";


/* Summary for indices */

local indexvars index index_*;
eststo index_all: quietly estpost summarize `indexvars', detail;
eststo index_three: quietly estpost summarize `indexvars' if child_age_years == 3, detail;
eststo index_four: quietly estpost summarize `indexvars' if child_age_years == 4, detail;

esttab index_all index_three index_four using "$directory\Descriptive Statistics.csv", title(Summary statistics for child development indices) label append mtitle("All" "Three years old" "Four years old") cells("count(pattern(1 1) label(N)) mean(pattern(1 1) fmt(2) label(Mean)) p50(pattern(1 1) fmt(2) label(Median))") noobs;


/* Generate mean by age group */
foreach var of varlist index_math-index_socio {;
bys age_mth: egen mean_`var' = mean(`var');
};

label variable mean_index_math "Average value of math index (EC8) for across ages in months";
label variable mean_index_lit_math "Average value of literacy and math index (EC6-EC8) for across ages in months";
label variable mean_index_phy "Average value of physical index (EC9-EC10) for across ages in months";
label variable mean_index_learn "Average value of learning index (EC11-EC12) for across ages in months";
label variable mean_index_socio "Average value of socio-emotional index (EC13-EC15) for across ages in months";

foreach var of varlist mean_index_math-mean_index_socio {;
local varlabel: variable label `var';
twoway (line `var' age_mth, sort), ytitle(Index) xtitle(Age at interview (Months)) title(`varlabel');
graph export "$directory\line_`var'.png", replace;
};


/* ANS 2H */

foreach var of varlist index index_math-index_socio {;

replace `var' = `var' * 100;

eststo reg_`var': reg `var' age_mth, robust;

};

esttab reg_* using "$directory\Regression Results.csv", replace label title(Assocation between children's age and their development) compress collabels(none) nobase nolines nogaps mtitle("Overall" "Math" "Literacy and Math" "Physical" "Learning" "Socio-emotional") b(2) se(2) stats(N r2, fmt(0 2));





/* ANS 3 */

#delimit;
wbopendata, language(en - English) indicator(sh.sta.stnt.me.zs) clear long;
keep if (countryname == "Zimbabwe" | countryname == "Lower middle income" | countryname == "Sub-Saharan Africa");
keep countryname year sh_sta_stnt_me_zs;
compress;

label variable sh_sta_stnt_me_zs "Prevalence of stunting, height for age (% of children under 5)";

/* Series begins in 2000 */
keep if year >= 2000;

twoway (line sh_sta_stnt_me_zs year if country == "Zimbabwe")(line sh_sta_stnt_me_zs year if country == "Lower middle income")(line sh_sta_stnt_me_zs year if country == "Sub-Saharan Africa"), legend(order(1 "Zimbabwe" 2 "LMC" 3 "SSA")) title("Stunting in Zimbabwe, LMC and SSA") ytitle("Percent of children under 5");

graph export "$directory\line_stunting.png", replace;