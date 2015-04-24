CREATE OR REPLACE FUNCTION animal_size(height IN FLOAT, weight IN FLOAT)
  RETURN VARCHAR2
IS
  BEGIN
    CASE
      WHEN height > 36 OR weight > 80
      THEN RETURN 'large';
      WHEN height > 20 OR weight > 40
      THEN RETURN 'medium';
      WHEN height > 10 OR weight > 15
      THEN RETURN 'small';
      WHEN height < 10 OR weight < 20
      THEN RETURN 'tiny';
    ELSE RETURN 'unknown';
    END CASE;
  END;
/

SELECT
  animal_detail_height,
  animal_detail_weight,
  animal_size(animal_detail_height, animal_detail_weight)
FROM animal_detail;