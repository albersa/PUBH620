/**********************************************************************************
Program:		
Programmer:		
Library(ies):	
Created:		
Last modified:	

Notes about dataset:	In this SAS lab, we will work with a dataset called birthweight
						provided by SAS.  A data dictionary for this dataset is in the SAS Lab 2 Git Hub
						folder (.docx)

						During the first lab, we learned how to set up a library to access
						an existing a SAS dataset, and to examine the frequency of values
						for a given variable using PROC FREQ.

									

Coding Agenda:          Task 1: Review what we know about SAS so far!
						Task 2: Upload birthweight dataset and set library 
						Task 3: Examine cross-tabulations of categorical variables & go over interpretting output tables 
						Task 4: Examine distributions of continuous variables 
						Task 5: Learn to make new variables with if/else/if/then
						


***********************************************************************************
Task 1: REVIEW!
***********************************************************************************



***********************************************************************************
Task 2:
--upload birthweight dataset
--set library/libname statement
--let's look at contents of dataset and get oriented with it
***********************************************************************************/


/*Look at the contents of this dataset*/
proc contents data=pubh620.birthweight;
run;

/*Let's look at the frequency of variables in this dataset*/
/*Data dictionary has been posted SAS Lab 2 in Git Hub*/
title "SAS BWeight Dataset - Frequency of all variables ";
proc freq data=pubh620.birthweight;
tables black boy cigsperday married momage momedlevel momsmoke momwtgain visit weight;
run;
title;




*TASK 3******************************************************************************/
*Examine the frequency of a categorical variable, by levels of another categorical variable;
proc freq data=pubh620.birthweight;
tables MomSmoke;
run;

proc freq data=pubh620.birthweight;
tables Married;
run;

proc freq data=PUBH620.birthweight;
tables MomSmoke*Married / nopercent norow;
run;
*Review & interpret data in the table;


*one option is "by", by will group the data.. let's try...;
proc freq data=pubh620.birthweight;
tables Married;  
by momage;
run;


*when using "by", you have to sort first!;
proc sort data=pubh620.birthweight;
by momage;
run;
*now, rerun the by momage code above;


*Chi-square test;
*let's remind ourselves what we're asking in a chi-square
helpful online tutorial if anyone is interested: https://libguides.library.kent.edu/SAS/ChiSquare

Basically, we are asking if categorical variables are independent or not of each other, or 
are they associated with each other or not? 
H0 (null hypothesis): They are independent of each other (they are not associated)
Ha (alt hypothesis): They are not independent of each other (they are associated)

So, based on the code below, before we run, let's think about what we're asking;

proc freq data=PUBH620.birthweight;
tables MomAge*Married / chisq;
run;





/*TASK 4: Examine frequency of continuous variables **********************************/
proc means data=PUBH620.birthweight n min p5 median p95 max maxdec=2;
var momage;
run;
/*Discuss PROC MEANS options & look up what these are */
/*Show maxdec= option and various statistics options*/

*how would you do confidence intervals of the mean?
https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/proc/n1qnc9bddfvhzqn105kqitnf29cp.htm
https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/proc/n0e7mvoduvjxnzn1sffzxndxa03n.htm
;

proc means data=PUBH620.birthweight [???];
var momage;
run;


*Examine frequency of a continuous variable, by levels of categoricalvariable;
title "SAS BWeight Dataset - Distribution of mother's age, by marital status";
proc means data=PUBH620.birthweight;
class married;
var momage;
run;
title;
*why don't we use proc freq?;




/*TASK 5:  Subset and Make new variables within a SAS dataset**************************************************/


*Subset a dataset -- I want to only look at data on births of male children;
data male;
set PUBH620.birthweight;
where boy=1; *1=boy, 0=girl;
run;

*Does the TEST.male dataset have the number of obs that we expect?;
proc freq data=PUBH620.birthweight;
tables boy;
run;


*Make a new variable.
Goal: Categorize cigarettes per day;

*First, examine the variable*;
proc freq data=PUBH620.birthweight;
tables cigsperday;
run;


*Let's use if/else/if statements to do this (other option called if/then statements, 
but in if/then statements, SAS will look at ALL lines of code 
to see if any conditions are met. But if/else/if statements, once a condition is met, 
then it will stop looking);


*Make categories in a new variable; 
/* a format statement is good when you are making categorical variables */
/* You use format to set how wide the variable will be bc otherwise SAS */
/* will only fit the variable width to that first new category */
data bweight2;
	format cigsperday_cat $25.; 
	set PUBH620.birthweight;
	if cigsperday=0 then cigsperday_cat="0 cigarettes";
		else if cigsperday <= 10 then cigsperday_cat="1-10 cigarettes";
		else if cigsperday <= 20 then cigsperday_cat="11-20 cigarettes";
		 	else cigsperday_cat="21 or more cigarettes";
run;

*Note: can use <= or LE in code;



*Examine new variable;
proc freq data=bweight2;
tables cigsperday_cat;
run;

*Examine new variable in relation to old variable;
proc freq data=bweight2;
tables cigsperday*cigsperday_cat/ list;
run;



