CREATE TABLE contacts (
  id serial PRIMARY KEY,
  name text NOT NULL,
  tel text,
  email text,
  address_1 text,
  address_2 text,
  city text,
  region text,
  postcode text,
  country text
);