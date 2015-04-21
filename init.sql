/*

Group Project IV Initialization Script

>> set echo on
>> @init.sql

 */



/*
*************
Drop Tables
*************

Start from a clean database. See below for prefixing so that homework tables are not dropped and order of drop
*/

-- DROP TABLE animal;
-- DROP TABLE kennel;
-- DROP TABLE animal_subtype;
-- DROP TABLE animal_type;



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

CREATE TABLE animal (
  animal_id           NUMBER(10) CONSTRAINT animal_animal_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  animal_subtype_id   NUMBER(10) CONSTRAINT animal_animal_subtype_id_nn NOT NULL DEFERRABLE INITIALLY IMMEDIATE,
  kennel_id           NUMBER(10),
  animal_name         VARCHAR2(50),
  animal_arrival_date DATE DEFAULT CURRENT_DATE,
  CONSTRAINT animal_animal_id_pk PRIMARY KEY (animal_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_animal_subtype_id_fk FOREIGN KEY (animal_subtype_id) REFERENCES animal_subtype (animal_subtype_id) DEFERRABLE INITIALLY IMMEDIATE,
  CONSTRAINT animal_kennel_id_fk FOREIGN KEY (kennel_id) REFERENCES kennel (kennel_id) DEFERRABLE INITIALLY IMMEDIATE
);


/*
*****************
Add Data to Table
*****************
 */

