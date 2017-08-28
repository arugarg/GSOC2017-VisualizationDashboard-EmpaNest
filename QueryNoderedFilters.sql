USE [NestTest]
GO
--------------------------------------------------------------------------------------
/*
	Version: 1.0
	Date: 2017-07-11
	Author: Arushee Garg
	Company: Empa Nest
	Nodered Dashboard Filters
	Queries into NestTest database
*/
--------------------------------------------------------------------------------------
/*For Avg values like NumericID = 3200000 , 3200002, 3200004 */

/*1. Year :*/

SELECT AVG(avg_value) as avg_temp, _year FROM ( SELECT AVG(TRY_CAST(_VALUE as FLOAT)) as avg_value 
,DATEPART( year, _TIMESTAMP ) as _year, DATEPART( month, _TIMESTAMP ) as _month, 
DATEPART( week, _TIMESTAMP ) as _week, DATEPART( day, _TIMESTAMP ) as _day , 
FORMAT(_TIMESTAMP, 'yyyy-MM-dd') as _date FROM [NestTest].[dbo].[KepMET51] 
where kepMet51._NUMERICID=3200000 AND TRY_CAST(_VALUE AS FLOAT) < 100 
AND _TIMESTAMP >= '2017-04-01' AND _TIMESTAMP <= '2017-05-31' 
GROUP BY DATEPART( year, _TIMESTAMP ), DATEPART( month, _TIMESTAMP ) , 
DATEPART( week, _TIMESTAMP ), DATEPART( day, _TIMESTAMP ), 
FORMAT(_TIMESTAMP, 'yyyy-MM-dd')) as ID group by _year order by _year;

/*2. Month :*/

SELECT AVG(avg_value) as avg_temp, _month FROM ( SELECT AVG(TRY_CAST(_VALUE as FLOAT)) as avg_value ,
DATEPART( year, _TIMESTAMP ) as _year, DATEPART( month, _TIMESTAMP ) as _month, 
DATEPART( week, _TIMESTAMP ) as _week, DATEPART( day, _TIMESTAMP ) as _day ,
 FORMAT(_TIMESTAMP, 'yyyy-MM-dd') as _date FROM [NestTest].[dbo].[KepMET51] 
 where kepMet51._NUMERICID=3200000 AND TRY_CAST(_VALUE AS FLOAT) < 100 
 AND _TIMESTAMP >= '2017-04-01' AND _TIMESTAMP <= '2017-05-31' 
 GROUP BY DATEPART( year, _TIMESTAMP ), DATEPART( month, _TIMESTAMP ) , 
 DATEPART( week, _TIMESTAMP ), DATEPART( day, _TIMESTAMP ),
  FORMAT(_TIMESTAMP, 'yyyy-MM-dd')) as ID group by _year ,_month order by _year, _month;

/*3. Week :*/

SELECT AVG(avg_value) as avg_temp, _week FROM ( SELECT AVG(TRY_CAST(_VALUE as FLOAT)) as avg_value ,
DATEPART( year, _TIMESTAMP ) as _year, DATEPART( month, _TIMESTAMP ) as _month, 
DATEPART( week, _TIMESTAMP ) as _week, DATEPART( day, _TIMESTAMP ) as _day , 
FORMAT(_TIMESTAMP, 'yyyy-MM-dd') as _date FROM [NestTest].[dbo].[KepMET51] 
where kepMet51._NUMERICID=3200000 AND TRY_CAST(_VALUE AS FLOAT) < 100 
AND _TIMESTAMP >= '2017-04-01' AND _TIMESTAMP <= '2017-06-30' 
GROUP BY DATEPART( year, _TIMESTAMP ), DATEPART( month, _TIMESTAMP ) , 
DATEPART( week, _TIMESTAMP ), DATEPART( day, _TIMESTAMP ), 
FORMAT(_TIMESTAMP, 'yyyy-MM-dd')) as ID group by _year , _week order by _year, _week;

/*4. Day :*/
SELECT AVG(avg_value) as avg_temp, _date FROM ( SELECT AVG(TRY_CAST(_VALUE as FLOAT)) as avg_value ,
DATEPART( year, _TIMESTAMP ) as _year, DATEPART( month, _TIMESTAMP ) as _month,
 DATEPART( week, _TIMESTAMP ) as _week, DATEPART( day, _TIMESTAMP ) as _day ,
  FORMAT(_TIMESTAMP, 'yyyy-MM-dd') as _date FROM [NestTest].[dbo].[KepMET51]
   where kepMet51._NUMERICID=3200000 AND TRY_CAST(_VALUE AS FLOAT) < 100
    AND _TIMESTAMP >= '2017-06-27' AND _TIMESTAMP <= '2017-07-03' 
	GROUP BY DATEPART( year, _TIMESTAMP ), DATEPART( month, _TIMESTAMP ) , 
	DATEPART( week, _TIMESTAMP ), DATEPART( day, _TIMESTAMP ), FORMAT(_TIMESTAMP, 'yyyy-MM-dd')) as ID 
