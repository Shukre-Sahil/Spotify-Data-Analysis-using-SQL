drop table if exists spotify;
create table spotify(
 artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)

);

select * from spotify;

/*EDA on this dataset*/

select count(*) from spotify;

select count(distinct artist) from spotify;

select count(distinct album) from spotify;

select distinct album_type from spotify;

-- -----------------------------------------
/*Looking for max and minimum duration of the songs and deleting any unwanted record*/
select 
	max(duration_min) as Max_Duration,
	min(duration_min) as Min_Duration
from spotify;

select * from spotify
where duration_min = '0';

delete from spotify
where duration_min = '0';

-- -------------------------------------------

/* Looking for different channels and platforms where songs were streamed the most */
select count(distinct channel) from spotify;

select 
	most_played_on as Platform, 
	count(most_played_on) as times_played 
from spotify
group by most_played_on;

-- ------------------------------------------

