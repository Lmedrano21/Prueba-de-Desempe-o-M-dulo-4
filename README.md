# Corporate Technical Support System - Database Optimization Project

## Project description
This repository contains the complete engineering solution for the corporate technical support module's database layer. The original unstructured operational data ledger, which suffered from severe insertion, update, and deletion anomalies, was comprehensively audited and re-engineered. By applying mathematical normalization rules up to the Third Normal Form (3NF), the data model was restructured into a highly secure relational schema that eliminates redundancies, prevents syntax-based duplicates, and ensures strict business transactional logic.

## Technologies used
*   **Database Engine Model:** Object-Relational Database Management System (ORDBMS).
*   **Language Syntax:** ANSI SQL / PostgreSQL Dialect.
*   **Administration Tools:** pgAdmin 4 / JetBrains DataGrip.
*   **Testing Suite:** Transactional SQL scripts for operational data manipulation language (DML) verification.

## Database engine
The chosen engine for this enterprise deployment is **PostgreSQL**. This platform was specifically selected due to its robust support for explicit case-sensitive identifier storage using double quotes, strong integrity referential constraint checks, transactional atomicity handling (`BEGIN; ... COMMIT;`), and exceptional analytical throughput when executing structural aggregate operations for corporate metrics.

## Explanation of the normalization process
*   **First Normal Form (1FN):** Ensured complete atomic consistency. Multi-valued fields and unformatted string variations were parsed. Unique individual row keys were specified to anchor the dataset.
*   **Second Normal Form (2FN):** Eliminated partial functional dependencies. Core organizational operational domains like `riwi_client`, `public."riwi_Technician"`, and `public."riwi_Equipment"` were separated from the main transaction register into their own lookup tables.
*   **Third Normal Form (3NF):** Extinguished transitive dependencies. Complex multi-tier hierarchical parameters (such as the relationship mapping of `public.riwi_city` across distribution facilities or item types categorized within hardware groups) were separated into singular independent lookup points, removing update overhead anomalies across the board.

## Database structure
The database structure uses case-sensitive identifiers and strict schemas as displayed below:
*   `riwi_client` - Master registry tracking corporate consumers.
*   `public.riwi_city` - Isolated geographical boundary records.
*   `riwi_branches` - Customer service point locations mapped to specific cities.
*   `public."riwi_Technician"` - Field operator profiles and credentials.
*   `public."riwi_EquipmentCategory"` - Structural groupings for hardware hardware assets.
*   `public."riwi_Equipment"` - Individual technological devices under operational monitoring.
*   `public."riwi_ServiceTypent"` - System service categories with financial baseline grids.
*   `public."riwi_WorkOrders"` - Central transactional engine recording dates, timelines, and costs.

## Entity Relationship Diagram
The logical modeling maps out a normalized physical layout. It guarantees absolute referential safety structures by using `ON DELETE RESTRICT` and `ON UPDATE CASCADE` constraints on the foreign key linkages across all data entities.
*(The visual diagram asset is rendered inside the `ERD_Diagram.png` or `ERD_Diagram.pdf` files embedded inside this repository root directory)*.

## Database creation instructions
1. Connect to your active PostgreSQL server instance using your credentials.
2. Initialize the physical system catalog space by executing the creation directive:
   ```sql
   CREATE DATABASE bd_luis_medrano_cayena;
   ```
3. Open a query tool instance pointing directly to the newly instantiated database namespace.
4. Execute the structural definitions script contained in your DDL sequence file to build out the schemas.

## Data loading instructions
To successfully populate the database without triggering Referential Integrity (`Foreign Key Constraint`) exceptions, records must be inserted following a strict hierarchical sequence:
1.  **Tier 1 (Independent Catalogs):** Load foundational records into `riwi_client`, `public.riwi_city`, `public."riwi_Technician"`, `public."riwi_EquipmentCategory"`, and `public."riwi_ServiceTypent"`.
2.  **Tier 2 (Dependent Master Tables):** Load relational assets into `riwi_branches` and `public."riwi_Equipment"`.
3.  **Tier 3 (Transactional Logs):** Load the 20 historical operations directly into `public."riwi_WorkOrders"`, passing exact matching structural integer keys for all relational identifiers.

## Explanation of each SQL query

### Query 1: Work Order Volumes Handled by Technician Profiles
Identifies work allocation balance thresholds across operational staff to safely optimize workforce scheduling distribution profiles.
```sql
SELECT 
    t."full_Name_Technician" AS technician_name, 
    COUNT(w."id_WorkOrder") AS total_orders_handled
FROM public."riwi_Technician" t
LEFT JOIN public."riwi_WorkOrders" w ON t."id_Technician" = w."id_Technician"
GROUP BY t."id_Technician", t."full_Name_Technician"
ORDER BY total_orders_handled DESC;
```

### Query 2: Historical Technical Operations Summarized by Cities
Pinpoints geographic service concentrations to provide critical regional logistics insight to company management.
```sql
SELECT 
    c."name_City" AS city_name, 
    COUNT(w."id_WorkOrder") AS total_services_performed
FROM public.riwi_city c
JOIN public."riwi_WorkOrders" w ON c."id_city" = w."id_city"
GROUP BY c."id_city", c."name_City"
ORDER BY total_services_performed DESC;
```

### Query 3: Service Type Aggregations by Customer Requests
Highlights key consumer product preferences, helping management optimize technical training and resource planning.
```sql
SELECT 
    s."name_Service_Type" AS service_type, 
    COUNT(w."id_WorkOrder") AS total_requests
FROM public."riwi_ServiceTypent" s
LEFT JOIN public."riwi_WorkOrders" w ON s."id_Service_Type_Nt" = w."id_ServiceType"
GROUP BY s."id_Service_Type_Nt", s."name_Service_Type"
ORDER BY total_requests DESC;
```

### Query 4: Hardware Systems Flagged with High Maintenance Incident Recurrence
Tracks hardware error frequency rates to isolate equipment with high failure counts, supporting lifecycle evaluation metrics.
```sql
SELECT 
    e."name_Equipment" AS equipment_model, 
    COUNT(w."id_WorkOrder") AS total_maintenance_count
FROM public."riwi_Equipment" e
JOIN public."riwi_WorkOrders" w ON e."id_Equipment" = w."id_Equipment"
GROUP BY e."id_Equipment", e."name_Equipment"
ORDER BY total_maintenance_count DESC;
```

### Query 5: Premium Corporate Client Ranking Based on Operational Activity
Filters and isolates the highest-volume business accounts, providing data to help the commercial division drive loyalty programs.
```sql
SELECT 
    cl."full_Name_Client" AS client_name, 
    COUNT(w."id_WorkOrder") AS total_orders_placed
FROM riwi_client cl
JOIN public."riwi_WorkOrders" w ON cl."id_client" = w."id_client"
GROUP BY cl."id_client", cl."full_Name_Client"
ORDER BY total_orders_placed DESC;
```

```

## Developer information
*   **Full Name:** LUIS ALFREDO MEDERANO CABALLEERO
*   **Clan:** CAYENA

