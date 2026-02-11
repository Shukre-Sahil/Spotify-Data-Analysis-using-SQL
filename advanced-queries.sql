/*
Advanced Level queries
1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
4. Find tracks where the energy-to-liveness ratio is greater than 1.2.
5. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/


-- Q1

with ranking_artist
as
(select 
	artist,
	track,
	sum(views) as total_views,
	dense_rank() over(partition by artist order by sum(views) desc) as rank
from spotify
group by 1, 2
order by 1, 3 desc
)
select * from ranking_artist
where rank<=3;

-- Q2
select 
	track,
	liveness
from spotify
where 
	liveness >= (
				select 
					avg(liveness)
				from spotify
				);

-- Q3

with cte
as
(
select 
	album,
	max(energy_liveness) as highest_energy,
	min(energy_liveness) as lowest_energy
from spotify
group by 1
)
select
	album,
	highest_energy - lowest_energy as difference
from cte
order by 2 desc;


-- Q4
select 
	track,
	energy_liveness,
	liveness ,
	energy_liveness / liveness as ratio
from spotify
where
	energy_liveness / liveness >= 1.2;


-- Q5

select 
	track,
	views,
	sum(likes) over(order by views desc) as cumilative_likes
from spotify
	