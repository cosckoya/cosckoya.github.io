---
title: Python
description: General-purpose programming language - readable syntax, massive ecosystem, slow but productive
---

# :fontawesome-solid-code: Python

General-purpose programming language known for readability and simplicity. Dominant in data science, ML, automation, and web backends. Slow execution but fast development. "Batteries included" philosophy with comprehensive standard library. GIL (Global Interpreter Lock) is both a blessing and a curse.

!!! tip "2026 Update"
    Python 3.12+ brings significant performance improvements (20-30% faster). Type hints are mainstream (mypy integration everywhere). Ruff replaces Black/Flake8/isort (50x faster). uv is the new package installer (10-100x faster than pip). AsyncIO is production-ready. Python 2 is finally dead.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Syntax"

    ```python
    # Variables and types (dynamic typing)
    name = "Python"              # str
    version = 3.12               # int
    is_awesome = True            # bool
    items = [1, 2, 3]            # list (mutable)
    coords = (10, 20)            # tuple (immutable)
    unique = {1, 2, 3}           # set
    config = {"key": "value"}    # dict

    # String formatting (use f-strings)
    user = "Alice"
    age = 30
    message = f"{user} is {age} years old"  # Modern way
    # Avoid: message = user + " is " + str(age)  # Old way

    # Conditionals
    if age >= 18:
        print("Adult")
    elif age >= 13:
        print("Teen")
    else:
        print("Child")

    # Loops
    for item in items:
        print(item)

    for i, item in enumerate(items):  # With index
        print(f"{i}: {item}")

    # Comprehensions (Pythonic way)
    squares = [x**2 for x in range(10)]
    evens = [x for x in range(10) if x % 2 == 0]
    squared_dict = {x: x**2 for x in range(5)}

    # Functions
    def greet(name: str, age: int = 0) -> str:  # Type hints (recommended)
        """Greet user with name and optional age."""
        return f"Hello, {name}! Age: {age}"

    # Lambda (anonymous functions)
    double = lambda x: x * 2
    numbers = [1, 2, 3, 4]
    doubled = list(map(double, numbers))

    # Classes
    class Person:
        def __init__(self, name: str, age: int):
            self.name = name
            self.age = age

        def greet(self) -> str:
            return f"Hi, I'm {self.name}"

        @property  # Getter
        def is_adult(self) -> bool:
            return self.age >= 18

    # Context managers (automatic cleanup)
    with open("file.txt", "r") as f:
        content = f.read()  # File closed automatically

    # Exception handling
    try:
        result = 10 / 0
    except ZeroDivisionError as e:
        print(f"Error: {e}")
    finally:
        print("Always runs")
    ```

    **Real talk:**

    - Use f-strings for formatting, always
    - Type hints are optional but recommended (helps IDEs and mypy)
    - List comprehensions are idiomatic Python
    - `with` statements prevent resource leaks
    - PEP 8 style guide is law (use Ruff to enforce)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```python
    # Virtual environments (isolate project dependencies)
    # Use uv (modern, fast) or venv (standard library)
    uv venv                       # Create virtual env with uv
    source .venv/bin/activate     # Activate (Linux/macOS)
    .venv\Scripts\activate        # Activate (Windows)

    # Package management
    uv pip install requests       # Install package with uv
    uv pip install -r requirements.txt  # Install from file
    uv pip freeze > requirements.txt    # Save current packages

    # Or use pip (slower but standard)
    pip install requests
    pip install --upgrade package
    pip uninstall package

    # Web scraping pattern
    import requests
    from bs4 import BeautifulSoup

    response = requests.get("https://example.com")
    soup = BeautifulSoup(response.content, "html.parser")
    titles = [h2.text for h2 in soup.find_all("h2")]

    # REST API pattern (Flask)
    from flask import Flask, jsonify, request

    app = Flask(__name__)

    @app.route("/api/users", methods=["GET"])
    def get_users():
        users = [{"id": 1, "name": "Alice"}]
        return jsonify(users)

    @app.route("/api/users", methods=["POST"])
    def create_user():
        data = request.get_json()
        # Validate and save user
        return jsonify({"id": 2, "name": data["name"]}), 201

    if __name__ == "__main__":
        app.run(debug=True)

    # Async/await (modern Python)
    import asyncio
    import aiohttp

    async def fetch_url(url: str) -> str:
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                return await response.text()

    async def main():
        urls = ["https://example.com", "https://example.org"]
        tasks = [fetch_url(url) for url in urls]
        results = await asyncio.gather(*tasks)  # Concurrent execution
        return results

    # Run async code
    asyncio.run(main())

    # Dataclasses (modern data containers)
    from dataclasses import dataclass

    @dataclass
    class User:
        id: int
        name: str
        email: str
        active: bool = True  # Default value

    user = User(1, "Alice", "alice@example.com")
    print(user.name)  # Alice

    # File operations (Pathlib - modern way)
    from pathlib import Path

    file = Path("data/users.json")
    file.parent.mkdir(parents=True, exist_ok=True)  # Create dirs
    file.write_text('{"users": []}')                # Write file
    content = file.read_text()                      # Read file

    # Iterate files
    for py_file in Path(".").rglob("*.py"):
        print(py_file)

    # Logging (better than print)
    import logging

    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    logger = logging.getLogger(__name__)

    logger.info("Application started")
    logger.warning("Deprecated feature used")
    logger.error("Failed to connect to database")

    # Testing with pytest
    # test_calculator.py
    def add(a: int, b: int) -> int:
        return a + b

    def test_add():
        assert add(2, 3) == 5
        assert add(-1, 1) == 0
        assert add(0, 0) == 0

    # Run tests: pytest test_calculator.py
    ```

    **Why this works:**

    - Virtual environments prevent dependency conflicts
    - Type hints improve code quality (catch bugs early)
    - AsyncIO enables concurrent operations (faster I/O)
    - Dataclasses reduce boilerplate
    - Pathlib is more readable than os.path
    - Logging beats print for production code

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Use uv for dependencies** - 10-100x faster than pip
        - **Type hints everywhere** - Run mypy in CI/CD
        - **Ruff for linting** - Replaces Black, Flake8, isort (50x faster)
        - **pytest for testing** - Simpler than unittest, better fixtures
        - **Poetry/PDM** - Better dependency management than pip (lock files)
        - **Pre-commit hooks** - Auto-format and lint before commits
        - **Virtual environments** - Always, even for scripts
        - **F-strings** - Fastest and most readable string formatting

    !!! warning "Performance"
        - **GIL limitation** - Multi-threading doesn't use multiple cores (use multiprocessing)
        - **Use NumPy** - C extensions for array operations (100x faster)
        - **Avoid loops** - List comprehensions and built-ins are faster
        - **Profile first** - Use cProfile before optimizing
        - **PyPy** - JIT compiler for CPU-bound code (5-10x speedup)
        - **Cython** - Compile to C for critical sections
        - **async for I/O** - Use asyncio for network/disk operations

    !!! tip "Modern Python Tools"
        - **uv** - Fast package installer (Rust-based, replaces pip)
        - **Ruff** - All-in-one linter/formatter (replaces 5+ tools)
        - **mypy** - Static type checker (catch bugs before runtime)
        - **pytest** - Modern testing framework
        - **Poetry** - Dependency management with lock files
        - **PyRight** - Microsoft's type checker (faster than mypy)
        - **Rich** - Beautiful terminal output
        - **Typer** - CLI framework (type hints → CLI args)

    !!! danger "Common Gotchas"
        - **Mutable defaults** - `def func(items=[])` is dangerous (shared state)
        - **Late binding closures** - Loops with lambdas capture last value
        - **GIL** - Threading doesn't parallelize CPU work
        - **pip in system Python** - Always use virtual environments
        - **Import *** - Never do `from module import *` (namespace pollution)
        - **== vs is** - Use `is` for None/True/False, `==` for values
        - **Encoding** - Always specify `encoding="utf-8"` when opening files

    !!! info "Package Ecosystem"
        - **Web** - FastAPI (modern), Django (batteries included), Flask (minimal)
        - **Data Science** - pandas, NumPy, scikit-learn, Jupyter
        - **ML/AI** - PyTorch, TensorFlow, Hugging Face Transformers
        - **Testing** - pytest, hypothesis (property testing), tox (multi-env)
        - **Async** - asyncio, aiohttp, httpx, uvloop (faster event loop)
        - **CLI** - Typer, Click, argparse (standard library)

