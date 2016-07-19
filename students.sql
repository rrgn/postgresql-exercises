CREATE TABLE student (
  -- defines a name field with the type of varchar,
  -- which is short for a variable number of characters,
  -- in other words, a string
  id serial UNIQUE,
  name varchar NOT NULL,
  website varchar,
  github_username varchar,
  -- points has type of integer
  points integer DEFAULT 0 CHECK (points >= 0),
  -- gender has type of 1 character, it's like a string
  -- of length 1
  gender char(1),
  -- cohort_start_date is a date
  cohort_start_date date NOT NULL,
  graduated boolean DEFAULT FALSE
);
