import sqlite3

DB_NAME = "movies.db"


# -----------------------------
# 1. DB 연결 + 테이블 만들기
# -----------------------------
def create_table():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS movies (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            year INTEGER,
            genre TEXT,
            rating REAL,
            review TEXT
        )
    """)

    conn.commit()
    conn.close()


# -----------------------------
# 2. 영화 추가하기
# -----------------------------
def add_movie():
    print("\n[영화 추가]")

    title = input("영화 제목: ").strip()
    if title == "":
        print("영화 제목은 꼭 입력해야 합니다.")
        return

    year_text = input("개봉 연도(예: 2024): ").strip()
    genre = input("장르(예: 애니메이션): ").strip()
    rating_text = input("내 평점(0~10): ").strip()
    review = input("한 줄 감상평: ").strip()

    # 숫자 입력 확인
    try:
        year = int(year_text)
    except ValueError:
        print("개봉 연도는 숫자로 입력해야 합니다.")
        return

    try:
        rating = float(rating_text)
    except ValueError:
        print("평점은 숫자로 입력해야 합니다.")
        return

    if rating < 0 or rating > 10:
        print("평점은 0점부터 10점 사이로 입력해야 합니다.")
        return

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO movies (title, year, genre, rating, review)
        VALUES (?, ?, ?, ?, ?)
    """, (title, year, genre, rating, review))

    conn.commit()
    conn.close()

    print("영화 정보가 저장되었습니다.")


# -----------------------------
# 3. 전체 영화 보기
# -----------------------------
def show_movies():
    print("\n[저장된 영화 목록]")

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, title, year, genre, rating, review
        FROM movies
        ORDER BY id
    """)

    movies = cursor.fetchall()
    conn.close()

    if len(movies) == 0:
        print("아직 저장된 영화가 없습니다.")
        return

    print("-" * 70)

    for movie in movies:
        print("번호:", movie[0])
        print("제목:", movie[1])
        print("연도:", movie[2])
        print("장르:", movie[3])
        print("평점:", movie[4])
        print("감상평:", movie[5])
        print("-" * 70)


# -----------------------------
# 4. 제목으로 영화 검색하기
# -----------------------------
def search_movie():
    print("\n[영화 검색]")

    keyword = input("검색할 영화 제목: ").strip()

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id, title, year, genre, rating, review
        FROM movies
        WHERE title LIKE ?
        ORDER BY id
    """, ("%" + keyword + "%",))

    movies = cursor.fetchall()
    conn.close()

    if len(movies) == 0:
        print("검색 결과가 없습니다.")
        return

    for movie in movies:
        print("-" * 70)
        print("번호:", movie[0])
        print("제목:", movie[1])
        print("연도:", movie[2])
        print("장르:", movie[3])
        print("평점:", movie[4])
        print("감상평:", movie[5])


# -----------------------------
# 5. 평점 수정하기
# -----------------------------
def update_rating():
    print("\n[평점 수정]")

    try:
        movie_id = int(input("수정할 영화 번호: "))
        new_rating = float(input("새 평점(0~10): "))
    except ValueError:
        print("영화 번호와 평점은 숫자로 입력해야 합니다.")
        return

    if new_rating < 0 or new_rating > 10:
        print("평점은 0점부터 10점 사이로 입력해야 합니다.")
        return

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute(
        "UPDATE movies SET rating = ? WHERE id = ?",
        (new_rating, movie_id)
    )

    conn.commit()

    if cursor.rowcount == 0:
        print("해당 번호의 영화가 없습니다.")
    else:
        print("평점이 수정되었습니다.")

    conn.close()


# -----------------------------
# 6. 영화 삭제하기
# -----------------------------
def delete_movie():
    print("\n[영화 삭제]")

    try:
        movie_id = int(input("삭제할 영화 번호: "))
    except ValueError:
        print("영화 번호는 숫자로 입력해야 합니다.")
        return

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    cursor.execute(
        "DELETE FROM movies WHERE id = ?",
        (movie_id,)
    )

    conn.commit()

    if cursor.rowcount == 0:
        print("해당 번호의 영화가 없습니다.")
    else:
        print("영화 정보가 삭제되었습니다.")

    conn.close()


# -----------------------------
# 7. 메뉴
# -----------------------------
def show_menu():
    print("\n==============================")
    print(" 내가 본 영화 정보 저장")
    print("==============================")
    print("1. 영화 추가")
    print("2. 전체 영화 보기")
    print("3. 영화 검색")
    print("4. 평점 수정")
    print("5. 영화 삭제")
    print("0. 종료")
    print("==============================")


# -----------------------------
# 8. 프로그램 시작
# -----------------------------
def main():
    create_table()

    while True:
        show_menu()

        choice = input("메뉴 번호 선택: ").strip()

        if choice == "1":
            add_movie()

        elif choice == "2":
            show_movies()

        elif choice == "3":
            search_movie()

        elif choice == "4":
            update_rating()

        elif choice == "5":
            delete_movie()

        elif choice == "0":
            print("프로그램을 종료합니다.")
            break

        else:
            print("0~5 사이의 메뉴 번호를 입력해주세요.")


if __name__ == "__main__":
    main()
