#!/usr/bin/env python3
"""
OracleDB CLI - Interactive Oracle Database Client
Thin mode by default (no Oracle client library required).

Usage:
    oracledb-cli [options]

Examples:
    oracledb-cli -u system -p password -h localhost -p 1521 -d FREEPDB1
    oracledb-cli --wallet-file /path/to/wallet.zip --wallet-password pwd
"""

import sys
import os
import asyncio
import json
from typing import Optional, List, Tuple
from pathlib import Path

import oracledb
from prompt_toolkit import PromptSession
from prompt_toolkit.history import FileHistory
from prompt_toolkit.lexers import PygmentsLexer
from prompt_toolkit.completer import WordCompleter
from pygments.lexers.sql import SqlLexer
import click
from tabulate import tabulate


class OracleDBCLI:
    """Interactive Oracle Database CLI client."""

    def __init__(
        self,
        username: str,
        password: str,
        host: str = "localhost",
        port: int = 1521,
        database: str = None,
        wallet_file: str = None,
        wallet_password: str = None,
        thick_mode: bool = False,
    ):
        """Initialize connection parameters."""
        self.username = username
        self.password = password
        self.host = host
        self.port = port
        self.database = database or "XE"
        self.wallet_file = wallet_file
        self.wallet_password = wallet_password
        self.thick_mode = thick_mode
        self.connection = None
        self.cursor = None
        self.history_file = Path.home() / ".oracledb_history"
        self.history_file.touch(exist_ok=True)

    def connect(self) -> bool:
        """Establish connection to Oracle Database."""
        try:
            # Enable thick mode if requested
            if self.thick_mode:
                oracledb.init_oracle_client()

            # Wallet-based connection (Oracle Cloud, Autonomous DB)
            if self.wallet_file:
                self.connection = oracledb.connect(
                    dsn=oracledb.makedsn(
                        self.host, self.port, service_name=self.database
                    ),
                    user=self.username,
                    password=self.password,
                    wallet_location=self.wallet_file,
                    wallet_password=self.wallet_password,
                    config_dir=str(Path(self.wallet_file).parent),
                )
            # Standard connection (thin mode default)
            else:
                dsn = oracledb.makedsn(
                    self.host, self.port, service_name=self.database
                )
                self.connection = oracledb.connect(
                    dsn=dsn,
                    user=self.username,
                    password=self.password,
                    mode=oracledb.AUTH_MODE_DEFAULT if not self.thick_mode else None,
                )

            self.cursor = self.connection.cursor()

            # Get connection info
            version = self.connection.version
            click.echo(
                click.style(
                    f"✓ Connected to Oracle Database {version}",
                    fg="green",
                )
            )
            return True

        except oracledb.DatabaseError as e:
            click.echo(click.style(f"✗ Connection failed: {e}", fg="red"), err=True)
            return False
        except Exception as e:
            click.echo(click.style(f"✗ Error: {e}", fg="red"), err=True)
            return False

    def execute_query(self, query: str) -> Optional[List[Tuple]]:
        """Execute SQL query and return results."""
        try:
            # Strip whitespace and check for empty queries
            query = query.strip()
            if not query:
                return None

            # Special commands
            if query.lower() == "\\help":
                self._show_help()
                return None
            elif query.lower() == "\\status":
                self._show_status()
                return None
            elif query.lower() == "\\tables":
                query = (
                    "SELECT table_name FROM user_tables ORDER BY table_name"
                )
            elif query.lower() == "\\views":
                query = (
                    "SELECT view_name FROM user_views ORDER BY view_name"
                )
            elif query.lower().startswith("\\desc "):
                table = query[6:].strip().upper()
                query = f"DESC {table}"
            elif query.lower().startswith("\\d "):
                # PostgreSQL-style describe
                table = query[3:].strip().upper()
                query = f"DESC {table}"

            # Execute query
            self.cursor.execute(query)

            # Check if query returns results
            if self.cursor.description:
                # Fetch results
                rows = self.cursor.fetchall()
                return rows
            else:
                # DML/DDL operations
                self.connection.commit()
                click.echo(
                    click.style(
                        f"✓ {self.cursor.rowcount} rows affected.",
                        fg="green",
                    )
                )
                return None

        except oracledb.DatabaseError as e:
            click.echo(click.style(f"✗ Database error: {e}", fg="red"), err=True)
            return None
        except Exception as e:
            click.echo(click.style(f"✗ Error: {e}", fg="red"), err=True)
            return None

    def format_results(self, rows: List[Tuple], format: str = "table") -> str:
        """Format query results."""
        if not rows:
            return ""

        # Get column names
        columns = [desc[0] for desc in self.cursor.description]

        if format == "json":
            result = []
            for row in rows:
                result.append(dict(zip(columns, row)))
            return json.dumps(result, indent=2, default=str)
        elif format == "csv":
            lines = [",".join(str(c) for c in columns)]
            for row in rows:
                lines.append(",".join(str(v) or "" for v in row))
            return "\n".join(lines)
        elif format == "tsv":
            lines = ["\t".join(str(c) for c in columns)]
            for row in rows:
                lines.append("\t".join(str(v) or "" for v in row))
            return "\n".join(lines)
        else:  # table (default)
            return tabulate(rows, headers=columns, tablefmt="grid")

    def _show_help(self) -> None:
        """Show help for special commands."""
        help_text = """
Special Commands:
  \\help           Show this help
  \\status         Show connection status
  \\tables         List all tables
  \\views          List all views
  \\desc <table>   Describe table schema (also: \\d <table>)
  \\quit           Exit the CLI

Output Formats (use before query):
  Format: json    Output as JSON
  Format: csv     Output as CSV
  Format: tsv     Output as tab-separated values
  Format: table   Output as table (default)

Examples:
  SELECT * FROM user_tables;
  SELECT COUNT(*) FROM employees;
  \\tables
  \\desc employees
"""
        click.echo(help_text)

    def _show_status(self) -> None:
        """Show connection status."""
        try:
            self.cursor.execute("SELECT database, user, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS current_time FROM dual")
            row = self.cursor.fetchone()
            if row:
                db, user, timestamp = row
                click.echo(f"Database: {db}")
                click.echo(f"User: {user}")
                click.echo(f"Current Time: {timestamp}")
                click.echo(f"Connection Mode: {'Thick' if self.thick_mode else 'Thin'}")
        except Exception as e:
            click.echo(click.style(f"Error: {e}", fg="red"), err=True)

    def run(self) -> None:
        """Main interactive loop."""
        if not self.connect():
            sys.exit(1)

        session = PromptSession(
            lexer=PygmentsLexer(SqlLexer),
            history=FileHistory(str(self.history_file)),
        )

        click.echo(
            click.style(
                "Type \\help for special commands, \\quit to exit",
                fg="blue",
            )
        )

        output_format = "table"

        while True:
            try:
                # Prompt
                query = session.prompt("oracle> ", multiline=True)

                # Check for output format change
                if query.lower().startswith("format:"):
                    output_format = query.split(":", 1)[1].strip().lower()
                    if output_format not in ["table", "json", "csv", "tsv"]:
                        click.echo(
                            click.style(
                                f"Unknown format: {output_format}. Use: table, json, csv, tsv",
                                fg="red",
                            )
                        )
                        output_format = "table"
                    else:
                        click.echo(
                            click.style(
                                f"Output format set to: {output_format}",
                                fg="green",
                            )
                        )
                    continue

                # Check for quit
                if query.lower() in ["\\quit", "\\q", "exit"]:
                    click.echo("Goodbye!")
                    break

                # Execute query
                results = self.execute_query(query)
                if results:
                    formatted = self.format_results(results, output_format)
                    click.echo(formatted)

            except KeyboardInterrupt:
                click.echo("\nInterrupted.")
                continue
            except EOFError:
                click.echo("\nGoodbye!")
                break
            except Exception as e:
                click.echo(click.style(f"Error: {e}", fg="red"), err=True)

    def close(self) -> None:
        """Close database connection."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()


@click.command()
@click.option(
    "-u",
    "--username",
    prompt="Oracle username",
    help="Database username",
)
@click.option(
    "-p",
    "--password",
    prompt=True,
    hide_input=True,
    help="Database password",
)
@click.option(
    "-h",
    "--host",
    default="localhost",
    help="Database host",
)
@click.option(
    "--port",
    default=1521,
    type=int,
    help="Database port",
)
@click.option(
    "-d",
    "--database",
    default="XE",
    help="Database name / service name",
)
@click.option(
    "--wallet-file",
    type=click.Path(exists=True),
    help="Path to Oracle wallet ZIP file (for cloud)",
)
@click.option(
    "--wallet-password",
    help="Wallet password (for cloud)",
)
@click.option(
    "--thick-mode",
    is_flag=True,
    help="Use thick mode (requires Oracle Instant Client)",
)
def main(
    username: str,
    password: str,
    host: str,
    port: int,
    database: str,
    wallet_file: str,
    wallet_password: str,
    thick_mode: bool,
) -> None:
    """Interactive Oracle Database CLI client."""
    cli = OracleDBCLI(
        username=username,
        password=password,
        host=host,
        port=port,
        database=database,
        wallet_file=wallet_file,
        wallet_password=wallet_password,
        thick_mode=thick_mode,
    )

    try:
        cli.run()
    finally:
        cli.close()


if __name__ == "__main__":
    main()
