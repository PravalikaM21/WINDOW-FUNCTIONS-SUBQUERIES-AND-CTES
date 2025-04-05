        
	---CREATE DATABASE----
create database IMDB;

----CREATE TABLE-----
create table movie_info(Movie_ID int,Title varchar(20),Director varchar(20),Release_year int,Runtime_Min int,Language varchar(20),Country varchar(20),IMBD_Rating float,Box_Office int);

---READ THE DATA FROM MOVIE_INFO-----
select * from movie_info;

---ADD  NEW COLUMN TO THE EXISTING TABLE------
alter table movie_info
add  Genre varchar(20);

-----CHAGE THE TYPE OF THE DATA------
alter table movie_info
alter column Box_Office varchar(20);

---INSERT THE DATA INTO THE TABLE----
insert into movie_info values(1,'Baahubali','S.S Rajamouli',2015,159,'Telugu','India',8.0,2500000000,'Action'),
(2,'RRR','S.S Rajamouli',2022,182,'Telugu','India',7.8,1600000000,'Action'),
(3,'Kantara','RishabShetty',2022,150,'Kannada','India',8.3,9000000000,'Action'),
(4,'Avatar','James Cameron',2009,162,'English','USA',7.9,2923000000,'Sci-Fi'),
(5,'KGF Chapter1','Prashanth Neel',2018,155,'Kannada','India',8.2,2500000000,'Action'),
(6,'Vikram','Lokesh kanagaraj',2022,174,'Tamil','India',8.4,2500000000,'Action'),
(7,'Leo','Lokesh kanagaraj',2023,164,'Tamil','India',7.8,6000000000,'Action'),
(8,'Jailer','Nelson Dilipkumar',2023,168,'Tamil','India',7.8,6000000000,'Action'),
(9,'Drishyam','Jeethu Joseph',2013,160,'Malayalam','India',8.4,7500000000,'Thriller'),
(10,'Lucifer','Prithviraj Sukumaran',2019,174,'Malayalam','India',8.6,1500000000,'Action'),
(11,'Premalu','Girish',2024,140,'Malayalam','India',8.6,1500000000,'Romance'),
(12,'3Idoiots','Rajkumar Hirani',2009,170,'Hindi','India',8.6,2500000000,'Comedy'),
(13,'Dangal','Nitesh Tivari',2016,161,'Hindi','India',8.4,1500000000,'Sports'),
(14,'Gully Boy','Joya Akhtar',2019,153,'Hindi','India',8.0,4500000000,'Drama'),
(15,'Parasite','Bong JOonho',2019,132,'Korean','South Korea',7.6,2500000000,'Thriller'),
(16,'Train to Busan','yeon sangho',2015,159,'Korean','South korea',8.0,2500000000,'Horror'),
(17,'Squid game','Hwang Dong-hyuk',2023,180,'English','USA',8.0,2500000000,'Thriller'),
(18,'Oppenheimer','Christipher Nolan',2014,169,'English','USA',8.6,23000000,'Drama'),
(19,'Intersteller','Christipher Nolan',2008,152,'English','USA',8.6,7730000000,'Sci-Fi'),
(20,'The dark night','Christipher Nolan',2008,152,'English','USA',9.0,1005000000,'Action');


create table MovieCast(Movie_ID int,Actor varchar(20),Actress varchar(20),OTT varchar(20),Status varchar(20));

select * from MovieCast;

 insert into MovieCast values(1,'Prabhas','Anushka','Aha','Blockbuster'),
 (2,'NTR','Alia Bhatt','Aha','Hit'),
 (3,'Rishab Shetty','Sapthami Gowda','Netflix','Flop'),
 (4,'Yash','Srinidhi','ZEE','Blockbuster'),
 (5,'Kamal Hasan','Anushka','Hotstar','superhit'),
 (6,'Vijay','Trisha','ZEE','Average'),
 (7,'Rjinikanth','Ramya','Aha','Flop'),
 (8,'Mohanlal','Meena','Sunnext','Hit'),
 (9,'Mohanlal','Manju Warrior','Hotstar','Hit'),
 (10,'Naslen Gafoor','Meena','ZEE','Average');
 
 ---INNER JOIN---
SELECT * 
FROM movie_info m1 
INNER JOIN MovieCast m2 ON m1.Movie_ID = m2.Movie_ID;

 ---LEFT JOIN-----
SELECT * 
FROM movie_info m1 
LEFT JOIN MovieCast m2 ON m1.Movie_ID = m2.Movie_ID;

 -----RIGHT JOIN------
SELECT * 
FROM movie_info m2 
RIGHT JOIN MovieCast m1 ON m2.Movie_ID = m1.Movie_ID;
 
 ----OUTER JOIN-----
SELECT * 
FROM movie_info m1 
FULL OUTER JOIN MovieCast m2 ON m1.Movie_ID = m2.Movie_ID;

 -----CROSS JOIN------
SELECT m1.Movie_ID, m2.Movie_ID AS Cast_Movie_ID
FROM movie_info m1
CROSS JOIN MovieCast m2;


 select * from  movie_info, MovieCast;

 	
		
		
		
		
		
		---WINDOW FUNCTIONS---
     --Types of Window Functions----
--Aggregate Window Functions (Compute aggregates without grouping rows)--
-- 1) Total IMDB Rating of All Movies
SELECT SUM(IMDB_Rating) AS TotalRating FROM movie_info;

-- 2) Average IMDB Rating
SELECT AVG(IMDB_Rating) AS AvgRating FROM movie_info;

-- 3) Total Movies Count
SELECT COUNT(*) AS TotalMovies FROM movie_info;

