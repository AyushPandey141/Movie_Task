CREATE DATABASE Movie;
USE Movie;

CREATE TABLE users(UID INT(10) PRIMARY KEY,UNAME VARCHAR(20),EMAIL VARCHAR(25));
CREATE TABLE movie(movie_id INT(10) PRIMARY KEY,movie_title VARCHAR(25),movie_year YEAR(4),movie_time INT(5),director VARCHAR(20));
CREATE TABLE genre(gen_id INT(10) PRIMARY KEY,gen_title VARCHAR(20));
CREATE TABLE movie_genre(Movie_id INT(10),Gen_id INT(10),FOREIGN KEY (Movie_id) REFERENCES movie(movie_id),FOREIGN KEY (Gen_id) REFERENCES genre(gen_id));
CREATE TABLE movie_cast(cast_id INT(10),Movie_Id INT(10),role VARCHAR(20),FOREIGN KEY (cast_id) REFERENCES artist(artist_id),FOREIGN KEY (Movie_Id) REFERENCES movie(movie_id));
CREATE TABLE review(MOVIE_ID INT(10),USER_ID INT(10),REVIEW VARCHAR(100),FOREIGN KEY (MOVIE_ID) REFERENCES movie(movie_id),FOREIGN KEY (USER_ID) REFERENCES users(UID));
CREATE TABLE media(m_id INT(10),video VARCHAR(150),IMAGE varchar(150),FOREIGN KEY (m_id) REFERENCES movie(movie_id));

INSERT INTO users(UID,UNAME,EMAIL) VALUES(1,"Ayush","ayush@gmail.com"),(2,"Aman","aman@gmail.com"),
(3,"Priyanshu","priyanshu@gmail.com"),(4,"Gaurav","gaurav@gmail.com"),(5,"Harsh","harsh@gmail.com");
INSERT INTO movie(movie_id,movie_title,movie_year,movie_time,director) VALUES(100,"3 Idiots",2009,150,"Rajkumar Hirani"),(101,"Shershaah",2021,125,"Vishnuvardhan"),
(102,"Mumbai Saga",2021,135,"Sanjay Gupta"),(104,"Toofan",2021,163,"Rakeysh Mehra"),(105,"Chhichhore",2019,143,"Nitesh Tiwari");
INSERT INTO genre(gen_id,gen_title) VALUES(1001,"Crime"),(1002,"Action"),(1003,"Comedy"),(1004,"Drama"),(1005,"Romance");
INSERT INTO movie_genre(Movie_id,Gen_id) VALUES(100,1003),(100,1004),(100,1005),(101,1002),(102,1001),(102,1002),(104,1004),(104,1005),(105,1004),(105,1003);

CREATE TABLE artist(artist_id INT(10),artist_name VARCHAR(20),artist_gender VARCHAR(10),artist_skills VARCHAR(20),PRIMARY KEY(artist_id,artist_skills));
INSERT INTO artist(artist_id,artist_name,artist_gender,artist_skills) VALUES (500,"Aamir Khan","Male","Experience"),(500,"Aamir Khan","Male","Confidence"),(501,"Sidharth Malhotra","Male","Dance"),(501,"Sidharth Malhotra","Male","Theatre"),
(502,"John Abraham","Male","Teamwork"),(502,"John Abraham","Male","Acting"),(503,"Farhan Akhtar","Male","Voice"),(503,"Farhan Akhtar","Male","Confidence"),(504,"Sushant Singh","Male","Creative"),
(504,"Sushant Singh","Male","Dance");
ALTER TABLE movie_cast RENAME COLUMN role to Roles;  
INSERT INTO movie_cast(cast_id,Movie_Id,Roles) VALUES(500,100,"Friend"),(500,100,"Teacher"),(501,101,"Lover"),(501,101,"Officer"),(502,102,"Criminal"),(502,102,"Leader"),
(503,104,"Fighter"),(503,104,"Criminal"),(504,105,"Friend"),(504,105,"Father");

ALTER TABLE review ADD r_id INT(10) PRIMARY KEY;
INSERT INTO review(MOVIE_ID,USER_ID,REVIEW,r_id) VALUES (100,1,"Awesome Movie",700),(101,2,"Nice acting",701),(102,3,"Must watch movie",702),(104,4,"Value for money",703),
(105,5,"Great movie on Friendship",704);

SELECT * FROM users;
SELECT * FROM movie;
SELECT * FROM artist;
SELECT * FROM movie_cast;
SELECT * FROM movie_genre;
SELECT * FROM genre;
SELECT * FROM review;

ALTER TABLE media ADD med_id INT(10) PRIMARY KEY;
INSERT INTO media(m_id,video,IMAGE,med_id) VALUES(100,"Video 1","Image 1",900),(100,"Video 2","Image 2",901),(101,"Video 3","Image 3",902),(101,"Video 4","Image 4",903),
(101,"Video 5","Image 5",904),(102,"Video 6","Image 6",905),(102,"Video 7","Image 7",906),(104,"Video 8","Image 8",907),(104,"Video 9","Image 9",908),
(105,"Video 10","Image 10",909),(105,"Video 11","Image 11",910);

SELECT * FROM media;

/*List all media of a particualr film*/
SELECT movie_title,video,IMAGE FROM movie LEFT JOIN media ON movie.movie_id=media.m_id;

/*List all media and reviews of a particular film*/
SELECT movie_title,video,IMAGE,review.REVIEW FROM movie LEFT JOIN media ON movie.movie_id=media.m_id LEFT JOIN review ON media.m_id=review.MOVIE_ID;

/*List all cast along with roles and artist of a particular film*/
SELECT distinct artist_name,Roles,movie_title FROM movie LEFT JOIN movie_cast ON movie.movie_id =movie_cast.Movie_Id LEFT JOIN artist ON artist.artist_id=movie_cast.cast_id;

/*List all the reviews given by particular user*/
SELECT UNAME,review FROM users JOIN review ON users.UID=review.USER_ID;

/*List all the skills of a particular Artist*/
SELECT artist_name,artist_skills FROM artist;

/*List all the roles performed by particular artist*/
SELECT distinct movie_title,artist_name,Roles FROM movie JOIN movie_cast ON movie.movie_id=movie_cast.Movie_Id JOIN artist ON movie_cast.cast_id=artist.artist_id;
