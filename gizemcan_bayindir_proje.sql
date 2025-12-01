CREATE DATABASE library_db;
drop DATABASE library_db;

SELECT datname FROM pg_database;




CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL, ---burada name boş olmaması gerektiği için not null yazdık.
    biography TEXT
);

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL REFERENCES authors(author_id),
    publisher_id INT NOT NULL REFERENCES publishers(publisher_id),
    category_id INT NOT NULL REFERENCES categories(category_id),
    stock INT DEFAULT 0,
    published_year INT
);

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    join_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INT NOT NULL REFERENCES books(book_id),
    member_id INT NOT NULL REFERENCES members(member_id),
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE
);

CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    book_id INT NOT NULL REFERENCES books(book_id),
    member_id INT NOT NULL REFERENCES members(member_id),
    reservation_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'reserved'
);

CREATE TABLE fines (
    fine_id SERIAL PRIMARY KEY,
    loan_id INT UNIQUE REFERENCES loans(loan_id),
    amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------
-- 1) authors tablosu
-- -------------------------
INSERT INTO authors (name, biography) VALUES
('J.K. Rowling', 'Harry Potter serisinin yazarı'),
('George Orwell', '1984 ve Hayvan Çiftliği kitaplarının yazarı'),
('Stephen King', 'Korku ve gerilim yazarı'),
('Agatha Christie', 'Suç ve gizem romanları yazarı'),
('J.R.R. Tolkien', 'Yüzüklerin Efendisi ve Hobbit’in yazarı'),
('Isaac Asimov', 'Bilim kurgu yazarı'),
('Mark Twain', 'Macera ve mizah yazarı'),
('Jane Austen', 'Klasik İngiliz edebiyatı yazarı'),
('Ernest Hemingway', 'Modern Amerikan edebiyatı yazarı'),
('Leo Tolstoy', 'Savaş ve Barış’ın yazarı');

-- -------------------------
-- 2) publishers tablosu
-- -------------------------
INSERT INTO publishers (name, address) VALUES
('Penguin Random House', 'New York, USA'),
('HarperCollins', 'New York, USA'),
('Macmillan', 'London, UK'),
('Hachette Livre', 'Paris, France'),
('Simon & Schuster', 'New York, USA'),
('Oxford University Press', 'Oxford, UK'),
('Scholastic', 'New York, USA'),
('Bloomsbury', 'London, UK'),
('Scribner', 'New York, USA'),
('Vintage Books', 'New York, USA');

-- -------------------------
-- 3) categories tablosu
-- -------------------------
INSERT INTO categories (name) VALUES
('Fantasy'),
('Science Fiction'),
('Mystery'),
('Horror'),
('Romance'),
('Adventure'),
('Historical'),
('Thriller'),
('Comedy'),
('Classic');

-- -------------------------
-- 4) books tablosu
-- -------------------------
INSERT INTO books (title, author_id, publisher_id, category_id, stock, published_year) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 7, 1, 5, 1997),
('1984', 2, 1, 2, 3, 1949),
('The Shining', 3, 2, 4, 2, 1977),
('Murder on the Orient Express', 4, 3, 3, 4, 1934),
('The Hobbit', 5, 8, 1, 6, 1937),
('Foundation', 6, 5, 2, 3, 1951),
('Adventures of Huckleberry Finn', 7, 6, 6, 2, 1884),
('Pride and Prejudice', 8, 4, 5, 5, 1813),
('The Old Man and the Sea', 9, 9, 7, 3, 1952),
('War and Peace', 10, 10, 7, 1, 1869);

-- -------------------------
-- 5) members tablosu
-- -------------------------
INSERT INTO members (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '555-1234'),
('Bob Smith', 'bob@example.com', '555-5678'),
('Charlie Brown', 'charlie@example.com', '555-8765'),
('Diana Prince', 'diana@example.com', '555-4321'),
('Ethan Hunt', 'ethan@example.com', '555-9876'),
('Fiona Gallagher', 'fiona@example.com', '555-6543'),
('George Martin', 'george@example.com', '555-3456'),
('Hannah Baker', 'hannah@example.com', '555-2345'),
('Ian Fleming', 'ian@example.com', '555-1111'),
('Jane Eyre', 'jane@example.com', '555-2222');

