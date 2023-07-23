--MEASUREMENT
--OUTPUT_FILE: MEASUREMENT_2022.csv
SELECT
   MEASUREMENT_ID,
   n.PERSON_ID,
   MEASUREMENT_CONCEPT_ID,
   CAST(MEASUREMENT_DATE as datetime) as MEASUREMENT_DATE,
   CAST(MEASUREMENT_DATETIME as datetime) as MEASUREMENT_DATETIME,
   NULL as MEASUREMENT_TIME,
   MEASUREMENT_TYPE_CONCEPT_ID,
   OPERATOR_CONCEPT_ID,
   VALUE_AS_NUMBER,
   VALUE_AS_CONCEPT_ID,
   UNIT_CONCEPT_ID,
   RANGE_LOW,
   RANGE_HIGH,
   PROVIDER_ID,
   VISIT_OCCURRENCE_ID,
   NULL as VISIT_DETAIL_ID,
   MEASUREMENT_SOURCE_VALUE,
   MEASUREMENT_SOURCE_CONCEPT_ID,
   NULL as UNIT_SOURCE_VALUE,
   NULL as VALUE_SOURCE_VALUE
FROM @cdmDatabaseSchema.MEASUREMENT m
JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
  ON M.PERSON_ID = N.PERSON_ID
WHERE m.MEASUREMENT_DATE >= DATE(2022,01,01) and m.MEASUREMENT_DATE <= DATE(2022,12,31);
