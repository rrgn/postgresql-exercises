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
