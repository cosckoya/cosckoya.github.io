---
title: oracledb-cli
description: Interactive Oracle Database CLI built on python-oracledb thin mode — no Oracle Client libraries required.
---

# :fontawesome-solid-terminal: oracledb-cli

Oracle abandoned the interactive CLI space when okcli went unmaintained in 2019. This fills that gap: a custom interactive client built on `python-oracledb` (Oracle's official Python driver) and `prompt_toolkit`. Thin mode by default means no Oracle Instant Client, no `LD_LIBRARY_PATH` nonsense, no `/etc/oracle` config files. Just Python and a connection string.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation
    pip install python-oracledb prompt_toolkit pygments click tabulate

    # Basic usage — prompts for password if not set
    python oracledb-cli.py -u system -h localhost -d XE
    python oracledb-cli.py -u app_user -h db.internal -d PRODDB --port 1521

    # Oracle Cloud / Autonomous Database (wallet-based)
    python oracledb-cli.py \
      -u admin \
      -h adb.eu-frankfurt-1.oraclecloud.com \
      -d mydb_high \
      --wallet-file /path/to/wallet.zip \
      --wallet-password "wallet_pwd"

    # Thick mode (only if you need Oracle 11g or legacy features)
    python oracledb-cli.py -u user -h host -d XE --thick-mode

    # Inside the session — special commands
    \help                       # Show all special commands
    \status                     # Show DB version, user, current time
    \tables                     # List all tables (user_tables)
    \views                      # List all views (user_views)
    \desc employees             # Describe table schema
    \d employees                # Same as \desc (PostgreSQL-style alias)
    \quit                       # Exit (also: \q, exit)

    # Output format switching (inside session)
    format: json                # Switch to JSON output
    format: csv                 # Switch to CSV output
    format: tsv                 # Switch to tab-separated
    format: table               # Back to default grid (default)

    # Then run any query
    SELECT * FROM employees WHERE department_id = 10;
    ```

    **Real talk:**

    - Thin mode is the default and works for Oracle 12.1+ — if you're on something older, you have bigger problems than a CLI
    - Password is prompted interactively — never pass it as a shell argument, it will end up in `~/.bash_history`
    - Query history is saved to `~/.oracledb_history` — persistent across sessions, searchable with Ctrl+R
    - `format: json` before a query is useful when you want to pipe results to `jq` or parse them in a script

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # --- Local development (Oracle XE or Docker) ---
    # Oracle XE free edition: docker run -d -p 1521:1521 gvenzl/oracle-xe
    python oracledb-cli.py -u system -h localhost -d XEPDB1

    # --- Oracle Cloud Autonomous Database (ADB) ---
    # Download wallet ZIP from OCI Console → ADB → DB Connection
    python oracledb-cli.py \
      -u ADMIN \
      -h your-adb-hostname.adb.eu-frankfurt-1.oraclecloud.com \
      -d mydb_tp \                        # service name from tnsnames.ora in wallet
      --wallet-file ~/wallets/wallet.zip \
      --wallet-password "$(cat ~/.wallet_pwd)"  # read from file, not inline

    # --- Environment variable pattern (safer for automation) ---
    export ORACLE_USER=app_user
    export ORACLE_PASSWORD="$(vault kv get -field=password secret/oracle)"
    export ORACLE_HOST=db.internal
    export ORACLE_DB=PRODDB

    python oracledb-cli.py \
      -u "$ORACLE_USER" \
      -p "$ORACLE_PASSWORD" \
      -h "$ORACLE_HOST" \
      -d "$ORACLE_DB"

    # --- Batch query execution (non-interactive) ---
    echo "SELECT COUNT(*) FROM orders WHERE status = 'PENDING';" | \
      python oracledb-cli.py -u user -h localhost -d XE

    # --- Output formats for integration ---
    # JSON → pipe to jq
    # (set format: json inside session, then query)

    # CSV → import into spreadsheet or pandas
    # format: csv
    # SELECT order_id, customer_id, total FROM orders WHERE rownum <= 1000;
    ```

    **Why this works:**

    - Thin mode connects directly over TCP — no shared libraries, works in Docker, Lambda, or any clean Python environment
    - Wallet authentication handles TLS mutual auth for Oracle Cloud without manual certificate management
    - Environment variables keep credentials out of process arguments (visible in `ps aux`)
    - Format switching is per-session, not per-query — set it once and all subsequent results use it

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    **Tips:**

    - Use `\status` first after connecting — it confirms DB version, current user, and server time, making it obvious if you're on the wrong database
    - `format: json` + `jq` is a solid combination for quick data inspection without writing a Python script
    - For Oracle Cloud ADB, the service name in `--database` must match one of the names in the wallet's `tnsnames.ora` (typically `<dbname>_high`, `<dbname>_medium`, `<dbname>_low`, `<dbname>_tp`)
    - `\desc <table>` saves the round-trip to documentation — column names, types, and nullable constraints in one command
    - Multi-line queries are supported — press Enter to continue typing, the query executes when it ends with `;`

    **Gotchas:**

    - Thick mode requires Oracle Instant Client installed and `LD_LIBRARY_PATH` (or `DYLD_LIBRARY_PATH` on macOS) pointing to it — if you need this, your deployment just got significantly more complex
    - `oracledb.makedsn()` with `service_name` is different from `sid` — Oracle 12c+ uses service names; using the wrong one returns `ORA-12514`
    - Wallet ZIP path must be the file itself, not the extracted directory — the driver handles extraction internally
    - `SELECT *` on large tables will fetch everything into memory — always add `WHERE rownum <= N` for exploration
    - DML (`INSERT`, `UPDATE`, `DELETE`) auto-commits on success — there is no explicit transaction management in this CLI, be careful on production

______________________________________________________________________

## :fontawesome-solid-box: Installation

```bash
# Minimal install
pip install python-oracledb prompt_toolkit pygments click tabulate

# Or with a requirements file
cat > requirements-oracledb-cli.txt <<EOF
python-oracledb>=3.4.0
prompt_toolkit>=3.0.0,<4.0.0
Pygments>=2.0
click>=8.0
tabulate>=0.9.0
EOF

pip install -r requirements-oracledb-cli.txt

# Verify driver version
python -c "import oracledb; print(oracledb.__version__)"
# Expected: 3.4.x or higher
```

!!! note "Thick mode dependencies"
    Thin mode (default) requires nothing beyond the pip packages above. Thick mode additionally requires Oracle Instant Client 19c, 21c, or 23c installed on the system. Download from Oracle's website and set `LD_LIBRARY_PATH=/opt/oracle/instantclient_23_x`.

______________________________________________________________________

## :fontawesome-solid-plug: Connection Reference

| Scenario | Flags Required |
|---|---|
| Local Oracle XE / Docker | `-u`, `-h localhost`, `-d XEPDB1` |
| On-premise Oracle | `-u`, `-h`, `--port`, `-d` |
| Oracle Cloud ADB | `-u`, `-h`, `-d <service>`, `--wallet-file`, `--wallet-password` |
| Thick mode (legacy) | All of the above + `--thick-mode` |

```bash
# Full flag reference
python oracledb-cli.py --help

# Options:
#  -u, --username TEXT           Database username
#  -p, --password TEXT           Database password (prompted if omitted)
#  -h, --host TEXT               Database host       [default: localhost]
#      --port INTEGER            Database port       [default: 1521]
#  -d, --database TEXT           Service name        [default: XE]
#      --wallet-file PATH        Wallet ZIP for Oracle Cloud
#      --wallet-password TEXT    Wallet password
#      --thick-mode              Use thick mode (requires Instant Client)
```

______________________________________________________________________

## :fontawesome-solid-book: Reference

**Documentation:**

- :fontawesome-solid-book: [python-oracledb Official Docs](https://python-oracledb.readthedocs.io/)
- :fontawesome-solid-shield: [Thin vs Thick Mode](https://python-oracledb.readthedocs.io/en/latest/user_guide/initialization.html)
- :fontawesome-solid-cloud: [Oracle ADB Wallet Setup](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connect-download-wallet.html)

**Related:**

- :fontawesome-solid-database: __DBCli (pgcli / mycli / litecli) — same concept, for PostgreSQL / MySQL / SQLite__
- :fontawesome-solid-code: __SQLAlchemy 2.0 — python-oracledb dialect for ORM-style programmatic access__
- :fontawesome-solid-terminal: __prompt_toolkit — the library powering the interactive session__

______________________________________________________________________

**Last Updated:** 2026-03-22
**Tags:** oracle, python-oracledb, cli, database, interactive, thin-mode, oracle-cloud
