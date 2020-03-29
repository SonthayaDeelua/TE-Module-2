-- Select every column from users where the user's role is manager

SELECT * FROM users WHERE role = 'manager';

-- Select name and created from posts where the post's body isn't null and the post was created in Aug. 2019

SELECT  name, created FROM posts WHERE posts IS NOT NULL AND created BETWEEN '2019-08-01' AND '2019-08-31'; 

-- Select first_name and email from users, ordered by created, latest first

SELECT first_name, email FROM users WHERE email IS NOT NULL ORDER BY email DESC;

-- Select published date from posts and a count of all the posts published/not published

SELECT created, COUNT(*)  FROM posts GROUP BY created , published;

-- Select the user's first_name, last_name, and email and the name of the post for all posts created after Oct. 1st 2019

SELECT users.first_name, users.last_name, users.email, posts.name  from users JOIN posts ON users.id = posts.user_id 
        WHERE posts.created = '2019-10-01'GROUP BY 
        users.first_name, users.last_name, users.email, posts.name ;

