# Cruiseschip Database

A relational database management system developed in PostgreSQL for a cruise booking platform.

## Getting Started

**Prerequisites:** PostgreSQL (any recent version), `psql` or a GUI client (e.g. pgAdmin, DBeaver)

1. Create the schema and tables:

   ```bash
   psql -U <your_username> -d <your_database> -f create-database.sql
   ```

2. Load the sample data (~13,000 rows across all tables):

   ```bash
   psql -U <your_username> -d <your_database> -f insert-data.sql
   ```

3. Run the example queries:

   ```bash
   psql -U <your_username> -d <your_database> -f queries.sql
   ```

   Everything lives under the `cruise_db` schema, so it won't collide with anything else in the target database.

4. To tear it down:

   ```bash
   psql -U <your_username> -d <your_database> -f delete-database.sql
   ```

All sample data (passengers, bookings, crew, contact details) is synthetically generated for testing — none of it is real.

## Features

- Relational database architecture
- Management of ships, ports, and cabins
- Customer and passenger booking systems
- Onboard activities tracking
- DDL scripts for schema creation and clean-up
- DML scripts with comprehensive test data
- Visual entity-relationship and conceptual models

## Technologies

- PostgreSQL
- SQL

## Project Structure

```text
cruiseschip-database/
├── create-database.sql     # DDL: schema + tables
├── insert-data.sql         # DML: sample/test data
├── delete-database.sql     # drops everything
├── queries.sql             # example queries
├── physical-model.png      # physical ER diagram
├── conceptual-model.pdf    # conceptual model
├── logical-model.pdf       # logical model
├── LICENSE
└── README.md
```

Table and column names throughout the schema are in Dutch, matching how the database was originally designed.
