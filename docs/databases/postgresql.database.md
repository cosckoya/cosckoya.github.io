---
title: PostgreSQL
description: Advanced open-source relational database - ACID compliant, extensible, production-proven
tags:
  - postgresql
  - database
  - sql
  - relational
---

# :lucide-database: PostgreSQL

Advanced open-source relational database. ACID compliant, extensible, battle-tested. The default choice for new projects. Not as fast as MySQL for simple reads, but far more reliable and feature-rich. MVCC, JSON support, full-text search, custom functions. "It just works" is rare in databases — Postgres is the exception.

!!! tip "2026 Update"
    PostgreSQL 17 improves performance for large analytic queries, adds incremental backup, and enhances the SQL/JSON constructor. Extensions remain the killer feature (PostGIS, pgvector, TimescaleDB). Managed cloud services (RDS, Cloud SQL, Supabase) dominate production deployments.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Connect to database
    psql -h localhost -U myuser -d mydb

    # Common psql commands
    \l                    # List databases
    \dt                   # List tables
    \d tablename          # Describe table (columns, indexes)
    \du                   # List users/roles
    \x                    # Toggle expanded display
    \q                    # Quit

    # Create database and user
    CREATE DATABASE mydb;
    CREATE USER myuser WITH PASSWORD 'secure_pass';
    GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;

    # Backup and restore
    pg_dump mydb > backup.sql
    pg_dump -h remote_host mydb > remote_backup.sql
    psql mydb < backup.sql

    # Performance
    EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';
    SELECT pg_size_pretty(pg_database_size('mydb'));
    ```

    **Real talk:**

    - `psql` is the best CLI client of any database
    - Always use `EXPLAIN ANALYZE` before optimizing queries
    - `pg_dump` is your friend — automate backups day 1
    - Default `postgresql.conf` is conservative — tune for your hardware

=== ":lucide-bolt: Common Patterns"

    ```sql
    -- Indexing strategies
    CREATE INDEX idx_users_email ON users (email);                    -- Single column
    CREATE INDEX idx_orders_user_date ON orders (user_id, created_at);  -- Composite
    CREATE UNIQUE INDEX idx_unique_username ON users (username);        -- Unique constraint

    -- Full-text search
    ALTER TABLE articles ADD COLUMN search_vector tsvector
        GENERATED ALWAYS AS (to_tsvector('english', title || ' ' || body)) STORED;
    CREATE INDEX idx_articles_search ON articles USING GIN (search_vector);
    SELECT * FROM articles WHERE search_vector @@ to_tsquery('english', 'postgresql & performance');

    -- JSON operations
    SELECT data->>'name' AS name, data->>'email' AS email
    FROM users WHERE data @> '{"active": true}';

    -- Window functions
    SELECT name, department, salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_rank
    FROM employees;

    -- Common Table Expressions (CTEs)
    WITH popular_products AS (
        SELECT product_id, COUNT(*) as sales
        FROM orders GROUP BY product_id HAVING COUNT(*) > 100
    )
    SELECT p.name, pp.sales
    FROM products p JOIN popular_products pp ON p.id = pp.product_id;
    ```

    **Why this works:**

    - GIN indexes make full-text search viable without Elasticsearch
    - JSONB with GIN indexes replaces MongoDB for many use cases
    - CTEs improve query readability and enable recursion
    - Window functions replace complex self-joins

=== ":lucide-fire: Pro Tips & Gotchas"

    **Tips:**

    - Use `EXPLAIN (ANALYZE, BUFFERS)` for deeper insight into query performance
    - `VACUUM` is automatic since Postgres 9.6, but monitor `autovacuum` with `pg_stat_user_tables`
    - Connection pooling is essential — use PgBouncer or built-in since Postgres 17
    - Extensions via `CREATE EXTENSION` — PostGIS, pgvector, pg_partman, citext
    - Use `pg_stat_statements` for query performance monitoring
    - Set `random_page_cost` to 1.1 for SSDs (default is 4 — optimized for spinning disks)

    **Gotchas:**

    - No `IF NOT EXISTS` for columns (must use PL/pgSQL or check information_schema)
    - `NULL != NULL` — use `IS DISTINCT FROM` for null-safe comparisons
    - MVCC means `UPDATE` = `DELETE + INSERT` — HOT updates help but table bloat is real
    - Default `max_connections = 100` — too low for application servers with connection pools
    - `ALTER TABLE ... ADD COLUMN` with DEFAULT rewrites the entire table (versions 11+ optimizes this)
    - Sequence gaps on rollback — don't rely on gapless IDs

---

## Architecture

**Process model:** Fork-per-connection (one backend process per client connection). Unlike MySQL's threading model, this means more memory per connection but better stability.

**Storage:** MVCC (Multi-Version Concurrency Control). Each transaction sees a snapshot of data. `VACUUM` reclaims space from dead tuples. `VACUUM FULL` rewrites tables (takes locks — avoid during business hours).

**Key directories:**

| Path | Purpose |
|------|---------|
| `/var/lib/postgresql/data/` | Data directory |
| `/etc/postgresql/*/main/postgresql.conf` | Main config |
| `/var/log/postgresql/` | Log files |

---

## Installation

```bash
# Ubuntu/Debian
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql

# macOS
brew install postgresql@17
brew services start postgresql@17

# Docker
docker run --name mypg -e POSTGRES_PASSWORD=secret -d postgres:17-alpine

# First setup
sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'pass';"
sudo -u postgres psql -c "CREATE DATABASE mydb OWNER myuser;"
```

---

## Reference

**Documentation:**

- :lucide-book: [Official Docs](https://www.postgresql.org/docs/)
- :lucide-book: [Postgres Weekly](https://postgresweekly.com/) — Newsletter
- :lucide-github: [PostgreSQL GitHub](https://github.com/postgres/postgres)

**Related:**

- :lucide-fire: **DBCli (pgcli)** — Modern CLI with autocompletion
- :lucide-wrench: **SQLAlchemy** — Python ORM with Postgres dialect

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-database: **Industry Standard** - The default relational database for serious projects. ACID compliance, extensibility, and reliability beat MySQL for most use cases. Not the fastest for simple reads but the most trustworthy.

**Tags:** postgresql, database, sql, relational
