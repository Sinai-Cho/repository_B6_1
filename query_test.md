### 1. DB 설치 확인, 샘플 데이터로 데이터 생성, db 활성화
1) DB 설치 확인
![](images/db설치확인.png)
2) 테이블 생성 및 스키마 지정
![](images/테이블생성.png)
3) 샘플데이터 입력
![](images/샘플데이터insert.png)
4) 외래키 활성화
![](images/db활성화_외래키활성화.png)

### 2. query test
1) 1번 쿼리 : 2020년 이후에 개봉한 영화를 확인
![](images/1번쿼리.png)
2) 2번 쿼리 : 러닝타임이 긴 영화부터 정렬
![](images/2번쿼리.png)
3) 3번 쿼리 : 평점이 9점 이상인 리뷰만 확인
![](images/3번쿼리.png)
4) 4번 쿼리 : 가장 최근에 본 영화 5편을 확인
![](images/4번쿼리.png)
5) 5번 쿼리 : 영화 제목과 장르 이름을 함께 확인
![](images/5번쿼리.png)
6) 6번 쿼리 : 리뷰 작성자와 영화 제목, 평점을 함께 확인
![](images/6번쿼리.png)
7) 7번 쿼리 : 모든 영화와 리뷰 개수를 확인
![](images/7번쿼리.png)
8) 8번 쿼리 : 사용자별로 작성한 리뷰와 영화 장르를 함께 확인
![](images/8번쿼리.png)
9) 9번 쿼리 : 장르별 영화 개수를 센다
![](images/9번쿼리.png)
10) 10번 쿼리 : 영화별 평균 평점을 계산
![](images/10번쿼리.png)
11) 11번 쿼리 : 사용자별 평점 합계와 리뷰 수를 확인
![](images/11번쿼리.png)
12) 12번 쿼리 : 전체 평균보다 높은 평점의 리뷰를 찾는다
![](images/12번쿼리.png)
13) 13번 쿼리 : 인덱스: 영화 제목 검색 속도를 높이기 위해 인덱스를 만든다.
-- 적용 이유: title 컬럼으로 영화를 자주 검색할 때 전체 행을
-- 하나씩 확인하는 비용을 줄일 수 있다.
-- SQLite 전용 확인 명령 PRAGMA index_list 사용.
![](images/13번쿼리.png)
14) 14_1번 쿼리 : UPDATE: movie_id=1인 영화의 watched_date를 수정
-- watched_date를 수정 전 이미지 (테이블 데이터 확인)
![](images/14_1.png)
15) 14_2번 쿼리
-- watched_date를 수정 후 이미지
![](images/14_2.png)
16) 15_1번 쿼리 : DELETE: review_id=20인 리뷰를 삭제
-- review_id=20인 리뷰를 삭제 전 이미지
![](images/15_1.png)
17) 15_2번 쿼리
-- review_id=20인 리뷰를 삭제 후 이미지
![](images/15_2.png)

#### 위 이미지는 각 쿼리별로 한번씩 실제 테스트 진행하면서 캡쳐한 이미지
#### 아래 명령어를 통해 한번에 실행된 결과는 query_result.txt 파일로 저장
-- .output query_result.txt (실행 결과를 해당 파일에 저장)
-- .read 03_queries.sql (sql 파일 전체 실행)
-- .output stdout (결과 출력 위치를 다시 터미널로 변경)

#### 기타 사용 명령어
-- sql 접속 : sqlite3 practice_test.db
-- .headers on : 조회 결과에 컬럼명 표시
-- . mode column : 조회 결과를 열 단위로 정렬하기
-- .quit : sql 접속 종료