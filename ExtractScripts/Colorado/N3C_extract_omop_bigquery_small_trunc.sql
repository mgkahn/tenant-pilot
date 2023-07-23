

--DATA_COUNTS TABLE
--OUTPUT_FILE: DATA_COUNTS.csv
SELECT * from
(select
   'PERSON' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.PERSON p JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON p.PERSON_ID = n.PERSON_ID) as ROW_COUNT

UNION ALL

select
   'OBSERVATION_PERIOD' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.OBSERVATION_PERIOD op JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON op.PERSON_ID = n.PERSON_ID AND (OBSERVATION_PERIOD_START_DATE >= DATE(2018,01,01) OR OBSERVATION_PERIOD_END_DATE >= DATE(2018,01,01)) ) as ROW_COUNT

UNION ALL

select
   'VISIT_OCCURRENCE' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.VISIT_OCCURRENCE vo JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON vo.PERSON_ID = n.PERSON_ID AND VISIT_START_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'CONDITION_OCCURRENCE' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.CONDITION_OCCURRENCE co JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON co.PERSON_ID = n.PERSON_ID AND CONDITION_START_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'DRUG_EXPOSURE' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.DRUG_EXPOSURE de JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON de.PERSON_ID = n.PERSON_ID AND DRUG_EXPOSURE_START_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'DEVICE_EXPOSURE' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.DEVICE_EXPOSURE de JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON de.PERSON_ID = n.PERSON_ID AND DEVICE_EXPOSURE_START_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'PROCEDURE_OCCURRENCE' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.PROCEDURE_OCCURRENCE po JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON po.PERSON_ID = n.PERSON_ID AND PROCEDURE_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'MEASUREMENT' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.MEASUREMENT m JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON m.PERSON_ID = n.PERSON_ID AND MEASUREMENT_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'OBSERVATION' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.OBSERVATION o JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON o.PERSON_ID = n.PERSON_ID AND OBSERVATION_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

SELECT
   'DEATH' as TABLE_NAME,
  (select count(*) from @cdmDatabaseSchema.DEATH d JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON d.PERSON_ID = n.PERSON_ID AND DEATH_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'LOCATION' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.LOCATION l
   JOIN (
        SELECT DISTINCT p.LOCATION_ID
        FROM @cdmDatabaseSchema.PERSON p
        JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON p.person_id = n.person_id
      ) a
  ON l.location_id = a.location_id) as ROW_COUNT

UNION ALL

select
   'CARE_SITE' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.CARE_SITE cs
	JOIN (
        SELECT DISTINCT CARE_SITE_ID
        FROM @cdmDatabaseSchema.VISIT_OCCURRENCE vo
        JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON vo.person_id = n.person_id
      ) a
  ON cs.CARE_SITE_ID = a.CARE_SITE_ID) as ROW_COUNT

UNION ALL

 select
   'PROVIDER' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.PROVIDER pr
	JOIN (
       SELECT DISTINCT PROVIDER_ID
       FROM @cdmDatabaseSchema.VISIT_OCCURRENCE vo
       JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON vo.PERSON_ID = n.PERSON_ID
       UNION ALL
       SELECT DISTINCT PROVIDER_ID
       FROM @cdmDatabaseSchema.DRUG_EXPOSURE de
       JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON de.PERSON_ID = n.PERSON_ID
       UNION ALL
       SELECT DISTINCT PROVIDER_ID
       FROM @cdmDatabaseSchema.MEASUREMENT m
       JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON m.PERSON_ID = n.PERSON_ID
       UNION ALL
       SELECT DISTINCT PROVIDER_ID
       FROM @cdmDatabaseSchema.PROCEDURE_OCCURRENCE po
       JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON po.PERSON_ID = n.PERSON_ID
       UNION ALL
       SELECT DISTINCT PROVIDER_ID
       FROM @cdmDatabaseSchema.OBSERVATION o
       JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n
          ON o.PERSON_ID = n.PERSON_ID
     ) a
 ON pr.PROVIDER_ID = a.PROVIDER_ID) as ROW_COUNT

UNION ALL

select
   'DRUG_ERA' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.DRUG_ERA de JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT n ON de.PERSON_ID = n.PERSON_ID AND DRUG_ERA_START_DATE >= DATE(2018,01,01)) as ROW_COUNT

UNION ALL

select
   'CONDITION_ERA' as TABLE_NAME,
   (select count(*) from @cdmDatabaseSchema.CONDITION_ERA JOIN @resultsDatabaseSchema.N3C_CLINICAL_COHORT ON CONDITION_ERA.PERSON_ID = N3C_CLINICAL_COHORT.PERSON_ID AND CONDITION_ERA_START_DATE >= DATE(2018,01,01)) as ROW_COUNT
) s;

