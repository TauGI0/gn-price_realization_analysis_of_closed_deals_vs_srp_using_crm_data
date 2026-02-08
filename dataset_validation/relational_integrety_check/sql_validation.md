# **SQL-Based Data Validation**

This section documents all SQL validations performed to ensure
**structural correctness, referential integrity, and model reliability**
prior to analysis.

---

## **Referential Integrity**

### **1. Orphaned Foreign Keys (Fact > Dimension)**

Ensure that all foreign keys in the fact table reference an existing record in the corresponding dimension table.

### Validation Query

```sql
SELECT COUNT(*) AS orphan_<entity>_rows
FROM <fact_table> fct
LEFT JOIN <dimension_table> dim 
	ON fct.<foreign_key> = dim.<primary_key>
WHERE dim.<primary_key> IS NULL;
```

The query should return zero (0) count which indicated that all records in the Fact table is referencing and exisiting Dimention record.

### Result:

Orphan Records Detected
- agent_id   : 0
- account_id : 0
- product_id : 0

### Conclusion

**Passed** - No orphaned foreign keys

### **2. Dimension Coverage (Dimension > Fact)**

Identify dimension records that do not appear in the fact table.

### Validation Query

```sql
SELECT COUNT(*) AS unref_dim_<entity>
FROM <dimension_table> dim
LEFT JOIN <fact_table> fct
  ON fct.<foreign_key> = dim.<primary_key>
WHERE fct.<foreign_key> IS NULL;
```

### Result:

Unused Records Detected
- agent_id   : 5
- account_id : 0
- product_id : 0

### Investigation

#### Identification

Five (5) agents were identified with no corresponding records in the cleaned fact table (closed deals only):

| Agent Name           |
|---------------------|
| Carol Thompson       |
| Mei-Mei Johns       |
| Natalya Ivanova     |
| Carl Lin            |
| Elizabeth Anderson  |

#### Pattern Analysis

A review of region and manager attributes was conducted for the identified agents.

| agent_id_fact | agent_id  | sales_agent        | manager         | regional_office |
|---------------|-----------|------------------|----------------|----------------|
| [null]        | 30000029  | Carol Thompson    | Celia Rouche   | West           |
| [null]        | 30000011  | Mei-Mei Johns     | Melvin Marxen  | Central        |
| [null]        | 30000023  | Natalya Ivanova   | Rocco Neubert  | East           |
| [null]        | 30000035  | Carl Lin          | Summer Sewald  | West           |
| [null]        | 30000017  | Elizabeth Anderson| Cara Losch     | East           |

Findings:
No shared region, manager, or organizational pattern was identified.

#### Raw Data Validation

To determine whether these agents were excluded due to business logic (closed deals only), the raw dataset containing all deal statuses was evaluated.

| agent_raw | agent_id  | sales_agent        | manager         | regional_office |
|-----------|-----------|------------------|----------------|----------------|
| [null]    | 30000035  | Carl Lin          | Summer Sewald  | West           |
| [null]    | 30000023  | Natalya Ivanova   | Rocco Neubert  | East           |
| [null]    | 30000029  | Carol Thompson    | Celia Rouche   | West           |
| [null]    | 30000017  | Elizabeth Anderson| Cara Losch     | East           |
| [null]    | 30000011  | Mei-Mei Johns     | Melvin Marxen  | Central        |

Findings:
The same five agents were not present in the raw dataset, indicating no participation in either closed or ongoing deals during the reporting period.

#### Interpretation

- These agents did not engage in any recorded sales activity within the dataset timeframe.
- There is no evidence of data loss, ETL filtering issues, or join key mismatches.
- Agent hire date data is unavailable, preventing tenure-based conclusions.
- No effect on analytical accuracy or model validity.

### Conclusion

**Passed** - The lack of dimention coverage for some sales agents are explainable and non-impacting.

---

Referential integrity has been validated, unused dimensions have been investigated and explained, and no data handling issues were identified. Analysis can proceed under the documented business constraints.



