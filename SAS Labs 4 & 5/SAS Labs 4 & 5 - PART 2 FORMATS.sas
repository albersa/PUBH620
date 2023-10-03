/**************************************************************************
Program:		PUBH 620 - In class SAS Labs 4 & 5 - PART 2
Programmer:		Sophia Newcomer (updated by Alexandria Albers)

Purpose:		In this code, we will create 
				SAS formats that need to be used with the NIS-Teen dataset.


Date created:	15 OCT 2019
Last modified:	3 October 2023

Notes			Let's talk about formats! (Note: there is a PowerPoint presentation
				uploaded on Moodle about formats)
				
				Basically, we have talked about formatting the data in our variables
				We can tell SAS the number of decimal points, the column width or how many
				numbers/values the variable can have, we often formate dates in SAS 
				
				Other ways to think about formatting is asking SAS to format how the 
				output looks - like how your labels on your variables look.
				
				For example, instead of just getting output with a table that is
				labeled 0,1 - we could have SAS tell us what 0 and 1 mean in our output.
				Like not up to date on vacciation (0), up to date on vaccination (1). 
				
				NIS data provides us code to run formats for data analysis
					
				We can find this step in the formats.sas7bcat file downloaded from GitHub
				
				
				
				*One last note about formats before we create formats:
				-->There is a way to create permanent formats so that we can point to them in 
				our SAS code, and therefore, you do not have to recreate formats each time. However,
				for our purposes we will not be creating permanent formats. 
				
			

*****************************************************************************/
*You WILL HAVE TO DO THIS STEP EVERY TIME 
YOU ANALYZE NIS TEEN DATA! (which includes analyzing data for your project);

/**************************************************************************/
/* Step 1:   HAVE YOU SET YOUR LIBRARY?                                   */
/**************************************************************************/

/**************************************************************************/
/* Step 2:   Alexandria to demo code without formats from part 3          */
/**************************************************************************/


/**************************************************************************/
/* Step 3:   CREATE FORMATS                                               */
/**************************************************************************/

