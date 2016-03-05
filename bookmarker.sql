CREATE TABLE bookmarks(
id SERIAL8 primary key,
name VARCHAR(255) not null,
url VARCHAR(255) not null,
genre VARCHAR(255)
);
