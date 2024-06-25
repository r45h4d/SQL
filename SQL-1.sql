CREATE TABLE Students
(
	id serial PRIMARY KEY,
	name VARCHAR(50),
	email VARCHAR(50),
	createdAt TIMESTAMP	NOT NULL
);

ALTER TABLE Students
ADD COLUMN phone VARCHAR(20);

ALTER TABLE Students
RENAME COLUMN createdat TO created_at;

ALTER TABLE Students
DROP COLUMN created_at;

COMMENT ON TABLE Students IS 'This table store information about students';

COMMENT ON COLUMN Students.phone IS 'Phone numbers without country code'

INSERT INTO Students (name, email, phone)
VALUES ('Rashad', 'rashad@amanov.az', '1111111');

INSERT INTO Students (name, email, phone)
VALUES ('Rashad', 'amanov@rashad.az', '2222222');

INSERT INTO Students (name, email, phone)
VALUES ('Elshad', 'elshad@amanov.az', '3333333');

SELECT * FROM Students;

SELECT DISTINCT name FROM Students;

SELECT * FROM Students WHERE name='Rashad' ORDER BY phone DESC;

SELECT * FROM Students WHERE name='Rashad' AND phone='1111111';

UPDATE Students SET email='rashad@amanov.com' WHERE phone='1111111';

SELECT * FROM Students WHERE id BETWEEN 1 AND 3;

TRUNCATE TABLE Students;

DROP TABLE Students;



