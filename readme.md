# Football Ticket Booking System - Database Project

## 🎯 Project Overview

This project involves the design, architecture, and structural implementation of a relational database for a **Football Ticket Booking System**. It covers everything from conceptual modeling (ERD) to transactional database setup and business intelligence scripting.

---

## 🛠️ What I Have Done in This Project

### 1. Database & Relational Architecture Design (ERD)

- Designed a complete Entity-Relationship Diagram (ERD) using proper **Crow’s Foot Notation** to ensure strict data validation and referential integrity.
- Implemented **One-to-Many (1:M)** relationships:
  - **Users ↔ Bookings:** Mapped a single user to multiple booking logs (`One` side on Users, `Many` side on Bookings).
  - **Matches ↔ Bookings:** Linked a single football match to multiple ticket purchases (`One` side on Matches, `Many` side on Bookings).
- Ensured a logical **One-to-One (1:1)** row configuration where each individual record in the bookings table maps exactly one unique user to a specific match and seat choice.
- **Live ERD Link:** [](https://lucid.app/lucidchart/2fa81066-8524-4c6c-8b6a-69ca609f56aa/edit?viewport_loc=-1883%2C-1254%2C3231%2C1509%2C0_0&invitationId=inv_61c7a397-c412-4b77-b125-07ef9f1adf78)

### 2. Physical Schema & DDL Implementation

- Structured the database schema using **PostgreSQL** syntax with professional naming conventions.
- Used advanced data types such as `SERIAL` for automatic id generation and `NUMERIC(10,2)` for financial calculations (`base_ticket_price`, `total_cost`).
- Configured robust domain and safety constraints:
  - `PRIMARY KEY` and `FOREIGN KEY` constraints to link tables securely.
  - `UNIQUE` constraint on emails to prevent duplicate accounts.
  - `CHECK` constraints to restrict invalid statuses (e.g., specific roles, payment status, and match availability).
  - Preventive constraints (`>= 0`) to guarantee no negative pricing values.
  - Enabled `ON DELETE CASCADE` to maintain database cleanup when records are removed.

### 3. Mock Data Seeding

- Successfully populated all three core entities (`Users`, `Matches`, `Bookings`) with contextual domain data matching real-world football scenarios (e.g., Champions League fixtures, specific stadium seating arrays, and complex payment states).

### 4. SQL Queries

Developed 7 business-critical SQL scripts utilizing advanced relational operations:

- **Conditional Filtering:** Querying real-time records based on multi-layered logical criteria.
- **Pattern Matching:** Implemented case-insensitive lookups using `ILIKE` for scalable search functionality.
- **Null Data Handling:** Employed `COALESCE` to elegantly substitute missing transaction data with user-friendly system alerts.
- **Relational Joins:** Engineered `INNER JOIN` matrices and cross-sectional `LEFT JOIN` operations to extract unified insights while preserving rows of inactive customers.
- **Advanced Aggregations:** Utilized non-correlated subqueries to isolate above-average high-ticket transactions.
- **Offset Pagination:** Applied advanced sorting using `LIMIT` and `OFFSET` clauses to securely handle optimized web-app pagination.

---

## 📂 Project Structure

- `query.sql` - Complete executable database setup, data seeding, and analytical queries script.
- `readme.md` - Complete summary documentation of project achievements.
