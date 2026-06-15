CREATE DATABASE football_ticket_booking;

-- creating table 
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  role VARCHAR(20),
  phone_number VARCHAR(15)
);

CREATE TABLE matches (
  match_id SERIAL PRIMARY KEY,
  fixture VARCHAR(50),
  tournament_category VARCHAR(50),
  base_ticket_price DECIMAL(10,2),
  match_status VARCHAR(20)
);

CREATE TABLE bookings(
  booking_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  match_id INT REFERENCES matches(match_id),
  seat_number VARCHAR(8),
  payment_status VARCHAR(30),
  total_cost DECIMAL (10,2)
);


INSERT INTO users
(user_id, full_name, email, role, phone_number)
VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),

(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),

(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),

(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);



INSERT INTO matches
(match_id, fixture, tournament_category, base_ticket_price, match_status)
VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),

(102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),

(103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),

(104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),

(105, 'Juventus vs Roma', 'Serie A', 80, 'Available');


INSERT INTO bookings
(booking_id, user_id, match_id, seat_number, payment_status, total_cost)
VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150),

(502, 1, 102, 'B-04', 'Confirmed', 120),

(503, 2, 101, 'A-13', 'Confirmed', 150),

(504, 2, 101, NULL, NULL, 150),

(505, 3, 102, 'C-20', 'Pending', 120);


-- query no 1

SELECT match_id, fixture, base_ticket_price FROM matches WHERE tournament_category = 'Champions League' AND match_status = 'Available';


-- query no 2

SELECT user_id ,full_name, email FROM users WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%';

-- query no 3

SELECT booking_id, user_id, match_id , COALESCE(payment_status, 'Action Required') AS systematic_status FROM bookings WHERE payment_status IS NULL;

-- query no 4

SELECT booking_id, full_name, fixture, total_cost FROM bookings JOIN users USING(user_id) JOIN matches USING(match_id);

-- query no 5

SELECT user_id, full_name, booking_id FROM users LEFT JOIN bookings USING(user_id);

-- query no 6

SELECT booking_id, match_id, total_cost FROM bookings WHERE total_cost > (SELECT AVG(total_cost) FROM bookings);

-- query no 7

SELECT match_id, fixture, base_ticket_price FROM matches ORDER BY base_ticket_price DESC LIMIT 2 OFFSET 1;