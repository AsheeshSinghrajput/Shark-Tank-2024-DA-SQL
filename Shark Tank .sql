select * from sharktank
/* Question 1. Find total number of episodes . */

select count(distinct(emp)) total_episodes from sharktank

/* Question 2. Find total number of piches. */

/* Note : To find the total number of pichtes we find the total brand , we cant only unique brand will be participate in all espisode */
select count(distinct (brand))total_number_of_pitches from sharktank

/* Question 3.Find out of these 98 piches how many brands got the funding ? */

select count(deal) as get_funding  from sharktank 
where deal <>'No Deal'

OR 

select sum(invested_not_invested)successful_pitches,count(amount_invested)total_pitches from 
(select amount_invested,case when amount_invested>0 then 1 else 0 end as invested_not_invested 
from sharktank)a

/* Question 4.What is the success ratio of pitches ? */

/* It mean 58 percent of chances to successful in pitches */

select successful_pitches::float/total_pitches::float as total_successful_pitches from
(select sum(invested_not_invested)successful_pitches,count(amount_invested)total_pitches from 
(select amount_invested,case when amount_invested>0 then 1 else 0 end as invested_not_invested 
from sharktank)a)b


/* Question 5. Total number of male and female participants . */

select sum(male) as total_male ,sum(female)total_female from sharktank

/* Question 6. How many percentage female participants are in episodes ? */

select total_female/total_male as total_female_participants_percentage  from
(select sum(male) as total_male ,sum(female)total_female from sharktank)a

/* Question 7. What is the total amount invested and total amount asked  ? */

select sum(amount_invested)total_amount_invested_lakhs ,sum(amount_asked)total_amount_asked_lakhs from sharktank

/* Question 8. What is the average equity taken by sharktanks ? */

select total_equitytaken/total_equity_participent as total_avg_equity_taken from
(select sum(equity_taken)total_equitytaken  ,sum(equity) total_equity_participent from
(select equity_taken, case when equity_taken >0 then 1 else 0 end as equity from sharktank)a)b

or 
select  avg(equity_taken) avg_equity_taken from sharktank
where equity_taken >0


/* Question 9. what is the highest amount invested ? */

select max(amount_invested)as highest_amount_invested from sharktank

/* Question 10 .What is the highest equity taken ? */

select max(equity_taken) as highest_equity_taken from sharktank

/* Question 11. Find out all the pitches where at list one women participants . */

select count(female) total_pitches_women_participents from sharktank
where female>=1

/* Question 12.How many pitches converted which had at least one women paticipants ? */

select count(*)as women_participent_successful_deal from
(select female , deal from sharktank 
where female>=1 and deal<> 'No Deal')a

/* Question 13. Find average team member in all the pichtes . */

select round(avg(team_member)::numeric,0)as avg_teach_member from sharktank 

/* Question 14. Find out what is the avgerage amount invested in per deal ? */

select avg(amount_invested)avg_amount_invtest_in_lakhs_per_deal from sharktank
where amount_invested>=1

/* Question 15. Most age group participate in sharktank . */

select age, max(rankno) maximum_participants  from 
(select age, row_number () over(partition by age) rankno  from sharktank )a
group by age order by 2 desc limit 1

/* Note . There are 30 to 35 year people are paticipating the most around 32 times . */

/* Question 16. From which location participants coming the most ? */

select location ,max(row_num)from 
(select location , row_number()over (partition by location)row_num from sharktank)a
group by 1 order by 2 desc limit 1

/* Question 17. which sector most deal are successful ? */

select sector,count(sector) as most_successful_sector  from 
(select sector ,deal from sharktank
where deal<>'No Deal')a
group by 1 order by 2 desc limit 3

/* Question 16. How many parteners deal happend solo and combined  ? */

select partners , count(partners) from sharktank 
where partners <> '-'
group by 1 order by 2 desc




