---
title: Go
description: Compiled programming language by Google - fast, simple, concurrent, production-proven
tags:
  - go
  - golang
  - programming
  - compiled
---

# :lucide-code: Go

Compiled programming language created at Google. Fast compilation, fast execution, built-in concurrency. Simplicity by design — no generics drama (until 1.18), no inheritance, no exceptions. Dominant in cloud infrastructure: Docker, Kubernetes, Terraform, Prometheus, all written in Go. The language of the cloud.

!!! tip "2026 Update"
    Go 1.24 brings enhanced iterators, improved `unique` package, and better WASM support. Generics (added in 1.18) are now idiomatic. The standard library remains the gold standard — you rarely need third-party frameworks. `gofmt` is non-negotiable.

---

## Quick Hits

=== ":lucide-list-check: Essential Syntax"

    ```go
    package main

    import "fmt"

    // Constants and variables
    const Greeting = "Hello"
    var count int = 42                    // Explicit
    name := "Go"                          // Short declaration (type inference)
    nums := []int{1, 2, 3}               // Slice (dynamic array)

    // Function with multiple returns
    func divide(a, b int) (int, error) {
        if b == 0 {
            return 0, fmt.Errorf("division by zero")
        }
        return a / b, nil
    }

    // Struct with methods
    type User struct {
        Name  string
        Email string
    }

    func (u User) Greet() string {
        return fmt.Sprintf("Hi, I'm %s", u.Name)
    }

    // Interface (implicit satisfaction)
    type Greeter interface {
        Greet() string
    }

    func main() {
        u := User{Name: "Alice", Email: "alice@example.com"}
        fmt.Println(u.Greet())

        result, err := divide(10, 3)
        if err != nil {
            fmt.Println("Error:", err)
        } else {
            fmt.Println("Result:", result)
        }
    }
    ```

    **Real talk:**

    - No classes, no inheritance — composition over inheritance is enforced by design
    - Errors are values, not exceptions — handle them explicitly
    - The `go` keyword is all you need for concurrency
    - `gofmt` eliminates all formatting debates

=== ":lucide-bolt: Common Patterns"

    ```go
    // Goroutines and channels (concurrency)
    func worker(id int, jobs <-chan int, results chan<- int) {
        for j := range jobs {
            results <- j * 2
        }
    }

    // Error wrapping (Go 1.20+)
    if err := doSomething(); err != nil {
        return fmt.Errorf("setup failed: %w", err)  // %w wraps, not %s
    }

    // Context for cancellation and timeouts
    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()
    result, err := queryDatabase(ctx, "SELECT * FROM users")

    // Testing (built-in)
    func TestAdd(t *testing.T) {
        got := Add(2, 3)
        want := 5
        if got != want {
            t.Errorf("Add(2, 3) = %d; want %d", got, want)
        }
    }

    // Table-driven tests
    func TestDivide(t *testing.T) {
        tests := []struct {
            a, b, want int
            wantErr    bool
        }{
            {10, 2, 5, false},
            {10, 0, 0, true},
        }
        for _, tt := range tests {
            got, err := divide(tt.a, tt.b)
            if (err != nil) != tt.wantErr {
                t.Errorf("divide(%d, %d) error = %v", tt.a, tt.b, err)
            }
            if got != tt.want {
                t.Errorf("divide(%d, %d) = %d; want %d", tt.a, tt.b, got, tt.want)
            }
        }
    }
    ```

    **Why this works:**

    - Goroutines are lightweight (2KB stack) — run thousands without thread management
    - Channels communicate safely between goroutines ("Do not communicate by sharing memory; instead, share memory by communicating")
    - `context` package standardizes cancellation and deadlines across the ecosystem
    - Table-driven tests are the Go idiom — clear, comprehensive, maintainable

=== ":lucide-fire: Pro Tips & Gotchas"

    **Tips:**

    - Use `go mod tidy` regularly — keeps `go.mod` and `go.sum` clean
    - `go vet` catches subtle bugs — run it in CI
    - `go build -ldflags="-s -w"` reduces binary size by 30%
    - `sync.Pool` reduces allocation pressure in hot paths
    - Use `any` instead of `interface{}` (Go 1.18+)
    - `go install` for tools (`go install golang.org/x/tools/cmd/deadcode@latest`)
    - Profile with `pprof` before optimizing

    **Gotchas:**

    - No `go generate` tracking — generated files can become stale
    - `nil` in interface values is tricky — an interface with a nil pointer is NOT nil
    - Slice append may share backing array — copy before returning from functions
    - Defer is function-scoped, not block-scoped — can leak resources in loops
    - Map iteration order is intentionally randomized — don't depend on it
    - `time.After` in loops leaks until the duration expires

---

## Installation

```bash
# macOS
brew install go

# Ubuntu/Debian
sudo apt install golang-go

# From source (latest version)
wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc

# Verify
go version
# go version go1.24.0 linux/amd64

# First project
mkdir myproject && cd myproject
go mod init example.com/myproject
go get github.com/lib/pq
```

---

## Reference

**Documentation:**

- :lucide-book: [Official Docs](https://go.dev/doc/)
- :lucide-book: [Go by Example](https://gobyexample.com/) — Best learning resource
- :lucide-github: [Go GitHub](https://github.com/golang/go)

**Related:**

- :lucide-fire: **Docker** — Written in Go, great codebase to study
- :lucide-wrench: **Kubernetes** — Largest Go project in existence

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-rocket: **Cloud Native Standard** - The language that built the cloud. Simple syntax, fast compilation, built-in concurrency. Not the best for everything (data science, UI), but unmatched for infrastructure, CLIs, and network services. Go is the modern C.

**Tags:** go, golang, programming, compiled
