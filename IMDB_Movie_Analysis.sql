select * from imdb_data;

use ops;

#Find the movies with the highest profit?
select movie_title from imdb_data where profit=(select max(profit) from imdb_data);

#IMDb_Top_250
select rank() over(order by imdb_score desc) as movie_rank, movie_title as IMDb_Top_250, imdb_score
 from imdb_data where num_voted_users>25000 limit 250;
 
 #Top_Foreign_Lang_Film
 with cte as(
 select rank() over(order by imdb_score desc) as movie_rank, movie_title as IMDb_Top_250, imdb_score, language
 from imdb_data where num_voted_users>25000 limit 250)
 select rank() over(order by imdb_score desc) as movie_rank, IMDb_Top_250 as Top_Foreign_Lang_Film, imdb_score, language 
 from cte where language <> "English";
 
 #Best Directors
 select director_name as top10director, avg(imdb_score) as highest_imdb_score
 from imdb_data group by director_name order by highest_imdb_score desc, director_name limit 10;
 
#Popular genres
select genres as popular_genres, avg(imdb_score) as highest_imdb_score
 from imdb_data group by genres order by highest_imdb_score desc, genres limit 10;
 
 #Find the mean of the num_critic_for_reviews and num_users_for_review and identify the actors which have the highest mean.
 with cte as(
 select actor_1_name, movie_title, num_critic_for_reviews, num_user_for_reviews 
 from imdb_data where actor_1_name in ("Meryl Streep","Leonardo DiCaprio","Brad Pitt") 
 order by actor_1_name)
 select actor_1_name, round(avg(num_critic_for_reviews),3) as mean_num_critic_for_reviews,
 round(avg(num_user_for_reviews),3) as mean_num_user_for_reviews
 from cte group by actor_1_name 
 order by mean_num_critic_for_reviews desc , mean_num_user_for_reviews desc;
 
#Change in number of voted users over decades
 select floor(title_year/10)*10 as decade, sum(num_voted_users) as df_by_decade
 from imdb_data group by decade order by decade;
 
 
 
 
 
 