PROC FORMAT; 
value ADEQ
. = "MISSING"
1 = "TEEN HAS ADEQUATE PROVIDER DATA"
2 = "TEEN DOES NOT HAVE ADEQUATE PROVIDER DATA"
;
value AGEGRP_M
. = "MISSING"
1 = "<= 34 YEARS"
2 = "35 TO 44 YEARS"
3 = ">= 45 YEARS"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value C1R
. = "MISSING"
1 = "1"
2 = "2"
3 = "3"
4 = "4"
5 = "5"
6 = "6"
7 = "7"
8 = "8+"
;
value C5R
. = "MISSING"
1 = "MOTHER (STEP, FOSTER, ADOPTIVE) OR FEMALE GUARDIAN"
2 = "FATHER (STEP, FOSTER, ADOPTIVE) OR MALE GUARDIAN"
3 = "GRANDPARENT"
4 = "OTHER FAMILY MEMBER/FRIEND"
77 = "DON'T KNOW"
99 = "REFUSED"
;
value CENREG
. = "MISSING"
1 = "NORTHEAST"
2 = "MIDWEST"
3 = "SOUTH"
4 = "WEST"
;
value CHILDNMF
. = "MISSING"
1 = "ONE"
2 = "TWO OR THREE"
3 = "FOUR OR MORE"
77 = "DON'T KNOW"
99 = "REFUSED"
;
value CKUPLAST
. = "MISSING"
1 = "MORE THAN (AGE - 12) YEARS AGO"
2 = "EXACTLY (AGE - 12) YEARS AGO"
3 = "LESS THAN (AGE - 12) YEARS AGO"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value CONSENT
. = "MISSING"
1 = "CONSENT GIVEN"
2 = "CONSENT DENIED"
;
value CPOX_R
. = "MISSING"
1 = "LESS THAN 1 YEAR OLD"
2 = "1 TO 5 YEARS OLD"
3 = "5 TO 10 YEARS OLD"
4 = "MORE THAN 10 YEARS OLD"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value D6R
. = "MISSING"
0 = "0"
1 = "1"
2 = "2"
3 = "3+"
;
value EDUC4_M
. = "MISSING"
1 = "LESS THAN 12 YEARS"
2 = "12 YEARS"
3 = "MORE THAN 12 YEARS, NON-COLLEGE GRAD"
4 = "COLLEGE GRADUATE"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value EDUC_TR
. = "MISSING"
1 = "6TH TO 8TH GRADE"
2 = "9TH TO 12TH GRADE"
3 = "HS GRAD/GED COMPLETED/ENROLLED IN GED PROGRAM"
4 = "NOT IN SCHOOL/OTHER"
77 = "DON'T KNOW"
99 = "REFUSED"
;
value ESTGRANTF
. = "MISSING"
1 = "CT"
2 = "MA"
4 = "ME"
5 = "NH"
6 = "RI"
7 = "VT"
8 = "NJ"
10 = "NY-REST OF STATE"
11 = "NY-CITY OF NEW YORK"
12 = "DC"
13 = "DE"
14 = "MD"
16 = "PA-REST OF STATE"
17 = "PA-PHILADELPHIA COUNTY"
18 = "VA"
19 = "WV"
20 = "AL"
22 = "FL"
25 = "GA"
27 = "KY"
28 = "MS"
29 = "NC"
30 = "SC"
31 = "TN"
34 = "IL-REST OF STATE"
35 = "IL-CITY OF CHICAGO"
36 = "IN"
38 = "MI"
40 = "MN"
41 = "OH"
44 = "WI"
46 = "AR"
47 = "LA"
49 = "NM"
50 = "OK"
51 = "TX-REST OF STATE"
54 = "TX-CITY OF HOUSTON"
55 = "TX-BEXAR COUNTY"
56 = "IA"
57 = "KS"
58 = "MO"
59 = "NE"
60 = "CO"
61 = "MT"
62 = "ND"
63 = "SD"
64 = "UT"
65 = "WY"
66 = "AZ"
68 = "CA"
72 = "HI"
73 = "NV"
74 = "AK"
75 = "ID"
76 = "OR"
77 = "WA"
;
value ESTIAPT17F
. = "MISSING"
1 = "CT"
2 = "MA"
4 = "ME"
5 = "NH"
6 = "RI"
7 = "VT"
8 = "NJ"
10 = "NY-REST OF STATE"
11 = "NY-CITY OF NEW YORK"
12 = "DC"
13 = "DE"
14 = "MD"
16 = "PA-REST OF STATE"
17 = "PA-PHILADELPHIA COUNTY"
18 = "VA"
19 = "WV"
20 = "AL"
22 = "FL"
25 = "GA"
27 = "KY"
28 = "MS"
29 = "NC"
30 = "SC"
31 = "TN"
34 = "IL-REST OF STATE"
35 = "IL-CITY OF CHICAGO"
36 = "IN"
38 = "MI"
40 = "MN"
41 = "OH"
44 = "WI"
46 = "AR"
47 = "LA"
49 = "NM"
50 = "OK"
51 = "TX-REST OF STATE"
52 = "TX-DALLAS COUNTY"
53 = "TX-EL PASO COUNTY"
54 = "TX-CITY OF HOUSTON"
55 = "TX-BEXAR COUNTY"
56 = "IA"
57 = "KS"
58 = "MO"
59 = "NE"
60 = "CO"
61 = "MT"
62 = "ND"
63 = "SD"
64 = "UT"
65 = "WY"
66 = "AZ"
68 = "CA"
72 = "HI"
73 = "NV"
74 = "AK"
75 = "ID"
76 = "OR"
77 = "WA"
95 = "U.S. VIRGIN ISLANDS"
105 = "GUAM"
106 = "PUERTO RICO"
108 = "TX-TRAVIS COUNTY"
;
value FACILSUM
. = "MISSING"
1 = "ALL PUBLIC FACILITIES"
2 = "ALL HOSPITAL FACILITIES"
3 = "ALL PRIVATE FACILITIES"
4 = "ALL STD/SCHOOL/TEEN CLINICS OR OTHER FACILITIES"
5 = "MIXED"
6 = "UNKNOWN"
;
value HHCOUNT
. = "MISSING"
50 = "ALL SHOTS"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value HVSTS
. = "MISSING"
1 = "NONE"
2 = "1"
3 = "2 - 3"
4 = "4 - 5"
5 = "6 - 7"
6 = "8 - 9"
7 = "10 - 12"
8 = "13 - 15"
9 = "16+"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value INCPOV
. = "MISSING"
1 = "ABOVE POVERTY > $75K"
2 = "ABOVE POVERTY <= $75K"
3 = "BELOW POVERTY"
4 = "UNKNOWN"
;
value INCQ298A
. = "MISSING"
3 = "$0 - $7500"
4 = "$7501 - $10000"
5 = "$10001 - $17500"
6 = "$17501 - $20000"
7 = "$20001 - $25000"
8 = "$25001 - $30000"
9 = "$30001 - $35000"
10 = "$35001 - $40000"
11 = "$40001 - $50000"
12 = "$50001 - $60000"
13 = "$60001 - $75000"
14 = "$75001+"
77 = "DON'T KNOW"
99 = "REFUSED"
;
value INS_BREAK_I
. = "MISSING"
1 = "CURRENTLY INSURED BUT UNINSURED AT SOME POINT SINCE AGE 11"
2 = "CURRENTLY INSURED AND NEVER UNINSURED SINCE AGE 11"
3 = "CURRENTLY UNINSURED BUT INSURED AT SOME POINT SINCE AGE 11"
4 = "CURRENTLY UNINSURED AND NEVER INSURED SINCE AGE 11"
;
value INS_STAT2_I
. = "MISSING"
1 = "PRIVATE INSURANCE ONLY"
2 = "ANY MEDICAID"
3 = "OTHER INSURANCE"
4 = "UNINSURED"
;
value LANGUAGE
. = "MISSING"
1 = "ENGLISH"
2 = "SPANISH"
3 = "OTHER"
;
value LIKELY
. = "MISSING"
1 = "VERY LIKELY"
2 = "SOMEWHAT LIKELY"
3 = "NOT TOO LIKELY"
4 = "NOT LIKELY AT ALL"
77 = "NOT SURE/DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value MAR_PUF2_
. = "MISSING"
1 = "MARRIED"
2 = "NEVER MARRIED/WIDOWED/DIVORCED/SEPARATED/DECEASED/LIVING WITH PARTNER"
;
value MOBIL
. = "MISSING"
1 = "MOVED FROM DIFFERENT STATE"
2 = "DID NOT MOVE FROM DIFFERENT STATE"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value MONTHF
. = "MISSING"
77 = "DON'T KNOW"
99 = "REFUSED"
;
value NOSCHR
. = "MISSING"
0 = "ZERO"
1 = "ONE"
2 = "TWO"
3 = "THREE"
4 = "FOUR"
5 = "FIVE"
6 = "6 TO 9"
7 = "10 TO 19"
8 = "20 TO 29"
9 = "30 OR MORE"
77 = "DON'T KNOW"
96 = "DID NOT GO TO SCHOOL"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value NUMDKRF
. = "MISSING"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value NUMGEN
. = "MISSING"
;
value NUM_PHON
. = "MISSING"
1 = "ONE"
2 = "TWO"
3 = "THREE OR MORE"
4 = "NONE"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value RACEETHK
. = "MISSING"
1 = "HISPANIC"
2 = "NON-HISPANIC WHITE ONLY"
3 = "NON-HISPANIC BLACK ONLY"
4 = "NON-HISPANIC OTHER + MULTIPLE RACE"
;
value RACE_PUF
. = "MISSING"
1 = "WHITE ONLY"
2 = "BLACK ONLY"
3 = "OTHER + MULTIPLE RACE"
;
value REGISTRY
. = "MISSING"
1 = "ALL PROVIDERS"
2 = "SOME BUT POSSIBLY OR DEFINITELY NOT ALL PROVIDERS"
3 = "NO PROVIDERS"
4 = "UNKNOWN/DON'T KNOW"
;
value RENTOWN
. = "MISSING"
1 = "OWNED OR BEING BOUGHT"
2 = "RENTED"
3 = "OTHER ARRANGMENT"
77 = "DON'T KNOW"
99 = "REFUSED"
;
value SEX
. = "MISSING"
1 = "MALE"
2 = "FEMALE"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value STATE
. = "MISSING"
1 = "ALABAMA"
2 = "ALASKA"
3 = " "
4 = "ARIZONA"
5 = "ARKANSAS"
6 = "CALIFORNIA"
7 = " "
8 = "COLORADO"
9 = "CONNECTICUT"
10 = "DELAWARE"
11 = "DISTRICT OF COLUMBIA"
12 = "FLORIDA"
13 = "GEORGIA"
14 = " "
15 = "HAWAII"
16 = "IDAHO"
17 = "ILLINOIS"
18 = "INDIANA"
19 = "IOWA"
20 = "KANSAS"
21 = "KENTUCKY"
22 = "LOUISIANA"
23 = "MAINE"
24 = "MARYLAND"
25 = "MASSACHUSETTS"
26 = "MICHIGAN"
27 = "MINNESOTA"
28 = "MISSISSIPPI"
29 = "MISSOURI"
30 = "MONTANA"
31 = "NEBRASKA"
32 = "NEVADA"
33 = "NEW HAMPSHIRE"
34 = "NEW JERSEY"
35 = "NEW MEXICO"
36 = "NEW YORK"
37 = "NORTH CAROLINA"
38 = "NORTH DAKOTA"
39 = "OHIO"
40 = "OKLAHOMA"
41 = "OREGON"
42 = "PENNSYLVANIA"
43 = " "
44 = "RHODE ISLAND"
45 = "SOUTH CAROLINA"
46 = "SOUTH DAKOTA"
47 = "TENNESSEE"
48 = "TEXAS"
49 = "UTAH"
50 = "VERMONT"
51 = "VIRGINIA"
52 = " "
53 = "WASHINGTON"
54 = "WEST VIRGINIA"
55 = "WISCONSIN"
56 = "WYOMING"
66 = "GUAM"
72 = "PUERTO RICO"
78 = "U.S. VIRGIN ISLANDS"
;
value UTD
. = "MISSING"
0 = "NOT UTD"
1 = "UTD"
;
value UTDVRC
. = "MISSING"
0 = "NOT UTD, NO HISTORY OF CHICKEN POX DISEASE"
1 = "UTD"
2 = "NOT UTD, HISTORY OF CHICKEN POX DISEASE"
;
value YEARF
. = "MISSING"
7777 = "DON'T KNOW"
9999 = "REFUSED"
;
value YESMISS
. = "MISSING"
1 = "YES"
;
value YNDKRF
. = "MISSING"
1 = "YES"
2 = "NO"
77 = "DON'T KNOW"
98 = "MISSING IN ERROR"
99 = "REFUSED"
;
value $CHARGEN
" " = "MISSING"
;
value $TYPE
" " = "MISSING"
"01" = "DT"
"02" = "DTP"
"03" = "DT/DTP/DTAP-CONTAINING, UNKNOWN SUBTYPE"
"04" = "DTAP"
"11" = "TD"
"13" = "DT/TD-CONTAINING, UNKNOWN SUBTYPE"
"14" = "TDAP"
"15" = "TD/TDAP-CONTAINING, UNKNOWN SUBTYPE"
"1L" = "H1N1 FLU-UNKNOWN"
"1M" = "H1N1 FLU SPRAY"
"1N" = "H1N1 FLU INJECTED"
"20" = "OPV"
"21" = "IPV"
"22" = "POLIO-CONTAINING, UNKNOWN SUBTYPE"
"30" = "MMR-ONLY"
"31" = "MEASLES-ONLY"
"32" = "MEASLES-MUMPS"
"33" = "MEASLES-RUBELLA"
"43" = "HEPB-HIB"
"44" = "HIB-ONLY"
"4V" = "GARDASIL 4"
"61" = "0.5 ML RECOMBIVAX"
"62" = "1.0 ML RECOMBIVAX"
"63" = "ENGERIX"
"64" = "HEPATITIS B-ONLY, UNKNOWN SUBTYPE CHECKED"
"70" = "PNEUMOCOCCAL CONJUGATE"
"71" = "PNEUMOCOCCAL POLYSACCHARIDE"
"72" = "PNEUMOCOCCAL-CONTAINING, UKNOWN SUBTYPE"
"80" = "MCV4 (MENACTRA)"
"81" = "MPSV4 (MENOMUNE)"
"82" = "MENINGOCOCCAL SEROGROUP ACWY, UNKNOWN SUBTYPE"
"9V" = "GARDASIL 9"
"BB" = "MENB-4C (BEXSERO)"
"BC" = "BCG (TUBERCULOSIS)"
"BT" = "MENB-FHBP (TRUMENBA)"
"BU" = "MENINGOCOCCAL SEROGROUP B, UNKNOWN SUBTYPE"
"CV" = "CERVARIX"
"DC" = "DTP/DTAP COMBO"
"DH" = "DTP-HEPB"
"DK" = "DON'T KNOW"
"FL" = "SEASONAL FLU-CONTAINING, UNKNOWN SUBTYPE"
"FM" = "SEASONAL FLUMIST"
"FN" = "INJECTED SEASONAL FLU, OTHER/UNKNOWN SUBTYPE"
"FO" = "FOUR-IN-ONE"
"FV" = "SEASONAL FLUVIRIN"
"FZ" = "SEASONAL FLUZONE"
"GD" = "GARDASIL"
"HA" = "HEPATITIS A-CONTAINING, UNKNOWN SUBTYPE"
"HB" = "HEPATITIS B-CONTAINING, UNKNOWN SUBTYPE"
"HI" = "HIB-CONTAINING, UNKNOWN SUBTYPE"
"HO" = "HEPATITIS A-ONLY (HAVRIX OR VAQTA)"
"HP" = "HUMAN PAPILLOMAVIRUS, UNKNOWN SUBTYPE"
"MA" = "MALARIA"
"MB" = "MUMPS-RUBELLA"
"MM" = "MEASLES-CONTAINING, UNKNOWN SUBTYPE"
"MP" = "MUMPS-ONLY"
"MU" = "MENINGOCOCCAL, UNKNOWN SEROGROUP"
"NC" = "NEVER CODABLE DESCRIPTION"
"OT" = "VERBATIM"
"RB" = "RUBELLA-ONLY"
"RO" = "ROTAVIRUS"
"TY" = "TYPHOID"
"UN" = "UNCODABLE DESCRIPTION"
"UV" = "GARDASIL, UNKNOWN VALENCY"
"VA" = "VARICELLA-CONTAINING, UNKNOWN SUBTYPE"
"VM" = "MMR-VARICELLA"
"VO" = "VARICELLA-ONLY"
"YF" = "YELLOW FEVER"
;
run;
