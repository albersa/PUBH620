/**********************************************************************************
Program:		
Programmer:		
Library(ies):	
Created:		
Last modified:	

Notes about dataset:	The dataset of interest is called echbarriers which stands for early childhood
						barriers. The numbers are not real, these are made up. 
						The datasete represents how providers (fake providers) answered on a scale of 
						major barrier (1) to not at all a barrier (5) or idk/na (6) for 6 different
						provided barriers to early childhood vaccinations
						Within this dataset we have a
						-unique_ID
						-barrier1-barrier6 variables
						-geographical variable msa (work within an msa or nonmsa)
									
										

Coding Agenda:          Task 1: Look at contents of dataset
						Task 2: Examine the frequency of a categorial variable
						Task 3: Examine the frequency of a categorial variable, by levels of another categorical variable
						Task 4: Examine the frequency of continuous variable
						Task 5: Examine frequency of a continuous variable, by levels of another variable
						Task 6: Make new variables within a SAS dataset
					

***********************************************************************************/


*A note about comments
See how this code is in green?  I am making a comment in my code.  Comments are a great way
for a programmer to make notes on what they are doing when coding.  SAS ignores comments
when running code. Use comments frequently when you code!


There are two ways to make a comment in SAS
Method 1 - everything between a front slash-star and a star-front slash is a comment
Can do this easily by highlighting text to comment out, and Ctrl + / for Windows and Command + / on Mac

Method 2 - everything between a star and a semicolon is a comment;

****************************************************************************************


Overview of coding structure in SAS
	A SAS Program is just a sequence of steps that start with procedure and data commands
	-procedure commands (start with proc)
	-data commands (start with data)
	
	procedure commands usually report about the data, manage the data, or analyze the data
	without changing the data
	
	data commands read, process, or create data - usually a data manipulation

And as we said, programs start with proc or data, they end with run; *(some procedures will end with quit)
Exceptions to ending with run; *are global statements that are outside of proc or data steps, including title, options,
and libname

procedure options:
proc print
proc contents
proc freq (frequency)
proc means



Generally, you need a starting statement (proc or data)
then you have to tell SAS what data to look at including within what library
and then to run the code;


****************************************************************************************

TASK 1:  Let's look at the contents of this dataset!;

proc print data=pubh620.echbarriers (obs=20);
run;


proc contents data=pubh620.echbarriers;
run;



/*TASK 2:  Examine frequency of categorical variables*/
proc freq data=pubh620.echbarriers;
tables msa;
run;

proc freq data=pubh620.echbarriers;
tables barrier1;
run;

proc freq data=pubh620.echbarriers;
tables barrier2;
run;



/***********************************************************
PAUSE
In class exercise:  Write code to examine frequency of
- barrier3, barrier4, barrier6

on your own
***********************************************************/

/* bonus code! */
proc freq data=pubh620.echbarriers;
tables barrier1-barrier6;
run;



/*TASK 3*/
*Examine the frequency of a categorial variable, by levels of another categorical variable;

proc freq data=pubh620.echbarriers;
tables barrier1 * msa ;
run;

/* same thing, but let's add a title */
title "barrier1 by msa status";
proc freq data=pubh620.echbarriers;
tables barrier1 * msa ;
run;
title;



/*TASK 4: Examine frequency of continuous variables */
/* Here, we will treat unique_id like "continuous variable" just to get experience */
proc means data=pubh620.echbarriers;
var unique_id;
run;


title "Distribution of unique ID";
proc univariate data=pubh620.echbarriers;
var unique_id;
run;
title;


*Task 5: Examine frequency of a continuous variable, by levels of another variable;

proc means data=pubh620.echbarriers;
class msa;
var unique_id;
run;


/***********************************************************
PAUSE
In class exercise:  Write code to examine distribution of 
- unique ID by barrier1

on your own
***********************************************************/




*Let's try some data steps that change/alter datset;

/*TASK 6:  Make new variables within a SAS dataset*/
data TEST;
set pubh620.echbarriers;
Example_Variable="This is one example of making a new variable in a SAS dataset";
run;

*Where is new dataset test? Let's discuss this;



*Let's say we want to create a flag for barrier6 because it is the barrier that asks about vaccine hesitancy.
*If a provider agreed it was a major or somewhat of a barrier, we want them to be "flagged" 
*how to think about this?
*write out your logic!

*So, if barrier6 answers are a 1 or a 2 then that provider gets a flag (or a 1), otherwise the provider gets a 0 (not flagged);


data pubh620.echbarriers;
set pubh620.echbarriers;
if barrier6=1 then hesitancy_flag=1;
else if barrier6= 2 then hesitancy_flag=1;
else if barrier6 > 2 then hesitancy_flag=0;  *let's discuss the logic of these statements;
else hesitancy_flag=0;
run;

*always check your data steps!;
proc freq data=pubh620.echbarriers;
tables barrier6 hesitancy_flag;
run;


*Options to create character variable from numerical;
data pubh620.echbarriers;
set pubh620.echbarriers;
if barrier6=1 then hesitancy="Yes";
else if barrier6= 2 then hesitancy="Yes";
else if barrier6 > 2 then hesitancy="No";
else hesitancy="No";
run;

*how would you examine this?;
proc freq data=pubh620.echbarriers;
tables barrier6 hesitancy_flag hesitancy;
run;



*shortcut! for if statements (AA to show example);





/***********************************************************
PAUSE
In class exercise:  check that your shortcut code worked using
proc freq
on your own
***********************************************************/



/***********************************************************
In class exercise:  create a new variable for barrier3 which
creates flags if the provider answered either 3(neutral) or 6(n/a) 
for barrier3 and check your work!
***********************************************************/
