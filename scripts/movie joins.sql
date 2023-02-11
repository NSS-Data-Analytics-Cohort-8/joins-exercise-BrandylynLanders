-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue 
ON specs.movie_id=revenue.movie_id
ORDER BY worldwide_gross ASC;
--Answer "Semi-Tough"	1977	37187139

-- 2. What year has the highest average imdb rating?
SELECT AVG(imdb_rating), release_year
FROM specs
INNER JOIN rating 
ON specs.movie_id=rating.movie_id
GROUP BY release_year
ORDER BY AVG(imdb_rating) DESC;

--ANSWER 7.4500000000000000	1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT company_name, film_title, worldwide_gross
FROM distributors
INNER JOIN specs 
ON distributors.distributor_id=specs.domestic_distributor_id
INNER JOIN revenue
ON specs.movie_id=revenue.movie_id
WHERE specs.mpaa_rating = 'G'
ORDER BY revenue.worldwide_gross DESC;
--Answer "Walt Disney "	"Toy Story 4"


-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT distributors.company_name AS distributor,COUNT(specs.movie_id)
FROM distributors
LEFT JOIN specs 
ON distributors.distributor_id=specs.domestic_distributor_id
GROUP BY distributors.company_name
ORDER BY COUNT(specs.movie_id); 

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, ROUND(AVG(revenue.film_budget),2)AS avg_budget
FROM distributors 
INNER JOIN specs 
ON distributors.distributor_id=specs.domestic_distributor_id
INNER JOIN revenue
ON specs.movie_id=revenue.movie_id
GROUP BY distributors.company_name
ORDER BY AVG(revenue.film_budget) DESC
LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating? 
SELECT distributors.company_name, distributors.headquarters, rating.imdb_rating  
FROM distributors
INNER JOIN specs 
ON distributors.distributor_id=specs.domestic_distributor_id
INNER JOIN rating
ON specs.movie_id=rating.movie_id
WHERE LOWER (distributors.headquarters) NOT LIKE'%,_ca%'
ORDER BY rating.movie_id DESC;

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT specs.length_in_min, AVG(rating.imdb_rating)AS avg_rating
FROM specs
INNER JOIN rating 
ON specs.movie_id=rating.movie_id
GROUP BY specs.length_in_min
ORDER BY avg_rating DESC
--Answer Over two hours



