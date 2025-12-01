

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
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




-- Eğer varsa, ilişkili tabloları siler (zorunlu silme: CASCADE)
-- Bu işlem test veya yeniden kurulum sırasında gereklidir.

DROP TABLE IF EXISTS fines CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS loans CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;
DROP TABLE IF EXISTS authors CASCADE;



);


SET search_path TO library_schema, public;


SELECT * FROM books; -- PostgreSQL, bunu library_schema.books olarak algılayacaktır
