/**************************************************************************
Program:		PUBH 620 - In class SAS Labs 4 & 5 - PART 1
Programmer:		Sophia Newcomer (updated by Alexandria Albers)

Purpose:		In this code, we will create 
				SAS formats that need to be used with the NIS-Teen dataset.


Date created:	15 OCT 2019
Last modified:	3 October 2023


TASKS

				Task 1: Check that everyone has files uploaded to their SAS

				Task 2: Discuss the National Immunization Survey (NIS) Data
										
				Task 3: Look where we can actually find these data
						https://www.cdc.gov/vaccines/imz-managers/nis/data-tables.html
				
				Task 4: Go over some notes about the dataset
				
						The nisteenpuf17_P dataset is the NIS-Teen 2017 Public Use File (PUF) dataset,
						limited to survey data with provider-verified immunization data.  Dr. Newcomer 
						created this dataset by importing the NIS-Teen 2017 PUF and limiting the dataset
						to observations where PDAT2=1.  

						CDC reporting of NIS-Teen data also only uses survey data with provider-verified
						immunization data. Therefore, our coverage metrics should align with what CDC
						has reported. 

						CDC MMWR Report on adolescent vaccine coverage from NIS-Teen 2017:
						https://www.cdc.gov/mmwr/volumes/67/wr/mm6733a1.htm

						Interactive tools to examine adolescent vaccine coverage by year and by state are
						available here:
						https://www.cdc.gov/vaccines/imz-managers/coverage/teenvaxview/index.html
				
				Task 5: Let's Look at our dataset (after you run your libname statement)
				
				
				

*****************************************************************************/

proc contents data=pubh620.nisteenpuf17_p;
run;

/* Note: _p in the dataset name is Dr. Newcomer's way of saying it's already selected for */
/* provider verified records */

