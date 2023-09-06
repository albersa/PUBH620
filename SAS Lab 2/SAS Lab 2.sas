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

						During SAS Lab 2 , we will explore the BWEIGHT dataset and: 
					- Examine cross-tabulations of categorical variables  
					- Examine distributions of continuous variables 
					- Learn to make new variables, including applying IF/THEN/ELSE logic  

					We will also review the differences between temporary and permanent SAS datasets 
									
										

Coding Agenda:          Task 1: Review what we know about SAS so far!
						Task 2: Upload birthweight dataset and set library 
						Task 3: Examine cross-tabulations of categorical variables & go over interpretting output tables 
						Task 4: Examine distributions of continuous variables 
						Task 5: Learn to make new variables, including applying IF/THEN/ELSE logic
						


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
tables Married / nocum;    *no cumulative percent/frequency;
run;

proc freq data=PUBH620.birthweight;
tables MomSmoke*Married / nopercent norow;
run;
*Review & interpret data in the table;
*Discuss SAS options in PROC FREQ;


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


*I don't like the way momage is displayed.  I would prefer to just have the actual
age.  This is one way to make a new variable.;
data TEST;
set PUBH620.birthweight;
NEW_MomAge = Momage + 30;
run;
*where is the TEST dataset?;


proc means data=TEST;
var NEW_Momage;
run;

/***********************************************************
PAUSE
In class exercise:  Write code to examine distribution of 
- mother's wt gain
- mother's wt gain by child's sex
- chi-square test of mother's weight gain and child's sex

on your own
***********************************************************/











/*TASK 5:  Make new variables within a SAS dataset**************************************************/
data TEST;
set PUBH620.birthweight;
Example_Variable="This is an example of making a new variable in a SAS dataset";
Example_Num=100;
run;

proc freq data=TEST;
tables example_variable example_num;
run;

*Subset a dataset -- I want to only look at data on births of male children;
data male;
set PUBH620.birthweight;
WHERE boy=1; *1=boy, 0=girl;
run;

*Does the TEST.male dataset have the number of obs that we expect?;
proc freq data=PUBH620.birthweight;
tables boy;
run;

options obs = 5;
proc print data=PUBH620.birthweight;
run;
options obs=max;

*Make a new variable.
Goal: Categorize cigarettes per day;

*First, examine the variable*;
proc freq data=PUBH620.birthweight;
tables cigsperday;
run;


/* Note: if you use if then statements and have multiple, SAS code */
/* will look at ALL of them to see if any conditions are met. However, if you use  */
/* if else if statements, once a condition is met, then it will stop looking.  */


*Then, make categories in a new variable; 
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

*This would give you the same result:;
data TEST;
	format cigsperday_cat $25.;
	set PUBH620.birthweight;
	if cigsperday=0 then cigsperday_cat="0 cigarettes";
		else if cigsperday le 10 then cigsperday_cat="1-10 cigarettes";
		else if cigsperday le 20 then cigsperday_cat="11-20 cigarettes";
		 	else cigsperday_cat="21 or more cigarettes";
run;



*Examine new variable;
proc freq data=bweight2;
	tables cigsperday_cat;
run;

*Examine new variable in relation to old variable;
proc freq data=bweight2;
	tables cigsperday*cigsperday_cat/ list;
run;

/***********************************************************
PAUSE
In class exercise:  Write code to categorize infant
birth weight by a standard classification system (hint: look at your proc
freq and proc means to help decide how to categorize!)

on your own
***********************************************************/

