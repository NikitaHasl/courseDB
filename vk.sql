DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone BIGINT UNSIGNED UNIQUE,
    password_hash VARCHAR(255),
    
    INDEX idx_users_username(firstname, lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    gender CHAR(1),
    hometown VARCHAR(100),
    created_at DATETIME DEFAULT NOW(),
    CONSTRAINT fk_profile_user_id 
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

ALTER TABLE profiles ADD COLUMN birthday DATETIME;

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests(
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    status ENUM('requested', 'approved', 'declined', 'unfriended'),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id),
    CHECK (initiator_user_id != target_user_id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
    name VARCHAR(255),
    admin_user_id BIGINT UNSIGNED NOT NULL,
    INDEX(name),
    FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
    user_id BIGINT UNSIGNED NOT NULL,
    community_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_type BIGINT UNSIGNED NOT NULL,
    body TEXT,
    filename VARCHAR(255),
    metadata JSON,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL
);