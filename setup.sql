-- ─────────────────────────────────────────────────────────────────────────────
-- NewsNest — Database Setup Script
-- Run this ONCE before starting the application
-- ─────────────────────────────────────────────────────────────────────────────

CREATE DATABASE IF NOT EXISTS newsnest
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE newsnest;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id    INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100)  NOT NULL,
    email      VARCHAR(150)  NOT NULL UNIQUE,
    password   VARCHAR(255)  NOT NULL,   -- BCrypt hash
    created_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- Categories reference table
CREATE TABLE IF NOT EXISTS categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- Seed the seven categories
INSERT IGNORE INTO categories (category_name) VALUES
    ('business'),
    ('entertainment'),
    ('general'),
    ('health'),
    ('science'),
    ('sports'),
    ('technology');

-- Per-user preferences
CREATE TABLE IF NOT EXISTS user_preferences (
    pref_id     INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (user_id)     REFERENCES users(user_id)      ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE,
    UNIQUE KEY uq_user_category (user_id, category_id)
);

-- Click / activity log
CREATE TABLE IF NOT EXISTS user_activity (
    activity_id   INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT          NOT NULL,
    article_title VARCHAR(500) NOT NULL,
    article_url   TEXT         NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    source        VARCHAR(200) DEFAULT 'Unknown',
    image_url     TEXT,
    click_time    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

SELECT 'Database setup complete!' AS status;
