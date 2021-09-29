/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(100), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg FLOAT, PRIMARY KEY(id));



-- TASK 2 - Add a column species of type string to your animals --

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- TASK 3 - Query multiple tables  --

CREATE TABLE owners  (id INT GENERATED ALWAYS AS IDENTITY,full_name VARCHAR(100),age INT,PRIMARY KEY(id));


CREATE TABLE species  (id INT GENERATED ALWAYS AS IDENTITY,name VARCHAR(100),PRIMARY KEY(id));

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);


-- TASK 4 - Add "join table" for visits  --

CREATE TABLE vets ( id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(100), age INT, date_of_graduation DATE, PRIMARY KEY(id) );

CREATE TABLE specializations ( species_id INT, vets_id INT, FOREIGN kEY (species_id) REFERENCES species(id), FOREIGN kEY (vets_id) REFERENCES vets(id), PRIMARY kEY (species_id, vets_id));

CREATE TABLE visits ( animals_id INT, vets_id INT, date_of_visit DATE, id INT GENERATED ALWAYS AS IDENTITY, FOREIGN KEY (animals_id) REFERENCES animals(id), FOREIGN KEY (vets_id) REFERENCES vets(id), PRIMARY KEY (id) );


-- TASK 5

ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animals_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- Optimize visits table by creating an Index using the animals_id column
CREATE INDEX IX_animals_visits_id ON visits (animals_id);
DROP INDEX IX_animals_visits_id;

-- Optimize visits table by creating an Index using the vets_id column
CREATE INDEX IX_vets_id ON visits (vets_id);
DROP INDEX IX_vets_id;

-- -- Optimize owners table by creating an Index using the email column
CREATE INDEX IX_email_id ON owners (email ASC);
DROP INDEX IX_email_id;


