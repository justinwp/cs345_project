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
  animal_type_name        VARCHAR2(50) CONSTRAINT animal_type_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE
    CONSTRAINT animal_type_name_uq UNIQUE DEFERRABLE INITIALLY IMMEDIATE,
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
  animal_id            NUMBER(10) CONSTRAINT animal_detail_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_detail_age    INTERVAL YEAR TO MONTH,
  animal_detail_height FLOAT(2),
  animal_detail_weight FLOAT(2),
  animal_detail_color  VARCHAR2(20),
  animal_detail_notes  VARCHAR2(255),
  CONSTRAINT animal_detail_id_pk PRIMARY KEY (animal_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE animal (
  animal_id           NUMBER(10) CONSTRAINT animal_animal_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_subtype_id   NUMBER(10),
  kennel_id           NUMBER(10),
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
  task_name        VARCHAR2(50) CONSTRAINT task_name_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE
    CONSTRAINT task_name_uq UNIQUE DEFERRABLE INITIALLY IMMEDIATE,
  task_description VARCHAR2(255),
  CONSTRAINT task_id_pk PRIMARY KEY (task_id) DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE task_log (
  task_log_id             NUMBER(10) CONSTRAINT task_log_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  task_id                 NUMBER(10) CONSTRAINT task_log_task_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  kennel_id               NUMBER(10),
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
  animal_type_id           NUMBER(10) CONSTRAINT animal_training_type_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  employee_id              NUMBER(10) CONSTRAINT animal_training_emp_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  training_completion_date DATE DEFAULT CURRENT_DATE,
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


/*
*********
Triggers
*********
 */
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
/*
*************
Procedures
*************
 */

CREATE OR REPLACE PROCEDURE add_animal(p_name VARCHAR2, p_type VARCHAR2, p_subtype VARCHAR2) IS
  p_type_id    NUMBER;
  p_subtype_id NUMBER;
  p_kennel_id  NUMBER;
  BEGIN
    dbms_output.put_line('Begin Animal Add Procedure ');

    dbms_output.put_line('Determining type... for ' || p_type);
    SELECT COUNT(animal_type_id)
    INTO p_type_id
    FROM animal_type
    WHERE lower(animal_type_name) = lower(p_type);

    dbms_output.put_line('Type number is: ' || p_type_id);

    dbms_output.put_line('Determining subtype... for ' || p_subtype);

    IF p_subtype IS NOT NULL
    THEN
      SELECT animal_subtype_id
      INTO p_subtype_id
      FROM animal_subtype
      WHERE lower(animal_subtype_name) = lower(p_subtype) AND animal_type_id = p_type_id;
    ELSE
      SELECT animal_subtype_id
      INTO p_subtype_id
      FROM animal_subtype
      WHERE lower(animal_subtype_name) = 'unknown' AND animal_type_id = p_type_id;

    END IF;

    dbms_output.put_line('Subtype number is: ' || p_subtype_id);


    dbms_output.put_line('Finding Kennel... ');
    SELECT kennel_id
    INTO p_kennel_id
    FROM kennel
    WHERE kennel_id = (SELECT MAX(spaces)
                       FROM kennel_capacity
                       WHERE animal_type_id = p_type_id);

    INSERT INTO animal (animal_name, animal_subtype_id, kennel_id) VALUES (p_name, p_subtype_id, p_kennel_id);

    IF p_name IS NULL
    THEN
      dbms_output.put_line('Put Animal #' || animal_id_seq.CURRVAL || ' into Kennel #' || p_kennel_id);
    ELSE
      dbms_output.put_line('Put ' || p_name || ' #' || animal_id_seq.CURRVAL || ' into Kennel #' || p_kennel_id);

    END IF;
    dbms_output.put_line('End Animal Add Procedure ');
    COMMIT;
  END;
/



/*
*************
Create Views
*************
 */

-- Public
-- View all available animals

CREATE OR REPLACE VIEW available_animals AS
  SELECT
    A.animal_name,
    AT.animal_type_name,
    AST.animal_subtype_name,
    AD.animal_detail_height,
    AD.animal_detail_weight,
    AD.animal_detail_color,
    AD.animal_detail_notes,
    B.behavior_name
  FROM animal A JOIN animal_detail AD ON A.animal_id = AD.animal_id
    JOIN animal_subtype AST ON A.animal_subtype_id = AST.animal_subtype_id
    JOIN animal_type AT ON AST.animal_type_id = AT.animal_type_id
    JOIN animal_behavior AB ON A.animal_id = AB.animal_id
    JOIN behavior B ON AB.behavior_id = B.behavior_id
  WHERE A.animal_id NOT IN
        (SELECT animal_id
         FROM adoption);

-- Employee
-- View all incomplete tasks

CREATE OR REPLACE VIEW tasks_to_do AS
  SELECT
    T.task_name,
    TL.task_log_assigned_date,
    E.employee_first_name,
    E.Employee_last_name,
    A.animal_name,
    AT.animal_type_name,
    AST.animal_subtype_name
  FROM task_log TL
    JOIN task T ON TL.task_id = T.task_id
    JOIN employee E ON TL.task_log_assigned_to_id = E.employee_id
    LEFT OUTER JOIN animal A ON TL.animal_id = A.animal_id
    LEFT OUTER JOIN animal_detail AD ON A.animal_id = AD.animal_id
    LEFT OUTER JOIN animal_subtype AST ON A.animal_subtype_id = AST.animal_subtype_id
    JOIN animal_type AT ON AST.animal_type_id = AT.animal_type_id
  WHERE task_log_completed_date IS NULL
  ORDER BY TL.task_log_assigned_date DESC;


-- Manager
-- View all employees and what animal training they have completed

CREATE OR REPLACE VIEW employee_training AS
  SELECT
    E.employee_id,
    E.employee_first_name,
    E.employee_last_name,
    ATY.animal_type_name
  FROM animal_training AT
    FULL OUTER JOIN employee E ON AT.employee_id = E.employee_id
    FULL OUTER JOIN animal_type ATY ON AT.animal_type_id = ATY.animal_type_id;

CREATE OR REPLACE VIEW kennel_capacity AS
  SELECT
    kennel_id,
    NVL(kennel_space - x.filled_spaces, kennel_space) AS spaces,
    animal_type_id
  FROM kennel
    LEFT OUTER JOIN (SELECT
            kennel_id,
            COUNT(*) AS filled_spaces
          FROM animal
          GROUP BY kennel_id) x USING (kennel_id)
  ORDER BY spaces DESC;


