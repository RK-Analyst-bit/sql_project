create database spotify;

-- EDA
select count(*) from `cleaned_dataset (1)`;

select count(distinct Artist) from `cleaned_dataset (1)`;

select distinct Album_type from `cleaned_dataset (1)`;

select max(Duration_min) from `cleaned_dataset (1)`;

select min(Duration_min) from `cleaned_dataset (1)`;

select * from `cleaned_dataset (1)`
where Duration_min = 0 ;

-- -----------------------------
-- Data analysis easy category problem
-- ----------------------------- 

-- 1) Retrieve the names of all tracks that have more than 1 billion streams. 
select * from `cleaned_dataset (1)`
where Views >= 10000000;

-- 2) List all album along with their respective artists. 
select distinct Album,Artist  from `cleaned_dataset (1)`
;

-- 3) Get the total number of comments for tracks where licensed = True.
ALTER TABLE `cleaned_dataset (1)`
MODIFY Licensed BOOLEAN;
select Track from `cleaned_dataset (1)`
where Licensed = 'true';

-- 4)find all tracks that belong to the album type single.
select Track ,Album_type from `cleaned_dataset (1)`
where Album_type = 'single'; 

-- 5) Count the total number of tracks by each artist.
select Artist,count(*) from `cleaned_dataset (1)`
group by Artist
order by  2 desc;

-- -----------------------
-- Data analysis of medium level song
-- -----------------------

-- 1) calculate the average danceability of tracks in each album.
select Album, AVG(Danceability) from `cleaned_dataset (1)`
group by Album
order by 2 desc;

-- 2) Find the top 5 tracks with the highest energy values.
select distinct Track, Energy from `cleaned_dataset (1)`
order by Energy desc
limit 5;

-- 3) list all tracks along with their views and likes where official_video = True.
select Track,sum(Views) as total_view,sum(Likes ) as total_like from `cleaned_dataset (1)`
where official_video = 'true'
group by 1;

-- 4) For each album, calculate the total views of all associate tracks.
select Album, Track,sum(Views) as total_view from `cleaned_dataset (1)`
group by Album,Track
order by 3 desc;  



-- Advanced question
select * from `cleaned_dataset (1)`;

-- 1 Find The top 3 most_viewed tracks for each artist using window functions. 
select Artist,Track,Total_views,ranking from
(select Artist,Track,sum(Views) as Total_views ,rank() over(partition by Artist order by sum(Views) desc) as ranking
from `cleaned_dataset (1)`
group by 1,2) as ti
where ranking <= 3;

-- 2 Write a query to find tracks where the liveness score is above average.
select avg(Liveness)
 from `cleaned_dataset (1)`;
select*
 from `cleaned_dataset (1)`
 where Liveness > (select avg(Liveness)
 from `cleaned_dataset (1)`);
 -- 13 use a with clauses to calculate the difference between the
 -- highest and lowest energy values for tracks in each album
 with cte as
 (select Album,max(Energy) as Max_energy,min(Energy) as min_energy
 from `cleaned_dataset (1)`
 group by 1 ) select Album, Max_energy-Min_energy as energy_difference
 from cte;

 





  











 