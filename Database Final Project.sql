create database wastereduction;
use wastereduction;


CREATE TABLE User (
    user_id INT NOT NULL PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE
);


INSERT INTO User (user_id, username, email, password_hash, first_name, last_name, date_of_birth)
VALUES
    (1, 'john_doe', 'john.doe@example.com', 'johndoe123', 'John', 'Doe', '1990-01-15'),
    (2, 'jane_smith', 'jane.smith@example.com', 'janesmith24', 'Jane', 'Smith', '1985-05-22'),
    (3, 'alice_jones', 'alice.jones@example.com', 'alice315', 'Alice', 'Jones', '1993-08-10'),
    (4, 'bob_anderson', 'bob.anderson@example.com', 'bob20anderson', 'Bob', 'Anderson', '1980-12-05'),
    (5, 'sara_miller', 'sara.miller@example.com', 'sara80', 'Sara', 'Miller', '1992-03-30'),
    (6, 'samuel_wilson', 'samuel.wilson@example.com', 'samuel27', 'Samuel', 'Wilson', '1987-09-18'),
    (7, 'emily_brown', 'emily.brown@example.com', 'emily09', 'Emily', 'Brown', '1995-11-12'),
    (8, 'alex_carter', 'alex.carter@example.com', 'alex2040', 'Alex', 'Carter', '1983-06-25'),
    (9, 'laura_thompson', 'laura.thompson@example.com', 'thomspson102', 'Laura', 'Thompson', '1998-04-08'),
    (10, 'michael_jackson', 'michael.jackson@example.com', 'jackson39', 'Michael', 'Jackson', '1989-07-03');
    
