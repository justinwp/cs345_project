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

CREATE SEQUENCE employee_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE behavior_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE kennel_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_subtype_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_type_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE task_log_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE task_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE adoption_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE animal_id_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;

/*
Populate static tables
 */
INSERT INTO animal_type (animal_type_name) VALUES ('dog');
INSERT INTO animal_type (animal_type_name) VALUES ('cat');
INSERT INTO animal_type (animal_type_name) VALUES ('horse');
INSERT INTO animal_type (animal_type_name) VALUES ('parrot');
INSERT INTO animal_type (animal_type_name) VALUES ('fish');

INSERT INTO behavior (behavior_name) VALUES ('Aggressive');
INSERT INTO behavior (behavior_name) VALUES ('Shy');
INSERT INTO behavior (behavior_name) VALUES ('Playful');
INSERT INTO behavior (behavior_name) VALUES ('Skittish');
INSERT INTO behavior (behavior_name) VALUES ('Sleepy');

INSERT INTO task (task_name) VALUES ('Clean Kennel');
INSERT INTO task (task_name) VALUES ('Walk Animal');
INSERT INTO task (task_name) VALUES ('Clean Animal');
INSERT INTO task (task_name) VALUES ('Give Vaccination');
INSERT INTO task (task_name) VALUES ('Neuter');
INSERT INTO task (task_name) VALUES ('Feed');

INSERT INTO employee (employee_first_name, employee_last_name, employee_phone)
VALUES ('Justin', 'Poehnelt', '12312321');
INSERT INTO employee (employee_first_name, employee_last_name, employee_phone) VALUES ('Doug', 'Peterson', '12312321');
INSERT INTO employee (employee_first_name, employee_last_name, employee_phone) VALUES ('Zach', 'Patten', '12312321');
INSERT INTO employee (employee_first_name, employee_last_name, employee_phone) VALUES ('Ian ', 'Houseman', '12312321');
INSERT INTO employee (employee_first_name, employee_last_name, employee_phone) VALUES ('Tomas', 'Zukowski', '12312321');
COMMIT;


INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Border Collie', 1);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Golden Retriever', 1);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Pit Bull', 1);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Poodle', 1);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Terrier', 1);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Unknown', 1);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Unknown', 2);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Unknown', 3);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Unknown', 4);
INSERT INTO animal_subtype (animal_subtype_name, animal_type_id) VALUES ('Unknown', 5);

INSERT INTO kennel (kennel_space, animal_type_id) VALUES (3, 1);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (3, 1);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (2, 1);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (1, 1);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (10, 2);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (10, 1);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 2);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 3);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 4);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 5);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 3);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 3);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 3);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 3);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 2);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 1);
INSERT INTO kennel (kennel_space, animal_type_id) VALUES (5, 5);
COMMIT;


EXECUTE add_animal('Sparky', 'dog', 'Terrier');
EXECUTE add_animal('Toto', 'dog', 'Poodle');
EXECUTE add_animal('Barks', 'dog', NULL);
EXECUTE add_animal(NULL, 'dog', NULL);
EXECUTE add_animal(NULL, 'cat', NULL);
EXECUTE add_animal('Buddy', 'dog', 'Golden Retriever');
EXECUTE add_animal(NULL, 'dog', 'Pit Bull');
EXECUTE add_animal(NULL, 'cat', NULL);
EXECUTE add_animal(NULL, 'cat', NULL);
EXECUTE add_animal(NULL, 'horse', NULL);
EXECUTE add_animal(NULL, 'fish', NULL);
EXECUTE add_animal(NULL, 'parrot', NULL);

--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(1, 1, 'Sparky');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(1, 2, 'Toto');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(1, 3, 'Barks');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(1, 2, 'Buddy');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(7, 5, 'Sneaky');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(7, 5, 'Cat123');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(7, 5, 'Cat124');
--   INSERT INTO animal(animal_subtype_id, kennel_id, animal_name) VALUES(7, 7, 'Cat125');

INSERT INTO animal_detail VALUES (1, NULL, 10, 20, 'Brown', 'Smells bad.');
INSERT INTO animal_detail VALUES (2, NULL, 20, 20, 'Black', NULL);
INSERT INTO animal_detail VALUES (3, NULL, 30, 20.12, 'Brown', NULL);
INSERT INTO animal_detail VALUES (4, NULL, 40, 100.2, 'Tan', 'Very big.');
INSERT INTO animal_detail VALUES (5, NULL, 10, 10.21, 'Brown', NULL);

INSERT INTO adoption (animal_id, employee_id) VALUES (2, 3);
INSERT INTO adoption (animal_id, employee_id) VALUES (3, 4);

INSERT INTO animal_behavior VALUES (1, 3);
INSERT INTO animal_behavior VALUES (1, 4);
INSERT INTO animal_behavior VALUES (2, 2);
INSERT INTO animal_behavior VALUES (4, 5);
INSERT INTO animal_behavior VALUES (7, 1);

INSERT INTO animal_training (animal_type_id, employee_id) VALUES (1, 1);
INSERT INTO animal_training (animal_type_id, employee_id) VALUES (2, 1);
INSERT INTO animal_training (animal_type_id, employee_id) VALUES (1, 2);
INSERT INTO animal_training (animal_type_id, employee_id) VALUES (1, 3);
INSERT INTO animal_training (animal_type_id, employee_id) VALUES (3, 1);
INSERT INTO animal_training (animal_type_id, employee_id) VALUES (4, 4);

INSERT INTO task_log (task_id, kennel_id, task_log_assigned_by_id, task_log_assigned_to_id) VALUES (1, 3, 1, 2);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (2, 4, 2);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id, task_log_assigned_to_id) VALUES (3, 2, 3, 3);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (3, 2, 4);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (6, 1, 2);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (6, 2, 2);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id, task_log_assigned_to_id) VALUES (6, 3, 1, 1);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (6, 4, 2);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (6, 5, 4);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id, task_log_assigned_to_id) VALUES (6, 6, 3, 1);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (6, 7, 1);
INSERT INTO task_log (task_id, animal_id, task_log_assigned_by_id) VALUES (6, 8, 2);




