-- psql restaurant_db2;

-- create a table for restaurant
CREATE TABLE restaurant (
  id serial UNIQUE,
  name varchar NOT NULL,
  address varchar,
  category varchar
);

-- create a table for reviewer
CREATE TABLE reviewer (
  id serial UNIQUE,
  name varchar NOT NULL,
  email varchar,
  karma integer DEFAULT 0 CHECK (karma >= 0 and karma <= 7)
);

-- create a table for Review
CREATE TABLE review (
  id serial UNIQUE,
  author integer NOT NULL REFERENCES reviewer (id),
  stars integer DEFAULT 0 CHECK (stars >= 0 and stars < 6),
  title varchar,
  review varchar,
  restaurant_id integer NOT NULL REFERENCES restaurant (id)
);

-- insert restaurants
insert into restaurant values
  (default, 'Chipotle', NULL, 'Mexican');
insert into restaurant values
  (default, 'NaanStop', NULL, 'Indian');
insert into restaurant values
  (default, 'Chick-Fil-A', NULL, 'American');
insert into restaurant values
  (default, 'ChowBing', NULL, 'Chinese');
insert into restaurant values
  (default, 'Jason''s Deli', NULL, 'Deli');

-- insert reviewers
insert into reviewer values
  (default, 'Bob', NULL, 3);
insert into reviewer values
  (default, 'Ned', NULL, 4);
insert into reviewer values
  (default, 'Arya', NULL, 7);

-- insert reviews
insert into review values
  (default, 1, 4, 'Chipotle Review', 'Awesome food and service', 1);
insert into review values
  (default, 2, 3, 'Naan Stop Review', 'Flavorful', 2);
insert into review values
  (default, 3, 5, 'ChowBing', 'Ameri-nese', 4);
insert into review values
  (default, 1, 5, 'Jason''s Deli ', 'Deli Goodness', 5);

-- join the data
select
  reviewer.name as reviewer_name,
  review.title as review_title,
  review.review as review,
  review.stars as stars,
  restaurant.name as restaurant_name
from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id;

-- 1. get avg stars by restaurant(restaurant_name, average star ratings)

select
  restaurant.id,
  avg(review.stars) as average_stars,
  restaurant.name as restaurant_name
from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  restaurant.id, restaurant.name
  ;

-- 2. get the average stars by user (user name, average star rating)

select
  reviewer.id,
  reviewer.name,
  avg(review.stars) as avg

from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  reviewer.id, reviewer.name
;

-- 3. get the lowest star rating for each user (user name, lowest star rating)
select
  reviewer.id,
  reviewer.name,
  min(review.stars) as min_stars

from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  reviewer.id, reviewer.name
;

-- 4. get the number of reviews by restaurant (restaurant name, review count)

select
  restaurant.name as restaurant_name,
  count(review.review) as review
from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  review.id, restaurant.name
;

-- 5. get the number of restaurants in each category (category name, restaurant count)
select
  restaurant.name as restaurant_name,
  restaurant.category as restaurant_category,
  count(restaurant.name) as restaurant_count
from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  review.id, restaurant.name, restaurant.category
;

-- 6. get number of 5 star reviews by restaurant (restaurant name, 5-star count)
select
  restaurant.name as restaurant_name,
  restaurant.category as restaurant_category,
  count(review.stars) as stars
from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  review.id, restaurant.name, review.stars, restaurant.category
;

-- 7. average star rating for a food category (category name, average star rating)
select
  restaurant.name as restaurant_name,
  restaurant.category as restaurant_category,
  avg(review.stars) as stars
from
  restaurant,
  reviewer,
  review
where
  reviewer.id = review.author and restaurant.id = review.restaurant_id
group by
  review.id, restaurant.name, review.stars, restaurant.category
;