______________________________________________________________________

## :fontawesome-solid-box: Package Management

### Modern Approach (uv - Recommended)

```bash
# Install uv (Rust-based, extremely fast)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create project with virtual environment
uv venv
source .venv/bin/activate  # Linux/macOS
.venv\Scripts\activate     # Windows

# Install packages
uv pip install fastapi uvicorn[standard]
uv pip install pytest pytest-cov --dev  # Dev dependencies

# Sync from requirements.txt
uv pip sync requirements.txt

# Generate requirements
uv pip freeze > requirements.txt
```

### Traditional Approach (pip + venv)

```bash
# Create virtual environment
python -m venv .venv
source .venv/bin/activate

# Install packages
pip install requests
pip install -r requirements.txt
pip install --upgrade package

# Freeze dependencies
pip freeze > requirements.txt
```

### Enterprise Approach (Poetry)

```bash
# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Initialize project
poetry init
poetry new my-project  # Creates project structure

# Add dependencies
poetry add fastapi
poetry add --group dev pytest

# Install all dependencies
poetry install

# Run commands in virtual env
poetry run python app.py
poetry run pytest
```

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Free Resources

- **[Official Python Tutorial](https://docs.python.org/3/tutorial/)** - Start here if new to Python
- **[Real Python](https://realpython.com/)** - High-quality tutorials and articles
- **[Python Package Index (PyPI)](https://pypi.org/)** - Find packages
- **[PEP 8 Style Guide](https://peps.python.org/pep-0008/)** - Official style guide
- **[Full Stack Python](https://www.fullstackpython.com/)** - Web development focus

### :fontawesome-solid-code: Practice Projects

!!! example "Beginner"
    - **CLI tool** - Todo list, file organizer, password generator
    - **Web scraper** - Scrape news headlines, product prices
    - **API client** - Weather API, GitHub API wrapper
    - **Automation** - Rename files, backup scripts, report generation

!!! example "Intermediate"
    - **REST API** - FastAPI with PostgreSQL and JWT auth
    - **Web app** - Flask/Django blog with user authentication
    - **Data analysis** - pandas for CSV analysis, matplotlib visualization
    - **Async web scraper** - Concurrent scraping with aiohttp

!!! example "Advanced"
    - **Microservices** - FastAPI services with RabbitMQ/Redis
    - **ML pipeline** - Training, serving, monitoring with MLflow
    - **Package** - Create and publish to PyPI
    - **CLI framework** - Typer-based tool with plugins

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [Python Documentation](https://docs.python.org/)

    [Python Standard Library](https://docs.python.org/3/library/)

    [Python Package Index](https://pypi.org/)

    [PEP Index](https://peps.python.org/)

- :fontawesome-solid-wrench: __Essential Tools__

    ______________________________________________________________________

    [uv (package installer)](https://github.com/astral-sh/uv)

    [Ruff (linter/formatter)](https://github.com/astral-sh/ruff)

    [mypy (type checker)](https://mypy-lang.org/)

    [Poetry (dependency manager)](https://python-poetry.org/)

    [pytest (testing)](https://pytest.org/)

- :fontawesome-solid-code: __Popular Frameworks__

    ______________________________________________________________________

    [FastAPI](https://fastapi.tiangolo.com/)

    [Django](https://www.djangoproject.com/)

    [Flask](https://flask.palletsprojects.com/)

    [pandas](https://pandas.pydata.org/)

    [PyTorch](https://pytorch.org/)

- :fontawesome-solid-users: __Community__

    ______________________________________________________________________

    [r/python](https://reddit.com/r/python)

    [Python Discord](https://discord.gg/python)

    [Stack Overflow [python]](https://stackoverflow.com/questions/tagged/python)

    [PyCon](https://pycon.org/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-star: **Mainstream** - Python is the default choice for data science, ML, automation, and rapid prototyping. Slow execution but fast development. Modern tooling (uv, Ruff) makes it competitive. If you're doing AI/ML, you're learning Python.
**Tags:** python, programming, scripting, data-science
