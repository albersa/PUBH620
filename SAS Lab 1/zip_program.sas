/**********************************************************************************
Program:		Zip dataset for RDC (focus on RUCA categorization)
Programmer:		Alexandria N Albers
Library(ies):	ruca
Created:		26 June 2023
Last modified:	26 June 2023

Notes:			The dataset of interest is called zip. Within this dataset we have a
				-5 digit zip code variable
				-a primary ruca code variable (1-10 codes, whole numbers)
				-a secondary ruca code variable (1-10 with decimals)
				-a ruca4 variable (4 levels of ruca codes: 
										1=metro, 
										2=large rural city/town or micropolitan
										3=small rural town
										4=isolated small rural town
										99=not coded, census tract had 0 for pop.)

***********************************************************************************/

title "category exploration";
proc freq data=ruca.zip;
tables ruca_primary ruca_secondary ruca4;
run;


/* Note 1: 
numbers check out re: categories for ruca4, ruca1 n= 25255, ruca2 n=5425, ruca3 n=3780,
ruca4 n=6684 */



/* Note 2: 
number of zip codes, n=41164 (denominator for next part). Based on this... percentages should equal around */
/* ruca category 1 (metro) = 61.4%, ruca category 2 ("micro") = 13.2%, ruca cateogry 3 (small rural) = 9.2%, */
/* ruca category 4 (isolated small rural) = 16.2 %, & 99 (no data) = 0.05% */



/* Note 3: 
not all secondary codes had population associated with it, so 4.2, 5.2, 6.1, 7.3, 7.4, 8.3, 8.4,
9.1,9.2,10.4,10.5,10.6 are all 0. */



