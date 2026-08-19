---
title: Python API Development
description: Building REST APIs with Python — FastAPI, Pydantic, OpenAPI, and testing the stack that doesn't make you hate your life
---

# :simple-fastapi: Python API Development

The modern Python API stack is FastAPI + Pydantic + pytest/httpx, and it's the closest thing to batteries-included you'll get. Type hints drive validation, serialization, and docs generation for free. No more hand-writing OpenAPI schemas — you'll get them whether you want them or not.

!!! tip "2026 Update"
    FastAPI is firmly the default for new Python APIs. Django REST Framework still owns legacy/monolith territory, but greenfield projects start with FastAPI.

---

## Quick Hits

=== ":lucide-list-check: Essential Setup"

    ```bash
    # FastAPI + Uvicorn + testing
    make deps  # or:
    uv pip install "fastapi>=0.115" "uvicorn[standard]" pytest httpx

    # Run the dev server with auto-reload
    uv run uvicorn app.main:app --reload
    ```

    ```python
    # app/main.py — the minimal viable API
    from fastapi import FastAPI

    app = FastAPI(title="My API")

    @app.get("/health")
    def health():
        return {"status": "ok"}
    ```

    **Real talk:**
    - Use `--reload` only in dev; never in production
    - `uvicorn app.main:app` — module:attribute path, no extensions
    - Interactive docs at `/docs`, ReDoc at `/redoc`, spec at `/openapi.json`

=== ":lucide-bolt: Common Patterns"

    ```python
    # Pydantic v2 models — validation + docs in one
    from pydantic import BaseModel, Field

    class ItemCreate(BaseModel):
        name: str = Field(min_length=1, max_length=100)
        price: float = Field(gt=0)
        tags: list[str] = []

    @app.post("/items", response_model=ItemCreate, status_code=201)
    def create_item(item: ItemCreate):
        return item  # FastAPI validates request body into the model
    ```

    **Why this works:**
    - Pydantic v2 is Rust-backed — 5-50x faster than v1 validation
    - `response_model` filters what the client sees (hide `password`, etc.)
    - Type hints give you request validation, OpenAPI schema, and docs for free

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**
    - Test with `httpx` + FastAPI's `TestClient` — in-process, no server needed
    - Use dependency injection for DB sessions — FastAPI resolves them per-request
    - Put routers in `app/routers/` and include them with `app.include_router()`

    **Gotchas:**
    - Async + sync DB drivers don't mix: pick one and stay consistent
    - `list[str]` works in Pydantic v2 (use `List[str]` only if stuck on v1)
    - FastAPI's `TestClient` uses `httpx` under the hood — don't double-import

---

## Reference

**Documentation:**

- :lucide-book: [FastAPI Official Docs](https://fastapi.tiangolo.com/)
- :lucide-book: [Pydantic Docs](https://docs.pydantic.dev/)
- :simple-github: [FastAPI GitHub](https://github.com/tiangolo/fastapi)
- :lucide-book: [OpenAPI Specification](https://spec.openapis.org/oas/latest.html)

**Related:**

- :lucide-shield-check: __Spectral__ — lint your OpenAPI specs
- :material-microsoft-azure-devops: __Azure DevOps__ — CI/CD for your API

---

**Last Updated:** 2026-08-20 | **Vibe Check:** :simple-fastapi: **Industry Standard** - FastAPI is the default choice for new Python APIs in 2026.

**Tags:** python, api, fastapi