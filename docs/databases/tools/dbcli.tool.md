---
title: DBCli
description: Interactive SQL clients for MySQL, PostgreSQL, and SQLite — autocomplete, syntax highlighting, query history
---

# :fontawesome-solid-database: DBCli

Family of interactive SQL clients (mycli, pgcli, litecli) that add modern CLI conveniences to database shells. Autocomplete, syntax highlighting, execution hints, query history. Makes repeated database interactions less tedious. Drop-in replacements for `mysql`, `psql`, `sqlite3`.

!!! tip "2026 Update"
    All DBCli tools support vi/emacs keybindings, custom themes, and can output in multiple formats (csv, tsv, json). PostgreSQL support is mature and feature-complete. SQLite version still catching up but solid for local dev.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation (via pip or package manager)
    pip install mycli           # MySQL
    pip install pgcli           # PostgreSQL
    pip install litecli         # SQLite

    # Basic usage (mycli example)
    mycli -u root -p -h localhost mydb
    mycli -u user -p -h 192.168.1.100 production_db

    # PostgreSQL (pgcli)
    pgcli -U postgres -d mydb
    pgcli -U app_user -d app_db -h db.example.com

    # SQLite (litecli)
    litecli ~/mydata.db
    litecli :memory:            # In-memory database for testing

    # Inside the CLI — special commands
    \help                       # Show all special commands
    \status                     # Connection status
    \quit or \q                 # Exit
    \e                          # Open query in $EDITOR
    \watch <interval>           # Repeat query every N seconds
    \f <function_name>          # Show function definition
    \d <table>                  # Describe table schema

    # Saving and running queries
    \save_query <name>          # Save current query with name
    \load_query <name>          # Load saved query
    \run_query <name>           # Execute saved query
    ```

    **Real talk:**

    - Autocomplete learns your schema automatically — after a few queries, it suggests table/column names
    - Syntax highlighting makes typos obvious — catch errors before hitting enter
    - Query history is persistent — arrow keys scroll through old queries, searchable with Ctrl+R
    - Output is still just SQL results — no magic, just better UX

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # Connect with .pgpass or .my.cnf (password in config files)
    pgcli -U user -d mydb -h localhost
    # .pgpass prevents password prompt — format: hostname:port:database:user:password
    chmod 600 ~/.pgpass

    # Output formatting
    \pset format csv            # pgcli: output as CSV
    SELECT * FROM users;        # Saves to .csv for import into other tools

    # Watch queries for monitoring
    \watch 5                    # Re-run every 5 seconds (useful for monitoring)
    SELECT COUNT(*) FROM logs;

    # Multiple queries in batch
    echo "SELECT COUNT(*) FROM users; SELECT COUNT(*) FROM posts;" | pgcli -d mydb

    # Run SQL file
    \i /path/to/queries.sql     # Execute file

    # Tab-separated output (copy-paste friendly)
    \pset format tsv
    SELECT id, email, created_at FROM users;
    # Output is tab-separated, pastes cleanly into spreadsheets
    ```

    **Why this works:**

    - Password files remove the need to pass credentials on CLI (safer than environment variables sometimes)
    - Output formatting makes results actionable — CSV for analysis, TSV for copy-paste
    - `\watch` is invaluable for live monitoring without writing monitoring infrastructure
    - Batch mode still works — DBCli adds interactivity but doesn't force it

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    **Tips:**

    - Set your `EDITOR` env var to your preferred editor — `\e` will open that for query editing
    - Use vi keybindings if you're comfortable with them — add `editor_mode = vi` to config
    - Syntax highlighting catches errors early — a misplaced comma is obvious when color breaks
    - Query execution hints appear after you type — "You're querying 500k rows" warnings are helpful
    - Export results to json with `\pset format json` for integration with scripts

    **Gotchas:**

    - Autocomplete can lag on very large schemas — it's still loading column names in the background
    - `\watch` without a limit will re-run forever — press Ctrl+C to stop
    - Copy-paste of multi-line queries doesn't always format correctly — use `\e` or `\i` for complex scripts
    - Connection pooling doesn't work the same as in application connections — each DBCli session is a direct connection
    - Some DBCli tools are slower than native clients on large result sets — if you're streaming millions of rows, `psql` or `mysql` CLI might be faster

______________________________________________________________________

## Configuration

```yaml
# ~/.config/pgcli/config (~/.myclirc for mycli, ~/.liteclirc for litecli)
[main]
auto_escaped_table_names = True             # Quote table names that need escaping
editor_mode = vi                            # vi or emacs keybindings
multi_line = True                           # Allow multi-line queries
enable_pager = True                         # Paginate large results
pager = less -SRXF                          # Custom pager

[colors]
theme = native                              # Color theme (monokai, native, solarized, etc.)
```

______________________________________________________________________

## Reference

**Documentation:**

- :fontawesome-solid-book: [DBCli Home](https://www.dbcli.com/) — All three tools (pgcli, mycli, litecli)
- :fontawesome-brands-github: [pgcli on GitHub](https://github.com/dbcli/pgcli) — PostgreSQL client
- :fontawesome-brands-github: [mycli on GitHub](https://github.com/dbcli/mycli) — MySQL client
- :fontawesome-brands-github: [litecli on GitHub](https://github.com/dbcli/litecli) — SQLite client

**Related:**

- :fontawesome-solid-terminal: __DBeaver — GUI alternative if you prefer graphical UI__
- :fontawesome-solid-database: __ClickHouse CLI — specialized for OLAP queries__
- :fontawesome-solid-code: __SQLAlchemy — Python ORM for programmatic queries__

______________________________________________________________________

**Last Updated:** 2026-03-20
**Tags:** dbcli, pgcli, mycli, litecli, database, sql, cli
