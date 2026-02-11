/*
Easy Level Questions

1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where licensed = TRUE.
4. Find all tracks that belong to the album type single.
5. Count the total number of tracks by each artist.
*/

-- Q1
select 
	track as Tracks,
	stream as Streams
from spotify
where 
	stream >= 1000000000;

-- Q2
select
	album as Albums,
	artist
from spotify
group by album, artist;

-- Q3 
select
	sum(comments) as total_comments
from spotify
where licensed = TRUE;

-- Q4
select
	track
from spotify
where album_type in ('single');


-- Q5
select 
	artist,
	count(track) as total_no_of_tracks
from spotify
group by artist; 


/*
Medium Level
1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
3. List all tracks along with their views and likes where official_video = TRUE.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.
*/


-- Q1
select 
	distinct album,
	avg(danceability)
from spotify
group by album
order by 2 desc;

-- Q2
select	
	track,
	max(energy)
from spotify
group by track
order by max(energy) desc
limit 5;

-- Q3
select
	distinct track,
	sum(views) as total_views,
	sum(likes) as total_likes
from spotify
where official_video = TRUE
group by track
order by 2 desc;

-- Q4
select
	album,
	track,
	sum(views) as total_views
from spotify
group by album, track
order by 3 desc;

-- Q5
select * from 
(
select 
	track,
	coalesce(sum(case
		when MOST_PLAYED_ON = 'Spotify' 
		then stream
	end), 0) as streamed_on_spotify,
	coalesce(sum(case
		when MOST_PLAYED_ON = 'Youtube' 
		then stream 
	end), 0) as streamed_on_youtube
from spotify
group by 1
) as temp_table
where 
	streamed_on_spotify > streamed_on_youtube  and
	streamed_on_youtube <> 0;

