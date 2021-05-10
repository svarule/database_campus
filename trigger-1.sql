use campus_eats_fall2020;

-- update tigger 
DELIMITER //
CREATE TRIGGER student_before_update
  BEFORE UPDATE ON student
  FOR EACH ROW 
BEGIN
  SET NEW.major = UPPER(NEW.major);
END;

UPDATE student
SET Major = 'Philosophy'
WHERE student_id = 1;

-- 2nd trigger on audit table 
CREATE TABLE student_audit
(
  student_id  INT NOT NULL,
  person_id INT   NOT NULL,
  action_type VARCHAR(50) NOT NULL,
  action_date DATETIME  NOT NULL
);

DROP TRIGGER IF EXISTS student_after_insert;

use campus_eats_fall2020;

DELIMITER //


CREATE TRIGGER student_after_insert
  AFTER INSERT ON student
  FOR EACH ROW
BEGIN
    INSERT INTO student_audit VALUES
    (NEW.student_id, NEW.person_id, 'INSERTED', NOW());
END ; 

INSERT INTO student VALUES 
(152, 205, 2021, 'crime', 'Graduate');

SELECT * FROM campus_eats_fall2020.student_audit;


DELIMITER //

SELECT * FROM campus_eats_fall2020.student;

person_id