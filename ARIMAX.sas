/*
 *
 * Task code generated by SAS Studio 3.8 
 *
 * Generated on '2/19/24, 4:29 PM' 
 * Generated by 'tarun' 
 * Generated on server 'TARUNS-PC.UCONN.EDU' 
 * Generated on SAS platform 'X64_10PRO WIN' 
 * Generated on SAS version '9.04.01M6P11152018' 
 * Generated on browser 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' 
 * Generated on web client 'http://localhost:50341/main?locale=en_US&zone=GMT-05%253A00&sutoken=%257B32788F27-AB9E-432B-8FFD-E7C1CEF958C4%257D' 
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc sort data=STSM.POWERCONSUMPTION_TEST out=Work.preProcessedData;
	by week_start_date;
run;

proc arima data=Work.preProcessedData plots
     (only)=(series(corr crosscorr) residual(corr normal) forecast(forecast forecastonly) );
	identify var='Weekly Avgtemp'n(52);
	estimate p=(1) q=(1) method=ML;
	identify var=avgactivepower(52) crosscorr=('Weekly Avgtemp'n(52) );
	estimate p=(1) input=('Weekly Avgtemp'n) method=ML;
	forecast lead=52 back=52 alpha=0.05 id=week_start_date interval=week out=work.ARIMAX;
	run;
quit;

proc delete data=Work.preProcessedData;
run;