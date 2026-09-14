-- =========================================================
-- 03_queries.sql
-- 핵심 SQL 15개
-- DB: SQLite
-- =========================================================

PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------
-- 1. 기본 조회: 2020년 이후에 개봉한 영화를 확인한다.
-- WHERE 사용
-- ---------------------------------------------------------
SELECT movie_id, title, release_year
FROM movie
WHERE release_year >= 2020;

-- ---------------------------------------------------------
-- 2. 기본 조회: 러닝타임이 긴 영화부터 정렬한다.
-- ORDER BY 사용
-- ---------------------------------------------------------
SELECT movie_id, title, runtime_min
FROM movie
ORDER BY runtime_min DESC;

-- ---------------------------------------------------------
-- 3. 기본 조회: 평점이 9점 이상인 리뷰만 확인한다.
-- WHERE + ORDER BY 사용
-- ---------------------------------------------------------
SELECT review_id, movie_id, rating, review_text
FROM review
WHERE rating >= 9.0
ORDER BY rating DESC, review_id ASC;

-- ---------------------------------------------------------
-- 4. 기본 조회: 가장 최근에 본 영화 5편을 확인한다.
-- ORDER BY + LIMIT 사용
-- ---------------------------------------------------------
SELECT movie_id, title, watched_date
FROM movie
ORDER BY watched_date DESC
LIMIT 5;

-- ---------------------------------------------------------
-- 5. INNER JOIN: 영화 제목과 장르 이름을 함께 확인한다.
-- ---------------------------------------------------------
SELECT m.movie_id, m.title, g.genre_name
FROM movie AS m
INNER JOIN genre AS g
    ON m.genre_id = g.genre_id
ORDER BY m.movie_id;

-- ---------------------------------------------------------
-- 6. INNER JOIN: 리뷰 작성자와 영화 제목, 평점을 함께 확인한다.
-- ---------------------------------------------------------
SELECT u.nickname, m.title, r.rating
FROM review AS r
INNER JOIN user AS u
    ON r.user_id = u.user_id
INNER JOIN movie AS m
    ON r.movie_id = m.movie_id
ORDER BY r.review_id;

-- ---------------------------------------------------------
-- 7. LEFT JOIN: 모든 영화와 리뷰 개수를 확인한다.
-- 리뷰가 없는 영화도 결과에 포함된다.
-- ---------------------------------------------------------
SELECT m.movie_id, m.title, COUNT(r.review_id) AS review_count
FROM movie AS m
LEFT JOIN review AS r
    ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
ORDER BY m.movie_id;

-- ---------------------------------------------------------
-- 8. JOIN: 사용자별로 작성한 리뷰와 영화 장르를 함께 확인한다.
-- ---------------------------------------------------------
SELECT u.nickname, m.title, g.genre_name, r.rating
FROM review AS r
INNER JOIN user AS u
    ON r.user_id = u.user_id
INNER JOIN movie AS m
    ON r.movie_id = m.movie_id
INNER JOIN genre AS g
    ON m.genre_id = g.genre_id
ORDER BY u.user_id, r.review_id;

-- ---------------------------------------------------------
-- 9. 집계: 장르별 영화 개수를 센다.
-- COUNT + GROUP BY
-- ---------------------------------------------------------
SELECT g.genre_name, COUNT(m.movie_id) AS movie_count
FROM genre AS g
LEFT JOIN movie AS m
    ON g.genre_id = m.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY movie_count DESC, g.genre_name;

-- ---------------------------------------------------------
-- 10. 집계: 영화별 평균 평점을 계산한다.
-- AVG + GROUP BY
-- ---------------------------------------------------------
SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM movie AS m
INNER JOIN review AS r
    ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
ORDER BY avg_rating DESC, m.title;

-- ---------------------------------------------------------
-- 11. 집계: 사용자별 평점 합계와 리뷰 수를 확인한다.
-- SUM + COUNT + GROUP BY
-- ---------------------------------------------------------
SELECT u.nickname,
       COUNT(r.review_id) AS review_count,
       SUM(r.rating) AS total_rating
FROM app_user AS u
LEFT JOIN review AS r
    ON u.user_id = r.user_id
GROUP BY u.user_id, u.nickname
ORDER BY total_rating DESC;

-- ---------------------------------------------------------
-- 12. 서브쿼리: 전체 평균보다 높은 평점의 리뷰를 찾는다.
-- ---------------------------------------------------------
SELECT review_id, movie_id, rating
FROM review
WHERE rating > (
    SELECT AVG(rating)
    FROM review
)
ORDER BY rating DESC, review_id;

-- ---------------------------------------------------------
-- 13. 인덱스: 영화 제목 검색 속도를 높이기 위해 인덱스를 만든다.
-- 적용 이유: title 컬럼으로 영화를 자주 검색할 때 전체 행을
-- 하나씩 확인하는 비용을 줄일 수 있다.
-- SQLite 전용 확인 명령 PRAGMA index_list 사용.
-- ---------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_movie_title
ON movie(title);

PRAGMA index_list('movie');

-- ---------------------------------------------------------
-- 14. UPDATE: movie_id=1인 영화의 watched_date를 수정한다.
-- ---------------------------------------------------------
UPDATE movie
SET watched_date = '2026-09-01'
WHERE movie_id = 1;

SELECT movie_id, title, watched_date
FROM movie
WHERE movie_id = 1;

-- ---------------------------------------------------------
-- 15. DELETE: review_id=20인 리뷰를 삭제한다.
-- ---------------------------------------------------------
DELETE FROM review
WHERE review_id = 20;

SELECT review_id, user_id, movie_id, rating
FROM review
WHERE review_id = 20;