-- -------------------------
-- 6) loans tablosu
-- -------------------------
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 1, '2025-11-01', '2025-11-15', NULL),
(2, 2, '2025-11-03', '2025-11-17', '2025-11-16'),
(3, 3, '2025-11-05', '2025-11-19', NULL),
(4, 4, '2025-11-07', '2025-11-21', '2025-11-20'),
(5, 5, '2025-11-09', '2025-11-23', NULL),
(6, 6, '2025-11-11', '2025-11-25', NULL),
(7, 7, '2025-11-13', '2025-11-27', '2025-11-26'),
(8, 8, '2025-11-15', '2025-11-29', NULL),
(9, 9, '2025-11-17', '2025-12-01', NULL),
(10, 10, '2025-11-19', '2025-12-03', NULL);

-- -------------------------
-- 7) reservations tablosu
-- -------------------------
INSERT INTO reservations (book_id, member_id, reservation_date, status) VALUES
(1, 2, '2025-11-02', 'reserved'),
(3, 4, '2025-11-06', 'reserved'),
(5, 1, '2025-11-10', 'reserved'),
(7, 5, '2025-11-14', 'reserved'),
(2, 3, '2025-11-04', 'reserved'),
(4, 6, '2025-11-08', 'reserved'),
(6, 7, '2025-11-12', 'reserved'),
(8, 9, '2025-11-16', 'reserved'),
(9, 10, '2025-11-18', 'reserved'),
(10, 8, '2025-11-20', 'reserved');

-- -------------------------
-- 8) fines tablosu
-- -------------------------
INSERT INTO fines (loan_id, amount) VALUES
(2, 5.00),
(4, 2.50),
(7, 3.00);

-- ######################################################################
-- # EK VERİ EKLEME (Kompleks Sorguları Test Etmek İçin)
-- ######################################################################

-- Ek Yazarlar
INSERT INTO authors (name, biography) VALUES
('Gabriel Garcia Marquez', 'Nobel ödüllü Kolombiyalı yazar'), -- Yeni ID: 11
('Mustafa Kutlu', 'Türk hikaye yazarı'); -- Yeni ID: 12

-- Ek Kitaplar (books)
INSERT INTO books (title, author_id, publisher_id, category_id, stock, published_year) VALUES
('Yüzyıllık Yalnızlık', 11, 4, 1, 4, 1967), -- Yeni ID: 11 (Romance/Fantasy)
('Uzun Hikaye', 12, 1, 10, 5, 2000), -- Yeni ID: 12 (Classic/Historical)
('Küçük Prens', 1, 3, 6, 8, 1943); -- Yeni ID: 13 (Adventure/Fantasy)

-- Ek Üyeler (members)
INSERT INTO members (name, email, phone) VALUES
('Kerem Atilla', 'kerem@example.com', '555-3333'), -- Yeni ID: 11
('Leyla Güneş', 'leyla@example.com', '555-4444'); -- Yeni ID: 12

-- ######################################################################
--  BENZERSİZ YENİ VERİLER EKLEME (En az 10 ek kayıt)
-- ######################################################################

-- Yeni Yazarlar (authors)

insert INTO authors (name, biography) VALUES
('Haruki Murakami', 'Japon yazar, sürrealizm ve yalnızlık temaları.'), -- Yeni ID 13
('Elif Shafak', 'Türk-İngiliz yazar, çok kültürlülük temaları.'),      -- Yeni ID 14
('Yuval Noah Harari', 'İsrailli tarihçi ve felsefeci, Sapiens yazarı.'),-- Yeni ID 15
('Toni Morrison', 'Nobel ödüllü Amerikalı yazar.'),                       -- Yeni ID 16
('Cemil Meriç', 'Türk düşünür ve yazar.');                               -- Yeni ID 17

