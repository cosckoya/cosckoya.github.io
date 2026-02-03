---
title: Go
description: Systems programming language - fast compilation, built-in concurrency, simple syntax, strong standard library
---

# :octicons-code-16: Go

Statically typed, compiled language designed at Google. Fast compilation, garbage collection, built-in concurrency (goroutines). Opinionated (one way to format, error handling). Excellent for backend services, CLI tools, cloud infrastructure. Cross-compilation built-in. "Less is more" philosophy - deliberately simple.

!!! tip "2026 Update"
    Go 1.23+ brings iterators and improved generics. Range-over-func pattern now standard. Profile-guided optimization (PGO) production-ready (10-15% faster). Built-in fuzzing matured. Context package everywhere. Cloud-native tooling (Kubernetes, Docker, Terraform all written in Go). WebAssembly support improved.

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Syntax"

    ```go
    package main

    import (
        "fmt"
        "time"
    )

    // Variables (type after name)
    var name string = "Go"          // Explicit type
    var version = 1.23              // Type inference
    const maxConnections = 100      // Constant  // (1)!

    // Short declaration (inside functions only)
    func main() {
        message := "Hello, World"   // := declares and assigns
        count := 42

        // Multiple assignment
        x, y := 10, 20
        a, b, c := 1, "two", 3.0    // Different types
    }

    // Functions (return type after params)
    func add(x int, y int) int {
        return x + y
    }

    // Multiple return values (common for error handling)
    func divide(a, b float64) (float64, error) {
        if b == 0 {
            return 0, fmt.Errorf("division by zero")
        }
        return a / b, nil
    }  // (2)!

    // Named return values
    func split(sum int) (x, y int) {
        x = sum * 4 / 9
        y = sum - x
        return  // Naked return (uses named values)
    }

    // Structs (data structures)
    type User struct {
        ID    int
        Name  string
        Email string
        Age   int
    }

    func (u User) Greet() string {
        return fmt.Sprintf("Hello, %s", u.Name)
    }  // (3)!

    // Pointer receivers (modify struct)
    func (u *User) Birthday() {
        u.Age++
    }

    // Interfaces (behavior contracts)
    type Greeter interface {
        Greet() string
    }  // (4)!

    // Arrays and slices
    var arr [5]int              // Array (fixed size)
    slice := []int{1, 2, 3}     // Slice (dynamic)
    slice = append(slice, 4)    // Add to slice

    // Maps (hash tables)
    ages := make(map[string]int)
    ages["Alice"] = 30
    ages["Bob"] = 25

    // Or literal syntax
    scores := map[string]int{
        "Alice": 95,
        "Bob":   87,
    }

    // Control flow
    if x > 10 {
        fmt.Println("x is large")
    } else if x > 5 {
        fmt.Println("x is medium")
    } else {
        fmt.Println("x is small")
    }

    // If with initialization
    if v := compute(); v < 10 {
        fmt.Println(v)
    }  // (5)!

    // For loop (only loop keyword in Go)
    for i := 0; i < 10; i++ {
        fmt.Println(i)
    }

    // While-style loop
    for count < 100 {
        count++
    }

    // Infinite loop
    for {
        // Break condition
        if done {
            break
        }
    }

    // Range (iterate over slice, map, channel)
    for index, value := range slice {
        fmt.Printf("%d: %d\n", index, value)
    }

    for key, value := range scores {
        fmt.Printf("%s: %d\n", key, value)
    }

    // Switch (no fallthrough by default)
    switch day {
    case "Monday":
        fmt.Println("Start of week")
    case "Friday":
        fmt.Println("TGIF")
    default:
        fmt.Println("Regular day")
    }  // (6)!

    // Error handling (explicit, no exceptions)
    result, err := divide(10, 2)
    if err != nil {
        log.Fatal(err)  // Handle error
    }
    fmt.Println(result)  // Use result
    ```

    1. Constants evaluated at compile time (better performance)
    2. Multiple returns enable idiomatic error handling
    3. Methods with value receivers don't modify original struct
    4. Interfaces are satisfied implicitly (no "implements" keyword)
    5. Initialization in if statement scopes variable to if block
    6. No break needed (explicit fallthrough required for cascade)

    **Real talk:**

    - `:=` only works inside functions (use `var` at package level)
    - Always handle errors (ignoring with `_` is code smell)
    - Pointer receivers for methods that modify struct
    - Slices are references (modifying affects original)
    - Maps are not goroutine-safe (use sync.Map or mutex)
    - Capital letter = exported (public), lowercase = unexported (private)

