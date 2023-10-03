/******************************************************************************************** 
Program:		PUBH 620 - In class SAS Labs 4 & 5 - PART 3

Programmer:		Sophia Newcomer (updated by Alexandria Albers)

Purpose:		Examine and analyze 2017 National Immunization Survey (NIS)- Teen data 

Created:		15 OCT 2019
Last modified:	3 October 2023

Notes:			The nisteenpuf17_P dataset is the NIS-Teen 2017 Public Use File (PUF) dataset,
				limited to survey data with provider-verified immunization data.  I created
				this dataset by importing the NIS-Teen 2017 PUF and limiting the dataset
				to observations where PDAT2=1.  

				CDC reporting of NIS-Teen data also only uses survey data with provider-verified
				immunization data.  Therefore, our coverage metrics should align with what CDC
				has reported. 

				CDC MMWR Report on adolescent vaccine coverage from NIS-Teen 2017:
				https://www.cdc.gov/mmwr/volumes/67/wr/mm6733a1.htm

				Interactive tools to examine adolescent vaccine coverage by year and by state are
				available here:
				https://www.cdc.gov/vaccines/imz-managers/coverage/teenvaxview/index.html
								
************************************************************************************************/

*What variables are in the NIS-Teen dataset?;
proc contents data=PUBH620.nisteenpuf17_P;
run;
*So many variables! What fun!;
*Note that every variable has a format;

/******************************************************************************
For this lab, and for the class project, we are going to focus on HPV vaccine series
initiation, specifically, this variable: 

P_UTDHPV:		UP-TO-DATE FLAG (PROV INFO): 1+ HUMAN PAPILLOMAVIRUS SHOT, 
				EXCLUDING ANY VACCINATIONS AFTER THE RDD INTERVIEW DATE.

********************************************************************************/


*Examining HPV vaccine series initiation;
title1 "UNADJUSTED HPV Vaccine Series Inititation Prevalence";
title2 "This is the wrong way to analyze this data source";
title3 "because I am not accounting for the complex survey design";
proc freq data=PUBH620.nisteenpuf17_P;
tables P_UTDHPV / missing ;
run;
title;

/* missing option: PROC FREQ treats missing BY variable values  */
/* like any other BY variable value. The missing values form a  */
/* separate BY group. If an observation has a missing value for  */
/* a variable in a TABLES request, by default PROC FREQ does  */
/* not include that observation in the frequency or crosstabulation  */
/* table. Also by default, PROC FREQ does not include observations  */
/* with missing values in the computation of percentages and statistics.  */
/* The procedure displays the number of missing observations following  */
/* each table. */



*Pause and discuss orienting yourself with the public dataset you are working with;
*MMWR with results from NIS-Teen 2017:
https://www.cdc.gov/mmwr/volumes/67/wr/mm6733a1.htm;


title1 "National HPV Vaccine Series Initiation Prevalence";
title2 "correctly accounting for complex survey design";
proc surveyfreq data=PUBH620.nisteenpuf17_P;
	strata stratum;   
	cluster seqnumt;
	tables P_UTDHPV;
	WEIGHT PROVWT_D;
run;
title;
*How did I know to use all these options?  The NIS-Teen Data User's Guide:
https://www.cdc.gov/vaccines/imz-managers/nis/downloads/NIS-PUF17-DUG.pdf; 


/*************************************************** 

Now, we want to compare characteristics of
Montana adolescents who did and did not initiate the
HPV vaccine series.
***************************************************/

*Which one is the right variable to use for state?;
proc freq data=PUBH620.nisteenpuf17_P;
	tables ESTIAPT17 EST_Grant STATE/missing;
run;

*After reading the DUG, I decide that STATE is the correct variable to use;


*Limit dataset to Montana;

data pubh620.mt_nisteen17;
	set PUBH620.nisteenpuf17_P;
	where STATE=XX;  /*?  What number do we need to use here?  Look at formats code!*/
run;

*Check that those other two location variables are for this dataset;
proc freq data=pubh620.mt_nisteen17;
	tables ESTIAPT17 EST_Grant/missing;
run;


*We have n=326 obs in this dataset.  Is this correct?  Check against TeenVaxView
https://www.cdc.gov/vaccines/imz-managers/coverage/teenvaxview/data-reports/index.html



*TASK 1:  What is the prevalence of HPV vaccine series initiation (P_UTDHPV)
among Montana adolescents ages 13-17 years?;

