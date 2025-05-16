-- Library Management System Database Schema

-- -----------------------------------------------------
-- Table `Publishers`
-- Stores information about book publishers.
-- -----------------------------------------------------
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL UNIQUE,
    address TEXT,
    phone_number VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- -----------------------------------------------------
-- Table `Genres`
-- Stores book genres or categories.
-- -----------------------------------------------------
CREATE TABLE Genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- -----------------------------------------------------
-- Table `Authors`
-- Stores information about authors.
-- -----------------------------------------------------
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    birth_date DATE,
    nationality VARCHAR(50),
    CONSTRAINT uq_author_full_name UNIQUE (first_name, last_name) -- Ensure unique author names
);

-- -----------------------------------------------------
-- Table `Books`
-- Stores information about each book in the library.
-- -----------------------------------------------------
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE, -- International Standard Book Number
    publication_year YEAR,
    edition VARCHAR(50),
    number_of_copies INT NOT NULL DEFAULT 1,
    copies_available INT NOT NULL DEFAULT 1,
    publisher_id INT,
    genre_id INT,
    shelf_location VARCHAR(50), -- e.g., "A1-03", "Fiction-West"
    added_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    branch_id INT NULL,

    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
        ON DELETE SET NULL  -- If publisher is deleted, book record remains but publisher is unknown
        ON UPDATE CASCADE,  -- If publisher_id changes, update here
    CONSTRAINT fk_book_genre FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
        ON DELETE SET NULL  -- If genre is deleted, book record remains but genre is unknown
        ON UPDATE CASCADE,  -- If genre_id changes, update here
    CONSTRAINT chk_book_copies CHECK (copies_available >= 0 AND copies_available <= number_of_copies),
    CONSTRAINT fk_book_branch FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `Book_Authors` (Junction Table for M-M relationship)
-- Links books to their authors. A book can have multiple authors,
-- and an author can write multiple books.
-- -----------------------------------------------------
CREATE TABLE Book_Authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id), -- Composite Primary Key
    CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE   -- If a book is deleted, this association is removed
        ON UPDATE CASCADE,
    CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES Authors(author_id)
        ON DELETE CASCADE   -- If an author is deleted, this association is removed
        ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `Members`
-- Stores information about library members.
-- -----------------------------------------------------
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    address TEXT,
    join_date DATE NOT NULL DEFAULT (CURDATE()),
    membership_expiry_date DATE,
    member_status ENUM('Active', 'Expired', 'Suspended', 'Cancelled') NOT NULL DEFAULT 'Active',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table `Loans`
-- Records books borrowed by members.
-- -----------------------------------------------------
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME NOT NULL,
    return_date DATETIME NULL, -- NULL if not yet returned
    loan_status ENUM('Borrowed', 'Returned', 'Overdue', 'Lost') NOT NULL DEFAULT 'Borrowed',

    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE RESTRICT  -- Prevent deleting a book if it's currently or was previously loaned
        ON UPDATE CASCADE,
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE RESTRICT  -- Prevent deleting a member if they have loan records
        ON UPDATE CASCADE,
    CONSTRAINT chk_loan_dates CHECK (due_date > loan_date AND (return_date IS NULL OR return_date >= loan_date))
);

-- -----------------------------------------------------
-- Table `Fines`
-- Manages fines incurred by members for overdue or lost books.
-- -----------------------------------------------------
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL UNIQUE, -- Each loan can have at most one primary fine record associated with it
    member_id INT NOT NULL, -- Denormalized for easier querying, but can be derived from loan_id
    fine_amount DECIMAL(10, 2) NOT NULL,
    fine_reason VARCHAR(255) DEFAULT 'Overdue book',
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    paid_date DATETIME NULL, -- NULL if not yet paid
    fine_status ENUM('Unpaid', 'Paid', 'Waived') NOT NULL DEFAULT 'Unpaid',

    CONSTRAINT fk_fine_loan FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
        ON DELETE CASCADE   -- If a loan record is deleted, its associated fine should also be deleted
        ON UPDATE CASCADE,
    CONSTRAINT fk_fine_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE RESTRICT  -- Prevent deleting a member if they have fine records
        ON UPDATE CASCADE,
    CONSTRAINT chk_fine_amount CHECK (fine_amount > 0)
);

-- -----------------------------------------------------
-- Table `Staff`
-- Stores information about library staff.
-- -----------------------------------------------------
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    role ENUM('Librarian', 'Assistant', 'Admin') NOT NULL DEFAULT 'Librarian',
    hire_date DATE NOT NULL DEFAULT (CURDATE()),
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active'
);

-- -----------------------------------------------------
-- Table `Reservations`
-- Manages book reservations by members.
-- -----------------------------------------------------
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Active', 'Cancelled', 'Fulfilled', 'Expired') NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_res_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_res_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `Book_Reviews`
-- Stores reviews and ratings for books.
-- -----------------------------------------------------
CREATE TABLE Book_Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_review_member FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `Branches`
-- Stores information about library branches.
-- -----------------------------------------------------
CREATE TABLE Branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL UNIQUE,
    address TEXT,
    phone_number VARCHAR(20)
);

-- -----------------------------------------------------
-- Table `Tags`
-- Stores tags for flexible categorization/search.
-- -----------------------------------------------------
CREATE TABLE Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- Table `Book_Tags`
-- Links books to their tags.
-- -----------------------------------------------------
CREATE TABLE Book_Tags (
    book_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (book_id, tag_id),
    CONSTRAINT fk_bt_book FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_bt_tag FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Example of adding an index for performance on frequently searched columns
-- -----------------------------------------------------
-- CREATE INDEX idx_book_title ON Books(title);
-- CREATE INDEX idx_member_lastname ON Members(last_name);

-- End of Library Management System Schema
