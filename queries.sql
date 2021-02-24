#Metric: Mean, median, range, count, standardev
#KPIs: Always by the school, 
​
#Graduating year, DONE
#Course (Program),
#Reliability(Anonymous),
#Potentially employed?

select * from comments;
#Clean Overallrating where not real number or year empty
DELETE FROM comments WHERE (overallScore ='not available');
DELETE FROM comments WHERE (graduatingYear = 'nan');
​
#Check on number of records per school:
select school, COUNT(id) as Count_Score
from comments
group by school
order by Count_score desc;
​
select * from comments;

#Starting Average Score By year:
select graduatingYear as Grad_year, school,  round(avg(overallScore), 2) as Average_Score, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating,  (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by graduatingYear, school
order by Grad_year, Average_Score;
​
select * from comments;

#Selecting average score and number of comments by school
select school, round(avg(overallScore), 2) as Average_Score, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating,  (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by  school
order by Average_Score desc;

#selecting job support score
select school, round(avg(jobSupport), 2) as job_support, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating,  (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by  school
order by job_support desc;

#selecting curriculum score
select school, round(avg(curriculum), 2) as curriculum, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating,  (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by  school
order by curriculum desc;
​
#Starting Average Score by Program and school:
select school, program as Course, round(avg(overallScore), 2) as Average_Score, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating, (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by program, school
having Count_Score > 80
order by Count_Score desc;
​
#Number of countries and locations per school:
select school, COUNT(DISTINCT `country.name`) as Country_loc, COUNT(l.id) as Loc_num
from locations l
group by l.school;
​
select * from comments;

#By school - avg score, Numnber of comments,  number of countries, number of locations,
Select 'country.name' from locations;
#Location Average stats:
select l.school, round(avg(c.overallScore), 2) as Average_Score, COUNT(distinct c.id) as No_of_comments, COUNT(DISTINCT `country.name`) as Country_loc, COUNT(DISTINCT l.id) as Loc_num
from locations l
LEFT JOIN comments c ON l.school = c.school 
group by school
order by Average_Score desc;
​

select * from badges;

​select * from badges;

#Number of badges per school and average score:
select bd.school, round(avg(c.overallScore), 2) as Average_Score, COUNT(DISTINCT bd.name) as Badge_count
from badges bd 
LEFT JOIN comments c ON bd.school = c.school 
group by school
order by Average_Score desc;
​
​
#Job Garauntee, number of badges, avg scorec no_of comments per school :
select bd.school, round(avg(c.overallScore), 2) as Average_Score,  COUNT(DISTINCT CASE WHEN bd.name = 'Job Guarantee' then bd.school end) as JobWarranty, COUNT(DISTINCT bd.name) as Badge_count, COUNT(distinct c.id) As Comm_count
from badges bd 
LEFT JOIN comments c ON bd.school = c.school 
group by 1
order by Average_Score desc;
​
​
​DROP table certified_table;
Create temporary table certified_table
select * from comments
where anonymous = 0;

select * from certified_table;

#average score & number of comments from non-anonymous comments (with > 80 comments)
select school, round(avg(overallScore), 2) as Average_Score, round(MAX(overallScore), 2) as Max_Rating, round(MIN(overallScore), 2) as Min_Rating, round((MAX(overallScore) - MIN(overallScore)), 2) as Range_ave, COUNT(id) as Count_Score
from certified_table
group by school
having Count_Score > 80
order by Average_Score desc;
​
#alumni comments
drop table alumni_table;
Create temporary table alumni_table
select * from comments 
where isAlumni = 'True';

#alumni comments
#school stats
select school, round(avg(overallScore), 2) as Average_Score, round(MAX(overallScore), 2) as Max_Rating, round(MIN(overallScore), 2) as Min_Rating, round((MAX(overallScore) - MIN(overallScore)), 2) as Range_ave, COUNT(id) as Count_Score
from alumni_table
group by school
having Count_Score > 80
order by Average_Score desc;