-- 4) Year of Most Recent Movie
SELECT MAX(Release_year) AS Most_Recent_Year FROM movie_info;

-- 5) Year of First Released Movie
SELECT MIN(Release_year) AS First_Release_Year FROM movie_info;


--Ranking Window Functions (Assign ranks or numbers to rows)--
ROW_NUMBER()--(Assigns a unique number to each row)

-- 1) Assign Unique Row Numbers to Movies Based on Rating
SELECT Title, IMDB_Rating,
       ROW_NUMBER() OVER (ORDER BY IMDB_Rating DESC) AS RankByRating
FROM movie_info;

RANK()--(Assigns a rank with gaps if duplicates exist)

--2)Rank Movies Based on Box Office Collection:

SELECT Title, Box_Office,
       RANK() OVER (ORDER BY CAST(Box_Office AS BIGINT) DESC) AS BoxOfficeRank
FROM movie_info;

DENSE_RANK()--Assigns a rank without gaps.

-- 3) Dense Rank Movies Within Each Genre by Rating
SELECT Title, Genre, IMDB_Rating,
       DENSE_RANK() OVER (PARTITION BY Genre ORDER BY IMDB_Rating DESC) AS RankByGenre
FROM movie_info;

--Value Window Functions (Access values from different rows in the partition)--
LAG()--(Gets the value from the previous row)

--1)Compare Each Movie’s Box Office with the Previous Movie's Box Office:
-- 1) Previous Movie's Box Office
SELECT Title, Box_Office,
       LAG(Box_Office) OVER (ORDER BY CAST(Box_Office AS BIGINT) DESC) AS PrevMovieRevenue
FROM movie_info;


LEAD()--(Gets the value from the next row)

--1)Compare a Movie’s Rating with the Next Movie’s Rating:
	SELECT Title, IMDB_Rating,
       LEAD(IMDB_Rating) OVER (ORDER BY IMDB_Rating DESC) AS NextMovieRating
FROM movie_info;


--Value Window Function(allow you to access specific row values within a window) 
FIRST_VALUE()--Returns the first value in the window.

--1)Find the First Movie Released in the Dataset:
SELECT Title, Release_year,
       FIRST_VALUE(Title) OVER (ORDER BY Release_year) AS FirstMovie
FROM movie_info;

LAST_VALUE()--Returns the last value in the window.
--1)Find the Latest Movie Released in Each Genre:
	SELECT Title, Genre, Release_year,
       LAST_VALUE(Title) OVER (
           PARTITION BY Genre 
           ORDER BY Release_year
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS LatestMovieInGenre
FROM movie_info;

--Offset Window Functions (Return values from a specific row relative to the current row)--

PERCENT_RANK()--Calculates relative rank as a percentage.

--1)Find the Percentile Rank of Each Movie Based on Box Office Revenue:
	SELECT Title, Box_Office,
       PERCENT_RANK() OVER (ORDER BY CAST(Box_Office AS BIGINT) DESC) AS PercentRank
FROM movie_info;


-- 2) Cumulative Distribution by Box Office
SELECT Title, Box_Office,
       CUME_DIST() OVER (ORDER BY CAST(Box_Office AS BIGINT) DESC) AS CumeDist
FROM movie_info;

=================================================================================================================================================
---SUBQUERIES-----

---Read the data from the database-----
select * from movie_info; 

--1)Find Movies with Above-Average IMDb Ratings:
SELECT Title
FROM movie_info
WHERE IMDB_Rating > (SELECT AVG(IMDB_Rating) FROM movie_info);


-- 2) Directors with Multiple Movies
SELECT Director, COUNT(*) AS Movie_Count
FROM movie_info
GROUP BY Director
HAVING COUNT(*) > 1;


-- 3) Top-Rated Movie in Each Language
SELECT M1.Language, M1.Title, M1.IMDB_Rating
FROM movie_info M1
WHERE M1.IMDB_Rating = (
    SELECT MAX(M2.IMDB_Rating)
    FROM movie_info M2
    WHERE M2.Language = M1.Language
);


-- 4) Movies Longer Than Average Runtime
SELECT Title, Runtime_Min
FROM movie_info
WHERE Runtime_Min > (SELECT AVG(Runtime_Min) FROM movie_info);



-- 5) Directors with Movies in Multiple Languages
SELECT Director
FROM movie_info
GROUP BY Director
HAVING COUNT(DISTINCT Language) > 1;

-- 6) Movies with Highest Box Office in Each Country
SELECT Country, Title, Box_Office
FROM movie_info m1
WHERE CAST(Box_Office AS BIGINT) = (
    SELECT MAX(CAST(Box_Office AS BIGINT))
    FROM movie_info m2
    WHERE m2.Country = m1.Country
);


-- 7) Directors with Average Rating Above 8.0
SELECT Director, AVG(IMDB_Rating) AS Average_Rating
FROM movie_info
GROUP BY Director
HAVING AVG(IMDB_Rating) > 8.0;


======================================================================================================================================================================


                  --CTEs (Common Table Expressions)

--temporary result sets that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.
--They improve code readability and make complex queries more manageable.
-- Retrieve titles and IMDb ratings of movies directed by directors with avg rating > 8.0


WITH DirectorAverageRatings AS (
    SELECT Director, AVG(IMBD_Rating) AS Avg_Rating
    FROM movie_info
    GROUP BY Director
    HAVING AVG(IMBD_Rating) > 8.0
)
SELECT m.Title, m.IMBD_Rating, m.Director
FROM movie_info m
JOIN DirectorAverageRatings dar ON m.Director = dar.Director;