-- Yeni Kategoriler (categories)
INSERT INTO categories (name) VALUES
('Felsefe'),      -- Yeni ID 11
('Biyografi'),    -- Yeni ID 12
('Anı/Deneme');   -- Yeni ID 13

-- Yeni Üyeler (members)
INSERT INTO members (name, email, phone) VALUES
('Nazlı Kara', 'nazli@example.com', '555-5555'), -- Yeni ID 13
('Okan Polat', 'okan@example.com', '555-6666');  -- Yeni ID 14


-- ######################################################################
-- # 1. FONKSİYONLAR (PL/pgSQL)
-- ######################################################################

--1. calculate_fine(loan_id) - Gecikme Cezasını Hesaplayan Fonksiyon yazalım.

--Günlük ceza miktarını $0.50$ olarak alalım.

--F1: Gecikme cezasını hesaplayan fonksiyon (Günlük 0.50 TL)
CREATE OR REPLACE FUNCTION calculate_fine(p_loan_id INT)
RETURNS NUMERIC AS $$
DECLARE
    v_due_date DATE;
    v_return_date DATE;
    v_delay_days INT;
    v_daily_rate CONSTANT NUMERIC(10, 2) := 0.50;
    v_fine_amount NUMERIC(10, 2);
BEGIN
    SELECT due_date, COALESCE(return_date, CURRENT_DATE) INTO v_due_date, v_return_date
    FROM loans
    WHERE loan_id = p_loan_id;

    IF NOT FOUND THEN
        RETURN 0.00;
    END IF;

    -- Gecikme gün sayısını hesapla
    v_delay_days := v_return_date - v_due_date;

    IF v_delay_days > 0 THEN
        v_fine_amount := v_delay_days * v_daily_rate;
        RETURN v_fine_amount;
    ELSE
        RETURN 0.00;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- F1 Test Sorgusu (Örnek verinizde loan_id 2 ve 4 gecikmeli iade edilmiş varsayılmıştır.)
-- Gecikmesiz bir kayıt için (loan_id 7, return_date '2025-11-26', due_date '2025-11-27' olduğu için -1 gün = 0 ceza döner)
-- SELECT calculate_fine(7);
-- Gecikme örneği için: loan_id 1 kaydının iade tarihini gecikmeli yapıp test edelim.
-- UPDATE loans SET return_date = '2025-12-05' WHERE loan_id = 1;
-- SELECT calculate_fine(1); -- 2025-11-15 due_date'e göre 20 gün gecikme = 10.00 TL ceza

*************************************


--2. book_availability(book_id) - Kitabın Müsaitlik Durumunu hesaplayalım.

-- F2: Kitabın müsait (stokta) olup olmadığını kontrol eden fonksiyon:
CREATE OR REPLACE FUNCTION book_availability(p_book_id INT)
RETURNS INT AS $$
DECLARE
    v_stock INT;
    v_borrowed INT;
BEGIN
    -- Toplam stok miktarını al
    SELECT stock INTO v_stock
    FROM books
    WHERE book_id = p_book_id;

    IF NOT FOUND THEN
        RETURN -1; -- Kitap bulunamadı
    END IF;

    -- Henüz iade edilmemiş ödünç sayısını bul
    SELECT COUNT(*) INTO v_borrowed
    FROM loans
    WHERE book_id = p_book_id AND return_date IS NULL;

    -- Müsait stok = Toplam stok - Ödünçteki kitaplar
    RETURN v_stock - v_borrowed;
END;
$$ LANGUAGE plpgsql;

-- F2 Test Sorgusu
-- SELECT book_availability(1); -- Harry Potter, loan_id 1 aktif ödünçte olmalı (stok 5, ödünç 1 -> 4 müsait)
-- SELECT book_availability(2); -- 1984, loan_id 2 iade edilmiş (stok 3, ödünç 0 -> 3 müsait)

**************************************************

