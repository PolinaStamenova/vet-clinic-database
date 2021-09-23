/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(100), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg FLOAT, PRIMARY KEY(id));



-- TASK 2 - Add a column species of type string to your animals --

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- TASK 3 - Query multiple tables  --

CREATE TABLE owners  (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100),
  age INT,
  PRIMARY KEY(id)
)


CREATE TABLE species  (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  PRIMARY KEY(id)
)

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);