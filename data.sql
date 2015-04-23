/*
Empty the tables
 */
DELETE FROM task_log;
DELETE FROM adoption;
DELETE FROM animal;
DELETE FROM animal_behavior;
DELETE FROM behavior;
DELETE FROM animal_training;
DELETE FROM animal_subtype;
DELETE FROM animal_detail;
DELETE FROM kennel;
DELETE FROM animal_type;
DELETE FROM employee;
DELETE FROM task;

/*
Reset Sequences used for Primary keys
 */
DROP SEQUENCE employee_id_seq;
DROP SEQUENCE behavior_id_seq;
DROP SEQUENCE kennel_id_seq;
DROP SEQUENCE animal_subtype_id_seq;
DROP SEQUENCE animal_type_id_seq;
DROP SEQUENCE task_log_id_seq;
DROP SEQUENCE task_id_seq;
DROP SEQUENCE adoption_id_seq;
DROP SEQUENCE animal_id_seq;
DROP SEQUENCE animal_detail_id_seq;

CREATE SEQUENCE employee_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE behavior_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE kennel_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_subtype_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_type_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE task_log_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE task_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE adoption_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_detail_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;


/*
Populate static tables
 */
INSERT INTO animal_type (animal_type_name) VALUES ('dog');
INSERT INTO animal_type (animal_type_name) VALUES ('cat');
INSERT INTO animal_type (animal_type_name) VALUES ('horse');
INSERT INTO animal_type (animal_type_name) VALUES ('parrot');
INSERT INTO animal_type (animal_type_name) VALUES ('fish');
COMMIT;

DECLARE
  dog_id NUMBER;
BEGIN
  SELECT animal_type_id
  INTO dog_id
  FROM animal_type
  WHERE animal_type_name = 'dog';

  INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Border Collie', dog_id);
  INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Golden Retriever', dog_id);
  INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Pit Bull', dog_id);
  INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Mix', dog_id);
  INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Poodle', dog_id);
  INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Terrier', dog_id);
  COMMIT;
END;
/