=== ":octicons-zap-16: Common Patterns"

    ```go
    // HTTP server (standard library)
    package main

    import (
        "encoding/json"
        "log"
        "net/http"
    )

    type User struct {
        ID   int    `json:"id"`
        Name string `json:"name"`
    }  // (1)!

    func getUsers(w http.ResponseWriter, r *http.Request) {
        users := []User{
            {ID: 1, Name: "Alice"},
            {ID: 2, Name: "Bob"},
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(users)
    }  // (2)!

    func main() {
        http.HandleFunc("/api/users", getUsers)
        log.Println("Server running on :8080")
        log.Fatal(http.ListenAndServe(":8080", nil))
    }

    // Goroutines (concurrency)
    func fetchURL(url string) {
        resp, err := http.Get(url)
        if err != nil {
            log.Printf("Error fetching %s: %v", url, err)
            return
        }
        defer resp.Body.Close()
        fmt.Printf("Fetched %s: %s\n", url, resp.Status)
    }

    func main() {
        urls := []string{
            "https://example.com",
            "https://example.org",
            "https://example.net",
        }

        for _, url := range urls {
            go fetchURL(url)  // Launch goroutine
        }

        time.Sleep(5 * time.Second)  // Wait (better: use WaitGroup)
    }  // (3)!

    // Channels (goroutine communication)
    func worker(id int, jobs <-chan int, results chan<- int) {
        for job := range jobs {
            fmt.Printf("Worker %d processing job %d\n", id, job)
            time.Sleep(time.Second)
            results <- job * 2  // Send result
        }
    }  // (4)!

    func main() {
        jobs := make(chan int, 100)
        results := make(chan int, 100)

        // Start workers
        for w := 1; w <= 3; w++ {
            go worker(w, jobs, results)
        }

        // Send jobs
        for j := 1; j <= 5; j++ {
            jobs <- j
        }
        close(jobs)

        // Collect results
        for a := 1; a <= 5; a++ {
            <-results
        }
    }

    // WaitGroup (better synchronization)
    import "sync"

    func process(id int, wg *sync.WaitGroup) {
        defer wg.Done()  // Decrement counter when done
        fmt.Printf("Processing %d\n", id)
        time.Sleep(time.Second)
    }

    func main() {
        var wg sync.WaitGroup

        for i := 1; i <= 5; i++ {
            wg.Add(1)  // Increment counter
            go process(i, &wg)
        }

        wg.Wait()  // Block until counter is zero
    }  // (5)!

    // Database operations (PostgreSQL)
    import (
        "database/sql"
        _ "github.com/lib/pq"
    )

    func main() {
        db, err := sql.Open("postgres",
            "postgres://user:pass@localhost/dbname?sslmode=disable")
        if err != nil {
            log.Fatal(err)
        }
        defer db.Close()

        // Query
        rows, err := db.Query("SELECT id, name FROM users WHERE age > $1", 18)
        if err != nil {
            log.Fatal(err)
        }
        defer rows.Close()

        for rows.Next() {
            var id int
            var name string
            if err := rows.Scan(&id, &name); err != nil {
                log.Fatal(err)
            }
            fmt.Printf("ID: %d, Name: %s\n", id, name)
        }
    }  // (6)!

    // Context (cancellation, timeouts)
    import "context"

    func fetchWithTimeout(ctx context.Context, url string) error {
        req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
        if err != nil {
            return err
        }

        client := &http.Client{}
        resp, err := client.Do(req)
        if err != nil {
            return err
        }
        defer resp.Body.Close()

        return nil
    }

    func main() {
        ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
        defer cancel()

        if err := fetchWithTimeout(ctx, "https://example.com"); err != nil {
            log.Fatal(err)
        }
    }  // (7)!

    // Testing (built-in)
    // math.go
    func Add(a, b int) int {
        return a + b
    }

    // math_test.go
    import "testing"

    func TestAdd(t *testing.T) {
        result := Add(2, 3)
        if result != 5 {
            t.Errorf("Add(2, 3) = %d; want 5", result)
        }
    }

    // Table-driven tests (idiomatic)
    func TestAddTable(t *testing.T) {
        tests := []struct {
            name string
            a, b int
            want int
        }{
            {"positive", 2, 3, 5},
            {"negative", -1, 1, 0},
            {"zero", 0, 0, 0},
        }

        for _, tt := range tests {
            t.Run(tt.name, func(t *testing.T) {
                got := Add(tt.a, tt.b)
                if got != tt.want {
                    t.Errorf("got %d, want %d", got, tt.want)
                }
            })
        }
    }  // (8)!

    // JSON handling
    type Config struct {
        Host string `json:"host"`
        Port int    `json:"port"`
    }

    // Marshal (struct to JSON)
    config := Config{Host: "localhost", Port: 8080}
    jsonData, err := json.Marshal(config)
    // {"host":"localhost","port":8080}

    // Unmarshal (JSON to struct)
    var c Config
    err = json.Unmarshal(jsonData, &c)
    ```

    1. Struct tags define JSON field names (serialization)
    2. Standard library http package is production-ready
    3. Goroutines are lightweight (millions possible)
    4. Channels are typed, directional (<-chan recv, chan<- send)
    5. WaitGroup prevents premature exit (better than sleep)
    6. Parameterized queries prevent SQL injection ($1, $2, etc.)
    7. Context propagates cancellation across API boundaries
    8. Table-driven tests reduce duplication (idiomatic Go)

    **Why this works:**

    - Goroutines enable massive concurrency (cheap threads)
    - Channels provide safe communication (avoid shared memory)
    - Standard library is comprehensive (no framework needed)
    - Explicit error handling prevents surprises
    - Context enables graceful cancellation
    - Testing built into toolchain (no external dependency)

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **gofmt always** - Format code (no debates, use `gofmt -w .`)
        - **Handle errors** - Never ignore errors (use `if err != nil`)
        - **Defer cleanup** - Use `defer` for Close(), Unlock(), etc.
        - **Table-driven tests** - Reduce test duplication
        - **Accept interfaces, return structs** - Flexible APIs
        - **Context everywhere** - Pass context.Context as first param
        - **Go modules** - Use `go mod` for dependencies (not GOPATH)
        - **Struct tags** - Define JSON/DB field mappings

    !!! warning "Performance"
        - **Pointer vs value** - Large structs use pointers (avoid copies)
        - **Slice capacity** - Preallocate with `make([]T, 0, capacity)`
        - **String concatenation** - Use `strings.Builder` for loops
        - **Map initialization** - Preallocate size if known
        - **Goroutine leaks** - Always ensure goroutines terminate
        - **Mutex contention** - Minimize critical sections
        - **PGO** - Profile-guided optimization (10-15% faster)

    !!! tip "Modern Go Tools"
        - **go mod** - Dependency management (replaces GOPATH/vendor)
        - **go test** - Built-in testing (`-race` flag for race detection)
        - **go fmt** - Code formatting (enforced by community)
        - **go vet** - Static analysis (catches common mistakes)
        - **golangci-lint** - Meta-linter (runs 50+ linters)
        - **delve** - Debugger (`dlv debug`)
        - **pprof** - Profiling (CPU, memory, goroutines)
        - **govulncheck** - Vulnerability scanner (official)

    !!! danger "Common Gotchas"
        - **Range loop captures** - Loop variable reused (use `v := v`)
        - **Slice append** - May reallocate (capacity changes)
        - **Map iteration order** - Random (not insertion order)
        - **Nil slice vs empty slice** - Different (nil has no allocation)
        - **Interface nil** - Interface with nil value ≠ nil interface
        - **Goroutine leaks** - Goroutines block forever (context cancellation)
        - **Mutex copy** - Never copy sync.Mutex (pass by pointer)
        - **String immutability** - Strings are immutable (byte slice for modification)

    !!! info "Package Ecosystem"
        - **Web** - Gin, Echo, Fiber (frameworks), Chi (router)
        - **Database** - GORM (ORM), sqlx (SQL extensions), pgx (PostgreSQL)
        - **Testing** - testify (assertions), gomock (mocking), httptest (HTTP testing)
        - **CLI** - Cobra (commands), Viper (config), promptui (interactive)
        - **Logging** - zap (fast), logrus (structured), zerolog (JSON)
        - **Validation** - validator (struct validation), ozzo-validation

