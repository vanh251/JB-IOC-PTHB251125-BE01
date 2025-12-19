
set search_path to test01;

CREATE TABLE book (
                      book_id SERIAL PRIMARY KEY,
                      title VARCHAR(255),
                      author VARCHAR(100),
                      genre VARCHAR(50),
                      price DECIMAL(10,2),
                      description TEXT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO book (title, author, genre, price, description)
SELECT
    'Book Title ' || i,
    CASE WHEN i % 5 = 0 THEN 'J.K. Rowling' ELSE 'Author ' || (i % 1000) END,
    CASE WHEN i % 3 = 0 THEN 'Fantasy' ELSE 'Science' END,
    (random() * 100)::DECIMAL(10,2),
    'This is a description for book number ' || i
FROM generate_series(1, 500000) AS i;

EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';

CREATE INDEX idx_book_genre ON book(genre);
CREATE INDEX idx_book_title_gin ON book USING GIN (to_tsvector('english', title));

EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
EXPLAIN ANALYZE SELECT * FROM book WHERE to_tsvector('english', title) @@ to_tsquery('english', 'Title & 100');

CLUSTER book USING idx_book_genre;
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';

/* === BAO CAO KET QUA ===

1. Hieu qua cua Index:
- Truoc Index: Truy van su dung "Seq Scan" tren toan bo 500k dong, toc do cham.
- Sau Index: Truy van chuyen sang "Bitmap Heap Scan" hoac "Index Scan", toc do cai thien ro ret.
- Sau Cluster: Toc do truy van genre nhanh nhat do du lieu duoc sap xep vat ly lien ke, giam thieu thao tac doc o cung (I/O).

2. Loai Index hieu qua nhat:
- B-tree: Hieu qua nhat cho cot 'genre' voi cac truy van so sanh bang (=) hoac pham vi (<, >).
- GIN: Hieu qua nhat cho Full-text search tren cot 'title' hoac 'description' (du lieu van ban lon).

3. Khi nao khong nen dung Hash Index:
- Khi can truy van theo pham vi (Range queries: >, <, BETWEEN). Hash Index chi ho tro so sanh bang (=).
- Khi can sap xep ket qua (ORDER BY), vi Hash Index khong luu tru theo thu tu.
- Hash Index truoc day (ban cu) khong an toan khi crash (not WAL-logged), mac du ban moi da cai thien nhung B-tree van da dung hon.
*/