group by _date order by _date

/*5. Hour :*/

SELECT AVG(avg_value) as avg_temp, _hour FROM ( SELECT AVG(TRY_CAST(_VALUE as FLOAT)) as avg_value ,
 DATEPART( year, _TIMESTAMP ) as _year, DATEPART( month, _TIMESTAMP ) as _month, 
 DATEPART( week, _TIMESTAMP ) as _week, DATEPART( day, _TIMESTAMP ) as _day , 
 DATEPART( hour, _TIMESTAMP ) as _hour FROM [NestTest].[dbo].[KepMET51]
  where kepMet51._NUMERICID= 3200000 AND TRY_CAST(_VALUE AS FLOAT) < 100 
  AND _TIMESTAMP >= '2017-06-28' AND _TIMESTAMP <= '2017-06-30'
   GROUP BY DATEPART( year, _TIMESTAMP ), DATEPART( month, _TIMESTAMP ) , 
   DATEPART( week, _TIMESTAMP ), DATEPART( day, _TIMESTAMP ), DATEPART( hour, _TIMESTAMP )) as ID 
   group by _hour order by _hour;

/*6. Hour Trend :*/

SELECT AVG(TRY_CAST(_VALUE as FLOAT)) as avg_temp , FORMAT(_TIMESTAMP, 'yyyy-MM-dd HH') as _hourtrend
 FROM [NestTest].[dbo].[KepMET51] where kepMet51._NUMERICID= 3200000 
 AND TRY_CAST(_VALUE AS FLOAT) < 100 AND _TIMESTAMP >= '2017-06-28' 
 AND _TIMESTAMP <= '2017-06-30'GROUP BY FORMAT(_TIMESTAMP, 'yyyy-MM-dd HH') 
 order by FORMAT(_TIMESTAMP, 'yyyy-MM-dd HH');

-------------------------------------------------------------------------------------------------
/*For Difference Values eg. for NumericID = 401191000 or 42100068  */

/*Day*/

SELECT TRY_CAST([_Max] AS FLOAT)-TRY_CAST([_Min] AS FLOAT) as avg_temp, 
_date from ( select distinct FORMAT(_TIMESTAMP, 'yyyy-MM-dd HH') as _date,
 first_value(_VALUE) over (partition by FORMAT(_TIMESTAMP, 'yyyy-MM-dd HH') order by _TIMESTAMP) as [_Min] , 
 first_value(_VALUE) over (partition by FORMAT(_TIMESTAMP, 'yyyy-MM-dd HH') order by _TIMESTAMP desc) as [_Max]
  from [dbo].[KepElEnergy] where _NUMERICID =401191000 
  AND _TIMESTAMP >= '2017-05-30' AND _TIMESTAMP <= '2017-07-12'
  AND TRY_CAST(_VALUE AS FLOAT) < 10000000 ) as ID 
  where TRY_CAST([_Max] AS FLOAT)-TRY_CAST([_Min] AS FLOAT) < 5000 
  order by _date asc

 /*using similar filter like day/year/month/week/hour/hourtrend */
--------------------------------------------------------------------------------------------------------
 /* For Weatehr Station using 5 signals together i.e. 3200000, 3200002, 3200003, 3200004, 3200008 */

SELECT 
  FORMAT(_TIMESTAMP, 'yyyy-MM') as _date ,
  ROUND(AVG(CASE when _NUMERICID = 3200000 AND TRY_CAST(_VALUE AS FLOAT) < 100 THEN TRY_CAST(_VALUE AS FLOAT) END),2) as avg_3200000,
  ROUND(AVG(CASE when _NUMERICID = 3200002  THEN TRY_CAST(_VALUE AS FLOAT) END),2) as avg_3200002,
  ROUND(AVG(CASE when _NUMERICID = 3200003  THEN TRY_CAST(_VALUE AS FLOAT) END),2) as avg_3200003,
  ROUND(AVG(CASE when _NUMERICID = 3200004  THEN TRY_CAST(_VALUE AS FLOAT) END),2) as avg_3200004,
  ROUND(AVG(CASE when _NUMERICID = 3200008  THEN TRY_CAST(_VALUE AS FLOAT) END),2) as avg_3200008
   FROM [NestTest].[dbo].[KepMET51]
   where  
     _TIMESTAMP >= '2017-06-27' AND _TIMESTAMP <= '2017-07-03' 
	GROUP BY FORMAT(_TIMESTAMP, 'yyyy-MM')
	order by _date
---------------------------------------------------------------------------------------------------------------

 