--3. member_borrowed_count(member_id) - Üyenin Ödünç Aldığı Kitap Sayısını hesaplayan fonksiyon:



-- F3: Üyenin halen elinde tuttuğu (iade etmediği) kitap sayısını hesaplayan fonksiyon
CREATE OR REPLACE FUNCTION member_borrowed_count(p_member_id INT)
RETURNS INT AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM loans
    WHERE member_id = p_member_id AND return_date IS NULL;

    RETURN v_count;
END;
$$ LANGUAGE plpgsql;

-- F3 Test Sorgusu
-- SELECT member_borrowed_count(1); -- loan_id 1 aktif ödünçte
-- SELECT member_borrowed_count(2); -- loan_id 2 iade edildi


-- ######################################################################
-- # 2. TRIGGERLAR
-- ######################################################################


---1. Kitap ödünç alındığında stok miktarını düşüren trigger
-- T1 Fonksiyonu: Ödünç alındığında stok düşürme:

CREATE OR REPLACE FUNCTION trg_decrease_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE books
    SET stock = stock - 1
    WHERE book_id = NEW.book_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- T1 Tanımı: loans tablosuna yeni kayıt eklendiğinde çalışır
CREATE TRIGGER tr_loan_decrease_stock
AFTER INSERT ON loans
FOR EACH ROW
EXECUTE FUNCTION trg_decrease_stock();

******************************************************************************
--2. Kitap teslim edildiğinde stokları güncelleyen trigger:

-- T2 Fonksiyonu: İade edildiğinde stok artırma:

CREATE OR REPLACE FUNCTION trg_increase_stock()
RETURNS TRIGGER AS $$
BEGIN
    -- Yalnızca iade tarihi güncellendiğinde (NULL'dan bir tarihe geçtiğinde)
    -- ve eski hali NULL ise (ilk defa iade ediliyorsa)
    IF NEW.return_date IS NOT NULL AND OLD.return_date IS NULL THEN
        UPDATE books
        SET stock = stock + 1
        WHERE book_id = NEW.book_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- T2 Tanımı: loans tablosunda return_date sütunu güncellendiğinde çalışır
CREATE TRIGGER tr_return_increase_stock
AFTER UPDATE OF return_date ON loans
FOR EACH ROW
EXECUTE FUNCTION trg_increase_stock();


*****************************************************************
--3. İade yapıldığında gecikme varsa otomatik ceza kaydı oluşturan trigger:
-- T3 Fonksiyonu: Gecikmeli iadede otomatik ceza kaydı oluşturma:
-- T3 Fonksiyonu: Gecikmeli iadede otomatik ceza kaydı oluşturma
CREATE OR REPLACE FUNCTION trg_create_fine_on_return()
RETURNS TRIGGER AS $$
DECLARE
    v_fine_amount NUMERIC(10, 2);
BEGIN
    -- Yalnızca iade işlemi (return_date set edilmesi) tamamlandığında çalış
    IF NEW.return_date IS NOT NULL AND OLD.return_date IS NULL THEN
        -- Cezayı hesapla
        v_fine_amount := calculate_fine(NEW.loan_id);

        -- Eğer ceza miktarı > 0 ise ve bu kayıt için daha önce ceza oluşturulmamışsa
        IF v_fine_amount > 0 AND NOT EXISTS (SELECT 1 FROM fines WHERE loan_id = NEW.loan_id) THEN
            INSERT INTO fines (loan_id, amount)
            VALUES (NEW.loan_id, v_fine_amount);
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- T3 Tanımı: loans tablosunda return_date sütunu güncellendiğinde çalışır
CREATE TRIGGER tr_create_fine
AFTER UPDATE OF return_date ON loans
FOR EACH ROW
EXECUTE FUNCTION trg_create_fine_on_return();

-- Trigger Testleri için Ek Adımlar
-- 1. loans tablosuna yeni bir kayıt ekleyin (INSERT) -> tr_loan_decrease_stock çalışmalı.
-- 2. Yeni kaydın due_date'inden sonra bir return_date ile UPDATE yapın (UPDATE) -> tr_return_increase_stock ve tr_create_fine çalışmalı.


--##########################################################################
--# 3. STORED PROCEDURES (PROSEDÜRLER)
--##########################################################################

---Stored procedure yazalım.
--Store procedure ler veritabanı yönetim sisteminde (DBMS) depolanan ve gerektiğinde çağrılabilen önceden derlenmiş
--bir SQL ifadesi olarak tanımlanır ve veriyi çekme konusunda yarcımcı olur.

-- SP1: Kitap ödünç alma işlemi (Maksimum 3 kitap limiti koyalım her üye maksimum 3 kitap alabilsin.)
CREATE OR REPLACE PROCEDURE sp_borrow_book(
    p_member_id INT,
    p_book_id INT,
    p_due_days INT DEFAULT 14
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_available_count INT;
    v_borrowed_count INT;
    v_max_books CONSTANT INT := 3; -- Maksimum ödünç kitap limiti
BEGIN
    -- 1. Kitap müsaitlik ve limit kontrolü
    v_available_count := book_availability(p_book_id);
    v_borrowed_count := member_borrowed_count(p_member_id);

    IF v_available_count <= 0 THEN
        RAISE EXCEPTION 'Hata: Kitabın stoğu müsait değil (Müsait: %)', v_available_count;
    END IF;

    IF v_borrowed_count >= v_max_books THEN
        RAISE EXCEPTION 'Hata: Üye maksimum ödünç alma limitine ulaştı (Limit: %)', v_max_books;
    END IF;

    -- 2. Ödünç kaydını oluştur
    INSERT INTO loans (book_id, member_id, loan_date, due_date)
    VALUES (p_book_id, p_member_id, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day' * p_due_days);

    -- 3. Stok düşürme işlemi trigger tarafından otomatik yapılır (tr_loan_decrease_stock).

    RAISE NOTICE 'Bilgi: Kitap başarılı bir şekilde ödünç alındı.';

END;
$$;

-- SP1 Test Sorgusu
-- CALL sp_borrow_book(10, 3, 14); -- Üye 10, Kitap 3'ü ödünç alır
-- SELECT * FROM loans ORDER BY loan_id DESC LIMIT 1;
-- SELECT * FROM books WHERE book_id = 3; -- Stock 2'den 1'e düşmeliydi (Eski verinizden dolayı stok 2)

****************************************************
--2. sp_return_book() - Kitap İade İşlemi (Ceza Hesaplama Dahil bir procedure yazalım.

-- SP2: Kitap iade işlemi
CREATE OR REPLACE PROCEDURE sp_return_book(p_loan_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fine_amount NUMERIC(10, 2);
BEGIN
    -- 1. Aktif ödünç kaydını kontrol et
    IF NOT EXISTS (SELECT 1 FROM loans WHERE loan_id = p_loan_id AND return_date IS NULL) THEN
        RAISE EXCEPTION 'Hata: İade edilecek aktif bir ödünç kaydı bulunamadı (ID: %)', p_loan_id;
    END IF;

    -- 2. Ödünç kaydını iade edildi olarak güncelle
    UPDATE loans
    SET return_date = CURRENT_DATE
    WHERE loan_id = p_loan_id;

    -- 3. Stok artırma ve Ceza oluşturma trigger'ları otomatik çalışır.

    -- 4. Hesaplanan cezayı bildir (Gerekirse bu aşamada ceza bilgisini fine tablosundan çekebiliriz)
    v_fine_amount := calculate_fine(p_loan_id);

    IF v_fine_amount > 0 THEN
        RAISE NOTICE 'Uyarı: Kitap gecikmeli iade edildi. Ödenmesi gereken Ceza: % TL', v_fine_amount;
    ELSE
        RAISE NOTICE 'Bilgi: Kitap zamanında iade edildi.';
    END IF;

END;
$$;

-- SP2 Test Sorgusu (Ödünç kaydı 1'i bugün iade edelim. Due date: 2025-11-15. Gecikme olmalı.)
-- CALL sp_return_book(1);
-- SELECT * FROM loans WHERE loan_id = 1;
-- SELECT * FROM fines WHERE loan_id = 1; -- Yeni ceza kaydı oluşmuş olmalı


-- ######################################################################
-- # 4. VIEW'LAR
-- ######################################################################

-- V1: En çok ödünç alınan kitaplar ve yazarlarını bulan bir view yazalım.
CREATE OR REPLACE VIEW most_borrowed_books AS
SELECT
    b.title AS book_title,
    a.name AS author_name,
    COUNT(l.loan_id) AS total_borrows
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN loans l ON b.book_id = l.book_id
GROUP BY b.book_id, b.title, a.name
ORDER BY total_borrows DESC
LIMIT 10;

-- V1 Test Sorgusu
-- SELECT * FROM most_borrowed_books;

********************************************************
-- V2: Üyelerin ödünç alma istatistiklerini bulan bir view yazalım.
CREATE OR REPLACE VIEW member_loan_statistics AS
SELECT
    m.name AS member_name,
    COUNT(l.loan_id) AS total_loans_count, -- Toplam ödünç sayısı
    SUM(CASE WHEN l.return_date IS NULL THEN 1 ELSE 0 END) AS currently_borrowed_count -- Halen elinde olan kitap sayısı
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.name
ORDER BY total_loans_count DESC;

-- V2 Test Sorgusu
-- SELECT * FROM member_loan_statistics;


-- ######################################################################
-- # 5. KOMPLEKS SORGULAR (JOIN, GROUP BY, HAVING, Subquery)
-- ######################################################################

-- Q1: Kategorilere göre kitap sayıları ve ödünç alınma oranları:
SELECT
    c.name AS category_name,
    COUNT(DISTINCT b.book_id) AS total_books_in_category,
    COUNT(l.loan_id) AS total_borrows_in_category,
    -- Ödünç Alma Oranı: (Toplam Ödünç Sayısı / Kategorideki Toplam Kitap Sayısı)
    CAST(COUNT(l.loan_id) AS NUMERIC) / NULLIF(COUNT(DISTINCT b.book_id), 0) AS borrow_rate
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
LEFT JOIN loans l ON b.book_id = l.book_id
GROUP BY c.category_id, c.name
ORDER BY borrow_rate DESC, total_books_in_category DESC;


-- Q2: Yazarlara göre toplam ödünç alınma sayıları:
SELECT
    a.name AS author_name,
    COUNT(l.loan_id) AS total_borrows
FROM authors a
JOIN books b ON a.author_id = b.author_id
JOIN loans l ON b.book_id = l.book_id
GROUP BY a.author_id, a.name
ORDER BY total_borrows DESC;


-- Q3: Subquery ile: Ortalama gecikme süresinden daha fazla gecikmesi olan üyeler
-- NOT: Gecikme, iade tarihi (return_date) ile son iade tarihi (due_date) arasındaki farktır.
WITH DelayDays AS (
    SELECT
        l.member_id,
        (l.return_date - l.due_date) AS delay_days
    FROM loans l
    WHERE l.return_date IS NOT NULL AND l.return_date > l.due_date -- Gecikmeli iadeler
),
AvgDelay AS (
    SELECT AVG(delay_days) AS overall_avg_delay FROM DelayDays
)
SELECT
    m.name AS member_name,
    AVG(dd.delay_days) AS member_avg_delay_days,
    (SELECT overall_avg_delay FROM AvgDelay) AS system_avg_delay_days
FROM members m
JOIN DelayDays dd ON m.member_id = dd.member_id
GROUP BY m.member_id, m.name
HAVING AVG(dd.delay_days) > (SELECT overall_avg_delay FROM AvgDelay)
ORDER BY member_avg_delay_days DESC;





-- ######################################################################
-- # GECİKMELİ İADE KAYITLARI (Subquery Testi İçin Kritik)
-- ######################################################################

-- LOAN A: Üye 1 (Alice Johnson) - 10 Gün Gecikme
-- book_id 11 (Yüzyıllık Yalnızlık)
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(11, 1, '2025-10-01', '2025-10-15', '2025-10-25'); -- 10 Gün Gecikme

-- LOAN B: Üye 2 (Bob Smith) - 3 Gün Gecikme
-- book_id 12 (Uzun Hikaye)
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(12, 2, '2025-10-10', '2025-10-24', '2025-10-27'); -- 3 Gün Gecikme

-- LOAN C: Üye 11 (Kerem Atilla) - 20 Gün Gecikme
-- book_id 13 (Küçük Prens)
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(13, 11, '2025-09-01', '2025-09-15', '2025-10-05'); -- 20 Gün Gecikme

-- LOAN D: Üye 12 (Leyla Güneş) - 5 Gün Gecikme
-- book_id 11 (Yüzyıllık Yalnızlık) - Birden fazla ödünç (farklı kopya)
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(11, 12, '2025-11-01', '2025-11-15', '2025-11-20'); -- 5 Gün Gecikme


SELECT *
FROM loans
WHERE loan_id = 3;

SELECT calculate_fine(3);

--Charlie Brown The Shining kitabını 
 2025-11-05  de ödünç almış  2025-11-19 de iade etmesi gerekiyormuş ancak etmemiş.Ceza süresi devam etmektedir.

SELECT book_availability(5);

---Bu fonksiyon "The Hobbit" kitabının kaç kopyasını bir üyenin ödünç alabileceğini söyler.
The Hobbit'in (book_id = 5) Toplam Stok miktarı:6 
1 kişi 1 adet The Hobbit'i henüz iade etmemiş 
aktif ödünç sayısı 1, Sonuç: 6 - 1 = 5 çıkmaktadır. Yani 5 tane daha kitap ödünç alınabilir.


SELECT member_borrowed_count(6);

SELECT *
FROM loans
WHERE loan_id = 6;

--Fiona Gallagher  isimli üyede bir adet ödünç kitap vardır.

--************************
--STORED PROCEDURE TEST SORGULARI
--***********************
--SP1 Test: Kitap Ödünç Alma (member_id 10, book_id 10)
-- Çalıştırdıktan sonra stock (ID 10) 1 azalmalı. loans tablosunda yeni kayıt oluşmalı.
CALL sp_borrow_book(10, 10, 14);
SELECT 'SP1 Stok Kontrolü (Book 10)' AS Check_Point, stock FROM books WHERE book_id = 10;
SELECT 'SP1 Yeni Kayıt' AS Check_Point, * FROM loans ORDER BY loan_id DESC LIMIT 1;

-- Savas ve barıs elimizde olmadığı için kitap ödünç alınamadı ve RAISE EXCEPTION komutunu tetikledi.

-- Üye 12 (Leyla Güneş) Kitap 13'ü (Küçük Prens) ödünç alıyor.
-- Varsayılan stoğu 8 olan Book 13'ün hala stoğu olmalıdır.
CALL sp_borrow_book(12, 13, 14);

-- 1. Kontrol: Book 13 stoğu 1 azalmış mı? (Örneğin 8'den 7'ye düşmeli)
SELECT 'SP1 Stok Kontrolü (Book 13)' AS Check_Point, stock FROM books WHERE book_id = 13;

-- 2. Kontrol: Yeni bir loan kaydı oluşmuş mu?
SELECT 'SP1 Yeni Kayıt' AS Check_Point, * FROM loans ORDER BY loan_id DESC LIMIT 1; 

-- bu sorgu da ise kitap elimizde olduğu için ödünç alma işlemi tamamlandı.


-- SP2 Test: Kitap İade Etme (Örnek: L10 kaydını iade edelim. 20 gün gecikme var.)
-- return_date güncelleyecek. Stock 1 artacak. Fines tablosuna 10.00 TL ceza eklenecek.
SELECT 'SP2 ONCESI Fines Sayısı' AS Check_Point, COUNT(*) FROM fines;
CALL sp_return_book(10);
SELECT 'SP2 Sonrası Loans Kontrolü (Loan 10)' AS Check_Point, return_date FROM loans WHERE loan_id = 10;
SELECT 'SP2 Sonrası Stock Kontrolü (Book 13)' AS Check_Point, stock FROM books WHERE book_id = 13;
SELECT 'SP2 Sonrası Fines Kontrolü' AS Check_Point, * FROM fines ORDER BY fine_id DESC LIMIT 1;
--Bilgi: Kitap başarılı bir şekilde ödünç alındı.
--Bilgi: Kitap zamanında iade edildi.


-- ######################################################################
-- # TRIGGER DOĞRUDAN TEST SORGULARI
-- ######################################################################

-- T2 Test: tr_return_increase_stock (Loan 5'i iade et)
-- Loan 5: Book 5'te. Book 5'in stoğu 6 idi. 5 iade edildiğinde stok 6'ya dönmeli.
SELECT 'T2 ONCESI Book 5 Stock' AS Check_Point, stock FROM books WHERE book_id = 5;
UPDATE loans SET return_date = CURRENT_DATE WHERE loan_id = 5;
SELECT 'T2 SONRASI Book 5 Stock' AS Check_Point, stock FROM books WHERE book_id = 5;
--Bilgi: Kitap başarılı bir şekilde ödünç alındı.
--Bilgi: Kitap zamanında iade edildi.

-- T3 Test: tr_create_fine (Loan 3'ü 30 gün gecikmeyle iade et)
-- Loan 3: Due Date: 2025-11-19. Return Date: 2025-12-30. Gecikme: 41 gün. Ceza: 20.50 TL
SELECT 'T3 ONCESI Fines Sayısı' AS Check_Point, COUNT(*) FROM fines;
UPDATE loans SET return_date = '2025-12-30' WHERE loan_id = 3;
SELECT 'T3 SONRASI Fines Kontrolü' AS Check_Point, amount FROM fines WHERE loan_id = 3;
--Bilgi: Kitap başarılı bir şekilde ödünç alındı.
--Bilgi: Kitap zamanında iade edildi.



-- ######################################################################
-- # VIEW VE KOMPLEKS SORGULAR TESTLERİ
-- ######################################################################

-- V1 Test: En çok ödünç alınan kitaplar
SELECT * FROM most_borrowed_books;

--Yüzyıllık Yalnızlık	Gabriel Garcia Marquez	2
--Küçük Prens	J.K. Rowling	2
--Adventures of Huckleberry Finn	Mark Twain	1

-- V2 Test: Üyelerin ödünç alma istatistikleri
SELECT * FROM member_loan_statistics;

--Alice Johnson	2	1
--Leyla Güneş	 2	  1
--Bob Smith	2	0
--Kerem Atilla	1	0

-- Q3 Test: Ortalama Üstü Gecikmesi Olan Üyeler 
WITH DelayDays AS (
    SELECT
        l.member_id,
        (l.return_date - l.due_date) AS delay_days
    FROM loans l
    WHERE l.return_date IS NOT NULL AND l.return_date > l.due_date
),
AvgDelay AS (
    SELECT AVG(delay_days) AS overall_avg_delay FROM DelayDays
)
SELECT
    m.name AS member_name,
    AVG(dd.delay_days) AS member_avg_delay_days,
    (SELECT overall_avg_delay FROM AvgDelay) AS system_avg_delay_days
FROM members m
JOIN DelayDays dd ON m.member_id = dd.member_id
GROUP BY m.member_id, m.name
HAVING AVG(dd.delay_days) > (SELECT overall_avg_delay FROM AvgDelay)
ORDER BY member_avg_delay_days DESC;

-- Charlie Brown	41	14.66  üyenin ortalama gecikme gün sayısı 41 günken ortalama 14.6 gündür.
-- Kerem Atilla	20 14.6 üyenin ortalama gecikme gün sayısı 20 günken ortalama 14.6 gündür.