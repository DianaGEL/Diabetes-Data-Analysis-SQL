pima_diabetes=# \copy diabetes FROM '~/Downloads/diabetes.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE diabetes (
  pregnancies INT,
  plasma_glucose FLOAT,
  blood_pressure FLOAT,
  skin_thickness FLOAT,
  insulin FLOAT,
  BMI FLOAT,
  diabetes_pedigree FLOAT,
  age INT,
  outcome INT
);

SELECT COUNT(*) FROM diabetes;

SELECT * FROM diabetes;

SELECT AVG(age) AS average_age FROM diabetes;

SELECT MIN(plasma_glucose) AS min_glucose, MAX(plasma_glucose) AS max_glucose FROM diabetes;


SELECT CORR(plasma_glucose, bmi) AS correlation
FROM diabetes

SELECT CORR(plasma_glucose, age) AS correlation
FROM diabetes

SELECT outcome, AVG(bmi) AS average_bmi
FROM diabetes
GROUP BY outcome;


SELECT outcome, AVG(insulin) AS average_insulin
FROM diabetes
GROUP BY outcome;


SELECT age, plasma_glucose, CAST(ROUND(AVG(pregnancies)) AS INTEGER) AS average_pregnancies
FROM diabetes
GROUP BY age, plasma_glucose;


SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY insulin) AS median_insulin
FROM diabetes;


SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY plasma_glucose) AS median_glucose
FROM diabetes;


SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY bmi) AS q1_value,
       percentile_cont(0.5) WITHIN GROUP (ORDER BY bmi) AS median_value,
       percentile_cont(0.75) WITHIN GROUP (ORDER BY bmi) AS q3_value
FROM diabetes;


SELECT age AS mode_value
FROM (
    SELECT age, COUNT(*) AS occurrence
    FROM diabetes
    GROUP BY age
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS subquery;


SELECT ROUND(CAST(STDDEV(blood_pressure) AS NUMERIC), 2) AS blood_pressure_sd
FROM diabetes;


SELECT ROUND(CAST(STDDEV(diabetes_pedigree) AS NUMERIC), 4) AS diabetes_pedigree_sd
FROM diabetes;


SELECT age, plasma_glucose, outcome,
       COUNT(*) AS total_count,
       CAST(ROUND(AVG(pregnancies)) AS INT) AS average_pregnancies,
       MIN(blood_pressure) AS min_blood_pressure,
       MAX(blood_pressure) AS max_blood_pressure,
       ROUND(CAST(AVG(bmi) AS NUMERIC), 2) AS average_bmi
FROM diabetes
GROUP BY age, plasma_glucose, outcome;
