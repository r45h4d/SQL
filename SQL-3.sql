CREATE TABLE authors
(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(128),
	last_name VARCHAR(128),
	email VARCHAR(256),
	created_at TIMESTAMP
);

CREATE TABLE posts
(
	id SERIAL PRIMARY KEY,
	title VARCHAR(256),
	created_at TIMESTAMP,
	update_at TIMESTAMP
);

ALTER TABLE authors
ADD COLUMN about TEXT;

ALTER TABLE authors
ADD COLUMN nick VARCHAR(128);

CREATE TABLE authorpost
(
	id SERIAL PRIMARY KEY,
	author_id INTEGER REFERENCES authors(id),
	post_id INTEGER REFERENCES posts(id),
	created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE authors
ALTER COLUMN created_at SET DEFAULT NOW();

CREATE TABLE subscribers
(
	id SERIAL PRIMARY KEY,
	email VARCHAR(256)
);

ALTER TABLE authors
ADD CONSTRAINT unique_nick_constraint UNIQUE (nick);

ALTER TABLE authors
ADD CONSTRAINT unique_email_constraint UNIQUE (email);

ALTER TABLE posts
ADD COLUMN image_url TEXT;

CREATE TABLE tags
(
	id SERIAL PRIMARY KEY,
	tag VARCHAR(256),
	created_at TIMESTAMP
);

CREATE TABLE posttag
(
	id SERIAL PRIMARY KEY,
	post_id INTEGER REFERENCES posts(id),
	tag_id INTEGER REFERENCES tags(id)
);

CREATE INDEX idx_tag 
ON tags(tag);

ALTER TABLE authors
ADD COLUMN github VARCHAR(128);

ALTER TABLE authors
ADD COLUMN update_at TIMESTAMP;

CREATE VIEW authors_posts_view AS
SELECT a.nick AS author_nick,
	   p.title AS post_title,
       p.created_at AS post_created_at
FROM authors a
JOIN authorpost ap 
	ON a.id=ap.author_id
JOIN posts p 
	ON ap.post_id=p.id;

ALTER TABLE subscribers
ALTER COLUMN email SET NOT NULL;

-- ONE TO ONE subscribers -> subscriber_details
CREATE TABLE subscriber_details (
    id SERIAL PRIMARY KEY,
    subscriber_id INTEGER UNIQUE NOT NULL REFERENCES subscribers(id),
    full_name VARCHAR(100),
    address TEXT,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    subscription_start DATE
);

-- ONE TO MANY authors -> author_connections
CREATE TABLE author_connections (
    id SERIAL PRIMARY KEY,
    author_id INTEGER NOT NULL REFERENCES authors(id),
    connected_author_id INTEGER NOT NULL REFERENCES authors(id),
    connection_type VARCHAR(50),
    connection_date TIMESTAMP DEFAULT NOW()
);

COMMENT ON COLUMN author_connections.connection_type IS 'specify or categorize the type of connection between authors (friend, follower and etc.)'