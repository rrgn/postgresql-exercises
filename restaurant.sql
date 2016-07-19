

CREATE TABLE restaurant (
  id serial PRIMARY KEY,
  name varchar,
  distance real,
  stars integer CHECK (stars > 0 and stars <= 5),
  category varchar,
  favorite_dish varchar,
  does_takeout boolean,
  last_time_you_ate_there date
);

-- 1. The names of the restaurants that you gave a 5 stars to
select name from restaurant where stars = 5;

-- 2. The favorite dishes of all 5-star restaurants
select favorite_dish from restaurant where stars = 5;

-- 3. The the id of a restaurant by a specific restaurant name, say 'NaanStop'
select id from restaurant where name = 'NaanStop';

-- 4. restaurants in the category of 'BBQ'
select name from restaurant where category = 'BBQ';

-- 5. restaurants that do take out
select * from restaurant where does_takeout = TRUE;

-- 6. restaurants that do take out and is in the category of 'BBQ'
select * from restaurant where does_takeout = TRUE && category = 'BBQ';

-- 7. restaurants within 2 miles
select * from restaurant where distance <= 2;

-- 8. restaurants you haven't ate at in the last week
select name from restaurant where last_time_you_ate_there < '2016-07-12';
-- or better:
select name from restaurant where last_time_you_ate_there < current_date - interval '1 week';

-- 9. restaurants you haven't ate at in the last week and has 5 stars
select name from restaurant where last_time_you_ate_there < current_date - interval '1 week' and stars = 5;
