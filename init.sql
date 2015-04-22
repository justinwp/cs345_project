/*

Group Project IV Initialization Script

>> set echo on
>> @init.sql

 */



/*
*************
Drop Tables
*************

Start from a clean database.
*/
DROP TABLE task_log;
DROP TABLE adoption;
DROP TABLE animal;
DROP TABLE animal_behavior;
DROP TABLE behavior;
DROP TABLE animal_training;
DROP TABLE animal_subtype;
DROP TABLE animal_detail;
DROP TABLE kennel;
DROP TABLE animal_type;
DROP TABLE employee;
DROP TABLE task;

/*
*************
Create Tables
*************
 */

CREATE TABLE animal_type (
  animal_type_id          NUMBER(10)   CONSTRAINT animal_type_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_type_name        VARCHAR2(50) CONSTRAINT animal_type_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_type_description VARCHAR2(255),
  CONSTRAINT animal_type_id_pk PRIMARY KEY (animal_type_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_subtype_id_fk FOREIGN KEY (animal_type_id) REFERENCES animal_type (animal_type_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE animal_subtype (
  animal_subtype_id          NUMBER(10)   CONSTRAINT animal_subtype_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_type_id             NUMBER(10)   CONSTRAINT animal_subtype_type_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_subtype_name        VARCHAR2(50) CONSTRAINT animal_subtype_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_subtype_description VARCHAR2(255),
  CONSTRAINT animal_subtype_id_pk PRIMARY KEY (animal_subtype_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_subtype_type_id_fk FOREIGN KEY (animal_type_id) REFERENCES animal_type (animal_type_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE kennel (
  kennel_id      NUMBER(10) CONSTRAINT animal_type_animal_type_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  kennel_space   NUMBER(4),
  animal_type_id NUMBER(10),
  CONSTRAINT kennel_id_pk PRIMARY KEY (kennel_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT kennel_animal_type_id_fk FOREIGN KEY (animal_type_id) REFERENCES animal_type (animal_type_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE animal_detail (
  animal_detail_id     NUMBER(10) CONSTRAINT animal_detail_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_detail_age    INTERVAL YEAR TO MONTH,
  animal_detail_height FLOAT(2),
  animal_detail_weight FLOAT(2),
  animal_detail_color  VARCHAR2(20),
  animal_detail_notes  VARCHAR2(255),
  CONSTRAINT animal_detail_id_pk PRIMARY KEY (animal_detail_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE animal (
  animal_id           NUMBER(10) CONSTRAINT animal_animal_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_subtype_id   NUMBER(10),
  kennel_id           NUMBER(10),
  animal_detail_id    NUMBER(10) CONSTRAINT animal_detail_id_uq UNIQUE DEFERRABLE INITIALLY IMMEDIATE, -- forces 1:0-1
  animal_name         VARCHAR2(50),
  animal_arrival_date DATE DEFAULT CURRENT_DATE,
  CONSTRAINT animal_animal_id_pk PRIMARY KEY (animal_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_animal_subtype_id_fk FOREIGN KEY (animal_subtype_id) REFERENCES animal_subtype (animal_subtype_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_kennel_id_fk FOREIGN KEY (kennel_id) REFERENCES kennel (kennel_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE behavior (
  behavior_id          NUMBER(10)   CONSTRAINT behavior_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  behavior_name        VARCHAR2(50) CONSTRAINT behavior_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  behavior_description VARCHAR2(255),
  CONSTRAINT behavior_id_pk PRIMARY KEY (behavior_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE animal_behavior (
  behavior_id NUMBER(10) CONSTRAINT animal_behavior_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_id   NUMBER(10) CONSTRAINT animal_behavior_a_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_behavior_pk PRIMARY KEY (behavior_id, animal_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE employee (
  employee_id         NUMBER(10)   CONSTRAINT employee_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  employee_first_name VARCHAR2(50) CONSTRAINT employee_first_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  employee_last_name  VARCHAR2(50) CONSTRAINT employee_last_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  employee_phone      VARCHAR2(50),
  CONSTRAINT employee_id_pk PRIMARY KEY (employee_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE adoption (
  adoption_id   NUMBER(10) CONSTRAINT adoption_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_id     NUMBER(10) CONSTRAINT adoption_animal_id_uq UNIQUE DEFERRABLE INITIALLY IMMEDIATE, -- forces 1:0-1
  employee_id   NUMBER(10) CONSTRAINT adoption_employee_id_nn UNIQUE DEFERRABLE INITIALLY IMMEDIATE,
  adoption_date DATE DEFAULT CURRENT_DATE,
  CONSTRAINT adoption_id_pk PRIMARY KEY (adoption_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT adoption_animal_id_fk FOREIGN KEY (animal_id) REFERENCES animal (animal_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT adoption_employee_id_fk FOREIGN KEY (employee_id) REFERENCES employee (employee_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE task (
  task_id          NUMBER(10)   CONSTRAINT task_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  task_name        VARCHAR2(50) CONSTRAINT task_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  task_description VARCHAR2(255),
  CONSTRAINT task_id_pk PRIMARY KEY (task_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE task_log (
  task_log_id             NUMBER(10) CONSTRAINT task_log_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  task_id                 NUMBER(10) CONSTRAINT task_log_task_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  kennel_id               NUMBER(10),
  employee_id             NUMBER(10),
  task_log_assigned_by_id NUMBER(10) CONSTRAINT task_log_assigned_by_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  task_log_assigned_to_id NUMBER(10),
  animal_id               NUMBER(10),
  task_log_notes          VARCHAR2(255),
  task_log_assigned_date  DATE DEFAULT CURRENT_DATE,
  task_log_started_date   DATE,
  task_log_completed_date DATE,
  CONSTRAINT task_log_id_pk PRIMARY KEY (task_log_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT task_id_fk FOREIGN KEY (task_id) REFERENCES task (task_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT task_log_kennel_id_fk FOREIGN KEY (kennel_id) REFERENCES kennel (kennel_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT task_log_assigned_by_id_fk FOREIGN KEY (task_log_assigned_by_id) REFERENCES employee (employee_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT task_log_assigned_to_id_fk FOREIGN KEY (task_log_assigned_to_id) REFERENCES employee (employee_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT task_log_animal_id_fk FOREIGN KEY (animal_id) REFERENCES animal (animal_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE animal_training (
  animal_type_id      NUMBER(10) CONSTRAINT animal_training_type_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  employee_id         NUMBER(10) CONSTRAINT animal_training_emp_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_arrival_date DATE DEFAULT CURRENT_DATE,
  CONSTRAINT animal_training_pk PRIMARY KEY (animal_type_id, employee_id) DEFERRABLE INITIALLY IMMEDIATE
);

-- CREATE SEQUENCE employee_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE behavior_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE kennel_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE animal_subtype_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE animal_type_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE task_log_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE task_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE adoption_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE animal_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
-- CREATE SEQUENCE animal_detail_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER employee_id
BEFORE INSERT ON employee
FOR EACH ROW
  BEGIN
    :new.employee_id := employee_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER behavior_id
BEFORE INSERT ON behavior
FOR EACH ROW
  BEGIN
    :new.behavior_id := behavior_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER kennel_id
BEFORE INSERT ON kennel
FOR EACH ROW
  BEGIN
    :new.kennel_id := kennel_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER animal_subtype_id
BEFORE INSERT ON animal_subtype
FOR EACH ROW
  BEGIN
    :new.animal_subtype_id := animal_subtype_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER animal_type_id
BEFORE INSERT ON animal_type
FOR EACH ROW
BEGIN
  :new.animal_type_id := animal_type_id_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER task_id
BEFORE INSERT ON task
FOR EACH ROW
  BEGIN
    :new.task_id := task_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER task_log_id
BEFORE INSERT ON task_log
FOR EACH ROW
  BEGIN
    :new.task_log_id := task_log_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER adoption_id
BEFORE INSERT ON adoption
FOR EACH ROW
  BEGIN
    :new.adoption_id := adoption_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER animal_id
BEFORE INSERT ON animal
FOR EACH ROW
  BEGIN
    :new.animal_id := animal_id_seq.nextval;
  END;
/

CREATE OR REPLACE TRIGGER animal_detail_id
BEFORE INSERT ON animal_detail
FOR EACH ROW
  BEGIN
    :new.animal_detail_id := animal_detail_id_seq.nextval;
  END;
/

/*
*****************
Add Data to Table
*****************
 */
-- ALTER SESSION SET CONSTRAINTS = DEFERRED;
--
-- INSERT ALL
--   INSERT INTO employee()
-- SELECT * FROM DUAL;
--
-- ALTER SESSION SET CONSTRAINTS = IMMEDIATE;