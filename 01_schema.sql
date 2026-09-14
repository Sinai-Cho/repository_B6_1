-- =========================================================
-- 01_schema.sql
-- 주제: 내가 본 영화 정보 저장
-- DB: SQLite
-- =========================================================

-- SQLite 전용 설정:
-- 외래키(FK) 제약조건을 실제로 동작시키기 위해 활성화합니다.
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS user;

-- 1. 사용자 테이블
CREATE TABLE app_user (
    user_id     INTEGER PRIMARY KEY,
    username    TEXT NOT NULL UNIQUE,
    nickname    TEXT NOT NULL,
    created_at  TEXT NOT NULL
);

-- 2. 장르 테이블
CREATE TABLE genre (
    genre_id    INTEGER PRIMARY KEY,
    genre_name  TEXT NOT NULL UNIQUE
);

-- 3. 영화 테이블
-- 관계: genre 1 : N movie
CREATE TABLE movie (
    movie_id        INTEGER PRIMARY KEY,
    title           TEXT NOT NULL,
    release_year    INTEGER NOT NULL CHECK (release_year >= 1900),
    runtime_min     INTEGER NOT NULL CHECK (runtime_min > 0),
    genre_id        INTEGER NOT NULL,
    watched_date    TEXT,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- 4. 리뷰 테이블
-- 관계: app_user 1 : N review
-- 관계: movie 1 : N review
CREATE TABLE review (
    review_id    INTEGER PRIMARY KEY,
    user_id      INTEGER NOT NULL,
    movie_id     INTEGER NOT NULL,
    rating       REAL NOT NULL CHECK (rating >= 0 AND rating <= 10),
    review_text  TEXT,
    created_at   TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    UNIQUE (user_id, movie_id)
);
