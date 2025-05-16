# Library Management System Database

This project provides a comprehensive SQL schema for a Library Management System. The schema is designed to manage books, authors, publishers, genres, library members, book loans, and fines.

## Features

- **Publishers**: Store publisher details.
- **Genres**: Categorize books by genre.
- **Authors**: Manage author information.
- **Books**: Track book details, editions, and inventory.
- **Book Authors**: Support many-to-many relationships between books and authors.
- **Members**: Register and manage library members.
- **Loans**: Record book borrowings and returns.
- **Fines**: Track fines for overdue or lost books.

## Database Schema Overview

- **Publishers**: Stores publisher information.
- **Genres**: Stores book genres/categories.
- **Authors**: Stores author details.
- **Books**: Stores book information, including publisher and genre references.
- **Book_Authors**: Junction table for books and authors (many-to-many).
- **Members**: Stores member information and status.
- **Loans**: Tracks book loans, due dates, and returns.
- **Fines**: Manages fines for overdue/lost books.

## Getting Started

1. **Clone the repository** or download the [library.sql](library.sql) file.
2. **Import the schema** into your MySQL or MariaDB database:

   ```sh
   mysql -u your_username -p your_database < library.sql
   ```

3. **Customize** the schema as needed for your application.

## Notes

- The schema uses foreign keys and constraints to maintain data integrity.
- Example indexes are provided (commented out) for performance tuning.
- Default values and checks are included for robust data validation.

## License

This project is provided for educational purposes.