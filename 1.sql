-- language: sql
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_age INT NOT NULL,
    user_level INT NOT NULL
);
--here there will be ALL the users identified (unequivocamente (don't know this word in English)) by its primary key (user_id).


CREATE TABLE trophies(
    trophy_id SERIAL PRIMARY KEY,
    trophy_name VARCHAR(50) NOT NULL
);
--here there will be ALL the trophies identified with a serial primary key (trophy_id).


CREATE TABLE user_trophies(
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    trophy_id INT REFERENCES trophies(trophy_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, trophy_id) 
);
--this table conects two tables in order to create a table that will contain the users with their trophies.





--QUERIES HERE to fill and mofify each one of the tables:


INSERT INTO users (user_id, user_name, user_age, user_level) VALUES
(DEFAULT, "John Doe", 30, 1)
(DEFAULT, 'Bob Jones', 28, 4),
(DEFAULT, 'Alice Johnson', 35, 5);


INSERT INTO trophies (trophy_id, trophy_name) VALUES
(DEFAULT, 'Gold Medal'),
(DEFAULT, 'Silver Cup'),
(DEFAULT, 'Bronze Plaque');

INSERT INTO user_trophies (user_id, trophy_id) VALUES
(1, 1),  -- John Doe won the Gold Medal
(2, 2),  -- Jane Smith won the Silver Cup
(3, 3),  -- Bob Jones won the Bronze Plaque
(1, 2),  -- John Doe won the Silver Cup
(2, 3),  -- Jane Smith won the Bronze Plaque
(3, 1);  -- Bob Jones won the Gold Medal



SELECT AVG(user_age) AS average_age FROM users;



SELECT COUNT(*) AS total_trophies FROM trophies;



SELECT * FROM users
ORDER BY user_level DESC
LIMIT 1;



SELECT t.trophy_name, COUNT(ut.trophy_id) AS won_count
FROM trophies t
JOIN user_trophies ut ON t.trophy_id = ut.trophy_id
GROUP BY t.trophy_name
ORDER BY won_count DESC
LIMIT 1;



SELECT u.user_name, u.user_age, u.user_level, t.trophy_name
FROM users u
JOIN user_trophies ut ON u.user_id = ut.user_id
JOIN trophies t ON ut.trophy_id = t.trophy_id;



UPDATE users
SET user_level = user_level + 1
WHERE user_name = 'Alice Johnson';



DELETE FROM trophies
WHERE trophy_name = 'Bronze Plaque';



INSERT INTO trophies (trophy_name) VALUES
(DEFAULT, 'Platinum Trophy');



SELECT u.user_name, COUNT(ut.trophy_id) AS total_trophies_won
FROM users u
LEFT JOIN user_trophies ut ON u.user_id = ut.user_id
GROUP BY u.user_name;



SELECT u.user_name
FROM users u
JOIN user_trophies ut ON u.user_id = ut.user_id
WHERE ut.trophy_id = (SELECT trophy_id FROM trophies WHERE trophy_name = 'Gold Medal');