______________________________________________________________________

## :octicons-package-16: Package Management

### Go Modules (Standard)

```bash
# Initialize module
go mod init github.com/username/project

# Add dependency (automatically on first import)
go get github.com/gin-gonic/gin

# Install specific version
go get github.com/gin-gonic/gin@v1.9.0

# Update dependencies
go get -u ./...          # Update all
go get -u github.com/gin-gonic/gin  # Update specific

# Tidy (remove unused, add missing)
go mod tidy

# Vendor dependencies (optional)
go mod vendor

# List dependencies
go list -m all

# Verify checksums
go mod verify
```

### Project Structure

```bash
myproject/
├── go.mod              # Module definition
├── go.sum              # Dependency checksums
├── cmd/                # Application entry points
│   └── server/
│       └── main.go
├── internal/           # Private application code
│   ├── api/
│   └── database/
├── pkg/                # Public libraries
│   └── utils/
└── README.md
```

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Free Resources

- **[A Tour of Go](https://go.dev/tour/)** - Official interactive tutorial (start here)
- **[Go by Example](https://gobyexample.com/)** - Annotated code examples
- **[Effective Go](https://go.dev/doc/effective_go)** - Idiomatic Go patterns
- **[Go Standard Library](https://pkg.go.dev/std)** - Comprehensive docs
- **[Go Blog](https://go.dev/blog/)** - Deep dives from Go team

### :octicons-code-16: Practice Projects

!!! example "Beginner"
    - **CLI tool** - Todo list, file organizer, system monitor
    - **REST API** - CRUD with Gin/Echo + PostgreSQL
    - **Web scraper** - Concurrent scraping with colly
    - **File server** - Static file hosting with standard library

!!! example "Intermediate"
    - **Microservice** - gRPC service with protobuf
    - **Worker pool** - Task queue with channels and goroutines
    - **Rate limiter** - Token bucket algorithm
    - **Cache server** - In-memory cache with TTL

!!! example "Advanced"
    - **Load balancer** - Reverse proxy with health checks
    - **Distributed system** - Raft consensus implementation
    - **Database** - Simple key-value store
    - **Container runtime** - Minimal Docker-like tool

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [Go Documentation](https://go.dev/doc/)

    [Go Standard Library](https://pkg.go.dev/std)

    [Go Packages](https://pkg.go.dev/)

    [Go Playground](https://go.dev/play/)

- :octicons-tools-16: __Essential Tools__

    ______________________________________________________________________

    [golangci-lint](https://golangci-lint.run/)

    [delve (debugger)](https://github.com/go-delve/delve)

    [govulncheck](https://go.dev/blog/vuln)

    [go-migrate](https://github.com/golang-migrate/migrate)

- :octicons-code-16: __Popular Frameworks__

    ______________________________________________________________________

    [Gin Web Framework](https://gin-gonic.com/)

    [Echo](https://echo.labstack.com/)

    [GORM](https://gorm.io/)

    [Cobra CLI](https://cobra.dev/)

    [gRPC](https://grpc.io/docs/languages/go/)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [r/golang](https://reddit.com/r/golang)

    [Gophers Slack](https://invite.slack.golangbridge.org/)

    [Stack Overflow [go]](https://stackoverflow.com/questions/tagged/go)

    [GopherCon](https://www.gophercon.com/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-star-16: **Cloud Native** - Go dominates cloud infrastructure (Kubernetes, Docker, Terraform). Fast compilation, simple deployment (single binary). Excellent concurrency model (goroutines). Opinionated (one way to do things). Standard library comprehensive. Learning curve moderate. Performance excellent. If you're building backend services or CLI tools, Go is solid choice.

**Tags:** go, golang, systems-programming, concurrency, backend