title1 "Montana HPV Vaccine Series Initiation Prevalence";
title2 "correctly accounting for complex survey design";
proc surveyfreq data= pubh620.mt_nisteen17;
	strata stratum;
	cluster seqnumt;
	tables P_UTDHPV / row;
	WEIGHT PROVWT_D;
run;
title;


*How to work with state data using the WHERE= statement in PROC SURVEYFREQ.
This is alternative to subsetting a dataset;


proc surveyfreq data=PUBH620.nisteenpuf17_P;
	where state=30;
	strata stratum;
	cluster seqnumt;
	tables P_UTDHPV / row;
	WEIGHT PROVWT_D;
run;

/* what are the values for r/e */
proc freq data=pubh620.mt_nisteen17;
	tables raceethk;
run;


*Is an adolescents' race/ethnicity associated with HPV vaccine series initiation?;
proc surveyfreq data=pubh620.mt_nisteen17;
	strata stratum;
	cluster seqnumt;
	tables raceethk*P_UTDHPV / col;
	WEIGHT PROVWT_D;
run;


*PAUSE to discuss chi-square tests;
*What is this chisq test I am requesting?  See documentation at:
https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_surveyfreq_a0000000221.htm;

*The null hypothesis for this test is that there is no association between the row and column variables;

proc surveyfreq data=pubh620.mt_nisteen17;
	strata stratum;
	cluster seqnumt;
	tables raceethk*P_UTDHPV / col chisq;
	WEIGHT PROVWT_D;
run;

*Look at your log! We didn't get the Rao-Scott chi-square test we wanted because we have a zero cell issue.
Therefore, let's look back at the formats code to figure out what the different values
for race/ethnicity mean, and recode;

data pubh620.mt_nisteen17;
	set pubh620.mt_nisteen17;
	*Race/ethnicity;
	if raceethk in (1,3,4) then race_eth="Hispanic, Non-Hispanic Black, Non-Hispanic but not 
											White or Black and multi-raceethk";
		else if raceethk=2 then race_eth="Non-Hispanic White";
		else race_eth="";

run;

*Check your new variable;
proc surveyfreq data=pubh620.mt_nisteen17;
strata stratum;
cluster seqnumt;
tables raceethk race_eth;
weight provwt_d;
run;


*I am using the col option to request colummn percentages.
When using the tables statement, and requesting a 2x2 cross tabulation with the variable1*variable2 
structure, the first variable will be the row variable and second variable is the column variable;
proc surveyfreq data=pubh620.mt_nisteen17;
	strata stratum;
	cluster seqnumt;
	tables race_eth*P_UTDHPV / chisq col;  *note this is using new variable;
	WEIGHT PROVWT_D;
run;


*Last thing!  Look at a continuous variable, age. 

If you do want to describe a the distribution of a continuous variable collected
with a complex survey design, you use PROC SURVEYMEANS, like this:;
proc surveymeans data=pubh620.mt_nisteen17;
	strata stratum;
	cluster seqnumt;
	var AGE;
	WEIGHT PROVWT_D;
run;

*If we want to look at a continuous variable BY a subpopulation (e.g., age by UTD), 
we can add the domain statement, first we have to sort by our variable
of interest for the subpopulation;
proc sort data=pubh620.mt_nisteen17;
	by P_UTDHPV;
run;


*The DOMAIN statement requests analysis for domains (subpopulations) in 
addition to analysis for the entire study population. It's different than using
a by statement because by will divide the data up and then analyze it
Helpul info re: domain
https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.4/statug/statug_surveymeans_syntax05.htm;
proc surveymeans data=pubh620.mt_nisteen17;
	domain P_UTDHPV;
	strata stratum;
	cluster seqnumt;
	var AGE;
	WEIGHT PROVWT_D;
run;

*If we were not using data collected using a complex survey design, 
we could use PROC TTEST to request a t-test to compare whether
the disribution of age was significanty different by P_UTDHPV.
However, a t-test option is not available in the SAS SURVEY procedures.
So, what you can do is run an unadjusted regression model, like this:;

proc surveyreg data=pubh620.mt_nisteen17;
	strata stratum;
	cluster seqnumt;;
	model P_UTDHPV=age;
	WEIGHT PROVWT_D;
run;

*We then look at the results from AGE in the Estimated Regression Coefficients
table.  Since the p-value (shown as Pr>[t]) is 0.1768, we conclude age was not
significantly different between adolescents who did and did not initiate the HPV
vaccine series;

*Want more info on this use of an unadjusted regression model in place of a t-test in
SAS?  Check out this SAS guidance:
http://support.sas.com/kb/34/607.html






