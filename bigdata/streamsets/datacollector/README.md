## 1. MySQL to PostgreSQL
1. Create destination database + table
    ```sql
    CREATE DATABASE dolphin;

    CREATE TABLE public.actor (
        actor_id int4 NOT NULL,
        first_name varchar NOT NULL,
        last_name varchar NOT NULL,
        last_update timestamp NOT NULL DEFAULT now(),
        CONSTRAINT actor_pk PRIMARY KEY (actor_id)
    );
    ```
2. Import pipeleine
    Import `./pipeline/mysql-postgres.json` file
3. Config credential for MySQL & PostgreSQL in pipeline

## 2. MySQL to MinIO
1. Create bucket on MinIO
    create bucket name `ocean`
2. Import pipeline
    Import `./pipeline/mysql-postgres.json` file
3. Config credential for MySQL & PostgreSQL in pipeline
