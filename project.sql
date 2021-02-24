

#Metric: Mean, median, range, count, standardev
#KPIs: Always by the school, 

#Graduating year, DONE
#Course (Program),
#Reliability(Anonymous),
#Potentially employed?

#Clean Overallrating where not real number or year empty
DELETE FROM comments WHERE (overallScore ='not available');
DELETE FROM comments WHERE (graduatingYear = 'nan');

#Check on number of records:
select school, COUNT(id) as Count_Score
from comments
group by school
order by Count_score desc;

#Starting Average Rating point:
select graduatingYear as Grad_year, school,  round(avg(overallScore), 2) as Average_Score, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating,  (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by graduatingYear, school
order by graduatingYear desc;

select school,  round(avg(overallScore), 2) as Average_Score, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating,  (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by  school
order by Average_Score desc;

#Starting Average Rating Program point:
select school, program as Course, round(avg(overallScore), 2) as Average_Score, MAX(overallScore) as Max_Rating, MIN(overallScore) as Min_Rating, (MAX(overallScore) - MIN(overallScore)) as Range_ave, COUNT(id) as Count_Score
from comments
group by program, school
having Count_Score > 80
order by Count_Score desc;

#Location basic stats:

select school, COUNT(DISTINCT `country.name`) as Country_loc, COUNT(l.id) as Loc_num
from location l
group by l.school


#Location Average stats:
select l.school, round(avg(c.overallScore), 2) as Average_Score, COUNT(DISTINCT `country.name`) as Country_loc, COUNT(DISTINCT l.id) as Loc_num
from location l
LEFT JOIN comments c ON l.school = c.school 
group by school
order by Average_Score desc;


#Badges Average stats:
select bd.school, round(avg(c.overallScore), 2) as Average_Score, COUNT(DISTINCT bd.name) as Badge_count
from badges_df bd 
LEFT JOIN comments c ON bd.school = c.school 
group by school
order by Average_Score desc;


#Badges Average stats & comments:
select bd.school, round(avg(c.overallScore), 2) as Average_Score,  COUNT(DISTINCT CASE WHEN bd.name = 'Job Guarantee' then bd.school end) as JobWarranty, COUNT(DISTINCT bd.name) as Badge_count, COUNT(c.id) As Comm_count
from badges_df bd 
LEFT JOIN comments c ON bd.school = c.school 
group by 1
order by Average_Score desc;