CREATE TABLE achievements (
    achievement_id INT NOT NULL PRIMARY KEY,
    user_id INT,
    achievement_name VARCHAR(255),
    achievement_date DATE,
    points_earned INT,
    category VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE INDEX idx_user_id ON Achievements(user_id);

INSERT INTO Achievements (achievement_id, user_id, achievement_date, points_earned, achievement_description, category)
VALUES
    (3, 1, '2023-03-05', 25, 'Environmental Awareness', 'Environment'),
    (4, 3, '2023-03-20', 40, 'Community Service Award', 'Community'),
    (5, 5, '2023-04-01', 15, 'Eco-Friendly Practices', 'Environment'),
    (6, 2, '2023-04-10', 60, 'Top Sports Achiever', 'Sports'),
    (7, 4, '2023-05-02', 30, 'Tech Innovation Award', 'Technology'),
    (8, 6, '2023-05-15', 20, 'Health and Wellness Milestone', 'Health'),
    (9, 8, '2023-06-05', 45, 'Leadership Excellence', 'Leadership'),
    (10, 10, '2023-06-20', 55, 'Cultural Ambassador', 'Arts and Culture'),
    (11, 7, '2023-07-01', 35, 'Educational Achievement', 'Education'),
    (12, 9, '2023-07-15', 50, 'Innovation Pioneer', 'Technology');

CREATE TABLE events (
    event_id INT NOT NULL PRIMARY KEY,
    event_name VARCHAR(255),
    event_date DATE
);

CREATE INDEX idx_event_date ON Events(event_date);

INSERT INTO Events (event_id, event_name, event_date, location, organizer)
VALUES
    (3, 'Green Initiative Workshop', '2023-04-15', 'Community Center', 'Eco Team'),
    (4, 'Tech Conference 2023', '2023-05-10', 'Convention Center', 'Tech Society'),
    (5, 'Health and Fitness Expo', '2023-06-01', 'Fitness Park', 'Wellness Club'),
    (6, 'Cultural Fest', '2023-07-05', 'City Amphitheater', 'Cultural Society'),
    (7, 'Science Fair', '2023-08-20', 'School Auditorium', 'Science Club'),
    (8, 'Food Festival', '2023-09-12', 'Downtown Square', 'Culinary Association'),
    (9, 'Educational Summit', '2023-10-03', 'Conference Hall', 'Education Forum'),
    (10, 'Sports Day', '2023-11-15', 'Sports Stadium', 'Sports Committee'),
    (11, 'Art Exhibition', '2023-12-08', 'Art Gallery', 'Art Club'),
    (12, 'Community Cleanup Drive', '2024-01-20', 'City Streets', 'Community Services');
    
    
CREATE TABLE Badge (
    badge_id INT NOT NULL PRIMARY KEY,
    badge_name VARCHAR(255),
    badge_image VARCHAR(255),
    FOREIGN KEY (badge_name) REFERENCES achievements (acheievement_name)
);

INSERT INTO Badge (Badge_id, Badge_Name, Badge_image)
VALUES
    (1, 'Novice', 'yellow'),
    (2, 'Apprentice', 'blue'),
    (3, 'Explorer', 'green'),
    (4, 'Skywalker', 'orange'),
    (5, 'Expert', 'purple');

    
use wastereduction;
SELECT
        u.User_ID,
        u.Username,
        u.First_Name,
        u.Last_Name,
        u.Date_of_Birth,
        a.points_earned,
        a.Achievement_Name,
        a.category,
        e.Event_Name
    FROM
        User u
    LEFT JOIN Achievements a ON u.User_ID = a.user_id
    LEFT JOIN Events e ON a.Achievement_Name = e.Event_Name;
    
    
SELECT
  u.user_id,
  u.username,
  a.achievement_name,
  a.points_earned,
  a.category
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  (a.category, a.points_earned, a.achievement_name) IN (
    SELECT
      category,
      MAX(points_earned) AS max_points,
      MAX(achievement_name) AS max_achievement_name
    FROM
      achievements
    GROUP BY
      category
  )
ORDER BY
  a.category, a.achievement_name;
  
  
  
  
SELECT
  u.username,
  SUM(a.points_earned) AS total_points
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
GROUP BY
  u.user_id
ORDER BY
  total_points DESC
LIMIT 1;

SELECT
  u.username,
  a.category,
  MAX(a.points_earned) AS max_points
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
GROUP BY
  u.user_id, a.category
ORDER BY
  a.category, max_points DESC;
  

  SELECT
  u.username,
  a.points_earned,
  a.category
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  a.points_earned > 400;
  
SELECT
  a.achievement_name,
  COUNT(u.user_id) AS user_count
FROM
  achievements a
LEFT JOIN
  user u ON a.user_id = u.user_id
GROUP BY
  a.achievement_name
ORDER BY
  user_count ASC;
  
SELECT
  u.username,
  u.first_name,
  u.last_name,
  a.achievement_name,
  a.achievement_date
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  a.achievement_date BETWEEN 'start_date' AND 'end_date'
   LIMIT 5;
  
  SELECT
  u.username,
  b.Badge_Name
FROM
  user u
LEFT JOIN
  badge b ON u.user_id = b.user_id;
  
  
SELECT
  u.username,
  u.first_name,
  u.last_name,
  a.achievement_name,
  a.achievement_date
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  a.achievement_date BETWEEN '2023-01-15' AND '2023-02-15'
  LIMIT 5;
  
  SELECT
  a.achievement_name,
  COUNT(u.user_id) AS user_count
FROM
  achievements a
LEFT JOIN
  user u ON a.user_id = u.user_id
GROUP BY
  a.achievement_name
ORDER BY
  user_count ASC;
  
  
	SELECT
	  u.username,
	  u.first_name,
	  u.last_name,
	  a.achievement_name,
	  a.achievement_date
	FROM
	  user u
	JOIN
	  achievements a ON u.user_id = a.user_id
	GROUP BY
	  u.username, u.first_name, u.last_name,a.achievement_name, a.achievement_date
	HAVING
	  COUNT(u.user_id) <= 2
	  LIMIT 10;  -- Adjust the count based on your definition of "few"

SELECT
  u.username,
  u.first_name,
  u.last_name,
  a.achievement_name,
  a.achievement_date,
  MAX(a.points_earned) AS max_points_earned
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
GROUP BY
  u.username, u.first_name, u.last_name, a.achievement_name, a.achievement_date
HAVING
  COUNT(u.user_id) <= 2
ORDER BY
  max_points_earned DESC
LIMIT 10;  -- Adjust the count based on your definition of "few"


SELECT
  u.username,
  u.first_name,
  u.last_name,
  a.points_earned,
  a.category
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  (a.points_earned > 200 AND a.category = 'Waste Reduction Campaign')
  AND (a.points_earned > 300 AND a.category = 'Recycle and Vibe')
  AND (a.points_earned > 400 AND a.category = 'Beers and Peers');

SELECT
  u.username,
  u.user_id,
  a.points_earned,
  a.category
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  a.points_earned > 400
  LIMIT 5;
  
  WITH UserPoints AS (
  SELECT
    u.user_id,
    u.username,
    a.points_earned,
    a.category
  FROM
    user u
  JOIN
    achievements a ON u.user_id = a.user_id
)


SELECT
  username,
  MAX(points_earned) AS highest_points_earned
FROM
  UserPoints
GROUP BY
  username
LIMIT 10;


WITH UserPoints AS (
  SELECT
    u.user_id,
    u.username,
    u.first_name,
    u.last_name,
    a.points_earned,
    a.category,
    a.achievement_name,
    a.achievement_date
  FROM
    user u
  JOIN
    achievements a ON u.user_id = a.user_id
)
SELECT
  username,
  first_name,
  last_name,
  MAX(points_earned) AS highest_points_earned,
  category,
  achievement_name,
  achievement_date
FROM
  UserPoints
GROUP BY
  username, first_name, last_name, category, achievement_name, achievement_date
LIMIT 10;

WITH UserPoints AS (
  SELECT
    u.user_id,
    u.username,
    a.points_earned,
    a.category
  FROM
    user u
  JOIN
    achievements a ON u.user_id = a.user_id
)
SELECT
  category,
  username,
  MAX(points_earned) AS highest_points_in_category
FROM
  UserPoints
GROUP BY
  category, username
LIMIT 10;

WITH UserPoints AS (
  SELECT
    u.user_id,
    u.username,
    u.first_name,
    u.last_name,
    a.points_earned,
    a.category,
    a.achievement_name,
    a.achievement_date
  FROM
    user u
  JOIN
    achievements a ON u.user_id = a.user_id
)
SELECT
  category,
  username,
  first_name,
  last_name,
  MAX(points_earned) AS highest_points_in_category,
  achievement_name,
  achievement_date
FROM
  UserPoints
GROUP BY
  category, username, first_name, last_name, achievement_name, achievement_date
LIMIT 10;


WITH UserEvents AS (
  SELECT
    u.user_id,
    u.username,
    u.first_name,
    u.last_name,
    COUNT(e.event_id) AS events_attended,
    MAX(a.category) AS category,
    MAX(a.achievement_name) AS achievement_name,
    MAX(a.achievement_date) AS achievement_date
  FROM
    user u
  LEFT JOIN
    achievements a ON u.user_id = a.user_id
  LEFT JOIN
    events e ON a.achievement_name = e.event_name
  GROUP BY
    u.user_id, u.username
)
SELECT
  username,
  first_name,
  last_name,
  category,
  achievement_name,
  achievement_date,
  events_attended
FROM
  UserEvents
ORDER BY
  events_attended DESC
LIMIT 10;

SELECT
  u.username,
  u.user_id,
  a.points_earned,
  a.category
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  a.points_earned > 400
  LIMIT 5;
  
  
  SELECT
  u.username,
  u.first_name,
  u.last_name,
  a.achievement_name,
  a.achievement_date
FROM
  user u
JOIN
  achievements a ON u.user_id = a.user_id
WHERE
  a.achievement_date BETWEEN '2023-01-15' AND '2023-02-15'
  LIMIT 5;
  
  
WITH UserPoints AS (
  SELECT
    u.user_id,
    u.username,
    u.first_name,
    u.last_name,
    a.points_earned,
    a.category,
    a.achievement_name,
    a.achievement_date
  FROM
    user u
  JOIN
    achievements a ON u.user_id = a.user_id
)
SELECT
  username,
  first_name,
  last_name,
  MAX(points_earned) AS highest_points_earned,
  category,
  achievement_name,
  achievement_date
FROM
  UserPoints
GROUP BY
  username, first_name, last_name, category, achievement_name, achievement_date
LIMIT 5;
  
 	WITH UserPoints AS (
	  SELECT
	    u.user_id,
	    u.username,
	    u.first_name,
	    u.last_name,
	    a.points_earned,
	    a.category,
	    a.achievement_name,
	    a.achievement_date
	  FROM
	    user u
	  JOIN
	    achievements a ON u.user_id = a.user_id
	)
	SELECT
	  category,
	  username,
	  first_name,
	  last_name,
	  MAX(points_earned) AS highest_points_in_category,
	  achievement_name,
	  achievement_date
	FROM
	  UserPoints
	GROUP BY
	  category, username, first_name, last_name, achievement_name, achievement_date
	LIMIT 5;
    
    
 
 	WITH UserEvents AS (
	  SELECT
	    u.user_id,
	    u.username,
	    u.first_name,
	    u.last_name,
	    COUNT(e.event_id) AS events_attended,
	    MAX(a.category) AS category,
	    MAX(a.achievement_name) AS achievement_name,
	    MAX(a.achievement_date) AS achievement_date
	  FROM
	    user u
	  LEFT JOIN
	    achievements a ON u.user_id = a.user_id
	  LEFT JOIN
	    events e ON a.achievement_name = e.event_name
	  GROUP BY
	    u.user_id, u.username
	)
	SELECT
	  username,
	  first_name,
	  last_name,
	  category,
	  achievement_name,
	  achievement_date,
	  events_attended
	FROM
	  UserEvents
	ORDER BY
	  events_attended DESC
LIMIT 5;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  




























