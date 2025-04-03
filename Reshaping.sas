PROC SQL;
CREATE TABLE WORK.query AS
SELECT distinct 
	INTNX('WEEK', 'Date'n, 0) as week_start_date format=date9., 
	mean( (Global_active_power*1000/60) as avgactivepower
FROM 
	STSM.FINALDATA
group by 
	INTNX('WEEK', 'Date'n, 0);
RUN;
QUIT;

PROC DATASETS NOLIST NODETAILS;
CONTENTS DATA=WORK.query OUT=WORK.details;
RUN;

PROC PRINT DATA=WORK.details;
RUN;