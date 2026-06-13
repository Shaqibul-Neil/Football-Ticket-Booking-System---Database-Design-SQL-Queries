-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- =========================================================================
CREATE DATABASE football_ticket_booking;

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;

DROP TABLE IF EXISTS Matches;

DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
  user_id SERIAL,
  full_name VARCHAR(100),
  email VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL,
  phone_number VARCHAR(20),
  -- Write your constraint to make 'user_id' the Primary Key
  -- Write your constraint to ensure 'email' values are never duplicated
  -- Write your check constraint to restrict 'role' to specific allowed strings
  CONSTRAINT pk_users PRIMARY KEY (user_id),
  CONSTRAINT unique_email UNIQUE (email),
  CONSTRAINT check_role CHECK (role IN ('Football Fan', 'Ticket Manager'))
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
  match_id SERIAL,
  fixture VARCHAR(100) NOT NULL,
  tournament_category VARCHAR(30) NOT NULL,
  base_ticket_price NUMERIC(10, 2) NOT NULL,
  match_status VARCHAR(20) NOT NULL,
  -- Write your constraint to make 'match_id' the Primary Key
  -- Write your check constraint to prevent negative ticket prices
  -- Write your check constraint to restrict 'match_status' values
  CONSTRAINT pk_matches PRIMARY KEY (match_id),
  CONSTRAINT base_ticket CHECK (base_ticket_price >= 0),
  CONSTRAINT check_match_status CHECK (
    match_status IN (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
  booking_id SERIAL,
  user_id INT NOT NULL,
  match_id INT NOT NULL,
  seat_number VARCHAR(10),
  payment_status VARCHAR(20),
  total_cost NUMERIC(10, 2) NOT NULL,
  -- Write your constraint to make 'booking_id' the Primary Key
  -- Write your Foreign Key constraint linking 'user_id' to the Users table
  -- Write your Foreign Key constraint linking 'match_id' to the Matches table
  -- Write your check constraint to ensure 'total_cost' is non-negative
  -- Write your check constraint to restrict 'payment_status' values
  CONSTRAINT pk_bookings PRIMARY KEY (booking_id),
  CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_match_id FOREIGN KEY (match_id) REFERENCES matches (match_id),
  CONSTRAINT check_total_cost CHECK (total_cost >= 0),
  CONSTRAINT check_payment_status CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  )
);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending', 120.00);

--Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  matches
WHERE
  tournament_category = 'Champions League'
  AND match_status = 'Available';

--Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
SELECT
  user_id,
  full_name,
  email
FROM
  users
WHERE
  full_name ILIKE 'Tanvir%'
  or full_name ILIKE '%Haque%';

--Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
SELECT
  booking_id,
  user_id,
  match_id,
  COALESCE (payment_status,'Action Required') AS systematic_status
FROM
  bookings where payment_status IS NULL;
