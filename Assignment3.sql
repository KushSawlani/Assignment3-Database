
--Tables Created 
--users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);

--tweets table
CREATE TABLE tweets (
    tweet_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    Tweeted_Time TIMESTAMP NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--likes table
CREATE TABLE likes (
    like_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    tweet_id INTEGER NOT NULL,
    Like_time TIMESTAMP NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (tweet_id) REFERENCES tweets(tweet_id)
);

--retweets table
CREATE TABLE retweets (
    retweet_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    original_tweet_id INTEGER NOT NULL,
    Retweet_Time TIMESTAMP NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (original_tweet_id) REFERENCES tweets(tweet_id)
);

--comments table
CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    tweet_id INTEGER UNIQUE NOT NULL,
    parent_comment_id INTEGER,
    Comment_time TIMESTAMP NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (tweet_id) REFERENCES tweets(tweet_id),
    FOREIGN KEY (parent_comment_id) REFERENCES tweets(tweet_id)
);

--followers table
CREATE TABLE followers (
    follower_id SERIAL PRIMARY KEY,
    following_user_id INTEGER NOT NULL,
    follower_user_id INTEGER NOT NULL,
    Follow_Time TIMESTAMP NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (following_user_id) REFERENCES users(user_id),
    FOREIGN KEY (follower_user_id) REFERENCES users(user_id)
);




-- Data to be Inserted in above tables


-- Users Table
INSERT INTO users (user_id, name, email, phone_number) VALUES
(1, 'Vander', 'vader@example.com', '9427727660'),
(2, 'Leia', 'leia@example.com', '9428063836'),
(3, 'Obi-Wan', 'obiwan@example.com', '8780230582');

-- Tweets Table
INSERT INTO tweets (tweet_id, user_id, content) VALUES
(1, 1, 'I find your lack of faith disturbing.'),
(2, 3, 'The Force will be with you. Always.'),
(3, 2, 'Help me, Obi-Wan Kenobi. You’re my only hope.');

-- Retweets Table
INSERT INTO retweets (retweet_id, user_id, original_tweet_id) VALUES
(1, 3, 1);

-- Likes Table
INSERT INTO likes (like_id, user_id, tweet_id) VALUES
(1, 2, 1);

-- Followers Table
INSERT INTO followers (follower_id, follower_user_id, following_user_id) VALUES
(1, 1, 2),
(2, 2, 3);

-- Comments Table
INSERT INTO comments (comment_id, tweet_id, parent_comment_id) VALUES
(1, 1, NULL),
(2, 2, NULL),
(3, 3, 2);




-->All Queries 

1)Fetch all users' names from the database:

-->SELECT name FROM users;

2)Fetch all tweets of a user by user id, most recent tweets first:

SELECT tweets.content, tweets.Tweeted_Time, users.name
FROM tweets
JOIN users ON tweets.user_id = users.user_id
WHERE tweets.user_id = 1  -- Change with the user_id you are interested in
ORDER BY tweets.Tweeted_Time DESC;

3)Fetch like count of a particular tweet by tweet id

SELECT COUNT(*) AS like_count
FROM likes
WHERE tweet_id = 1; -- Change with the tweet_id you are interested in

4)Fetch retweet count of a particular tweet by tweet id:

SELECT COUNT(*) AS retweet_count
FROM retweets
WHERE original_tweet_id = 1; -- Change with the original_tweet_id you are interested in

5)Fetch comment count of a particular tweet by tweet id:

SELECT COUNT(*) AS comment_count
FROM comments
WHERE tweet_id = 1; -- Replace with the tweet_id you are interested in

6)Fetch all users' names who have retweeted a particular tweet by tweet id:

SELECT users.name
FROM retweets
JOIN users ON retweets.user_id = users.user_id
WHERE retweets.original_tweet_id = 1; -- Replace with the original_tweet_id you are interested in

7)Fetch all commented tweet’s content for a particular tweet by tweet id:

SELECT comments.comment_id, comments.Comment_time, tweets.content, users.name
FROM comments
JOIN tweets ON comments.tweet_id = tweets.tweet_id
JOIN users ON tweets.user_id = users.user_id
WHERE comments.tweet_id = 1; -- Replace with the tweet_id you are interested in

8)Fetch user’s timeline (All tweets from users whom I am following with tweet content and user name who has tweeted it):

SELECT tweets.content, tweets.Tweeted_Time, users.name
FROM tweets
JOIN followers ON tweets.user_id = followers.following_user_id
JOIN users ON tweets.user_id = users.user_id
WHERE followers.follower_user_id = 1 -- Replace with your user_id
ORDER BY tweets.Tweeted_Time DESC;




