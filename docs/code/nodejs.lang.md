---
title: Node.js
description: JavaScript runtime for server-side development - event-driven, non-blocking I/O, massive npm ecosystem
---

# :octicons-code-16: Node.js

JavaScript runtime built on Chrome's V8 engine. Event-driven, non-blocking I/O makes it ideal for I/O-heavy applications (APIs, real-time apps, microservices). Single-threaded event loop handles thousands of concurrent connections. npm is the largest package ecosystem (2M+ packages). Fast for I/O, terrible for CPU-intensive tasks.

!!! tip "2026 Update"
    Node.js 22 LTS brings native TypeScript support (no transpilation needed). V8 performance improvements (30% faster JSON parsing). ESM (ES Modules) finally standard (CommonJS legacy). Bun and Deno are serious alternatives. pnpm replaces npm (faster, disk-efficient). Serverless Node.js dominates (AWS Lambda, Vercel, Cloudflare Workers).

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Syntax"

    ```javascript
    // Variables (prefer const/let, avoid var)
    const name = "Node.js";        // Immutable
    let version = 22;              // Mutable
    // var is legacy (function-scoped, hoisting issues)

    // String templates (backticks)
    const greeting = `Hello, ${name} v${version}`;  // (1)!

    // Arrow functions (modern syntax)
    const add = (a, b) => a + b;
    const greet = name => `Hello, ${name}`;  // Single param, no parens

    // Traditional function
    function multiply(a, b) {
        return a * b;
    }

    // Destructuring (clean object/array extraction)
    const user = { id: 1, name: "Alice", email: "alice@example.com" };
    const { name: userName, email } = user;  // (2)!

    const numbers = [1, 2, 3, 4, 5];
    const [first, second, ...rest] = numbers;  // rest = [3, 4, 5]

    // Spread operator (copy, merge)
    const arr1 = [1, 2, 3];
    const arr2 = [...arr1, 4, 5];  // [1, 2, 3, 4, 5]
    const obj1 = { a: 1, b: 2 };
    const obj2 = { ...obj1, c: 3 };  // { a: 1, b: 2, c: 3 }

    // Promises (async operations)
    const fetchUser = (id) => {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                if (id > 0) {
                    resolve({ id, name: "Alice" });
                } else {
                    reject(new Error("Invalid ID"));
                }
            }, 1000);
        });
    };  // (3)!

    // Async/await (modern promise syntax)
    async function getUser(id) {
        try {
            const user = await fetchUser(id);
            console.log(user);
            return user;
        } catch (error) {
            console.error("Error:", error.message);
        }
    }  // (4)!

    // Array methods (functional style)
    const numbers = [1, 2, 3, 4, 5];
    const doubled = numbers.map(n => n * 2);        // [2, 4, 6, 8, 10]
    const evens = numbers.filter(n => n % 2 === 0); // [2, 4]
    const sum = numbers.reduce((acc, n) => acc + n, 0);  // 15

    // Classes (ES6+)
    class User {
        constructor(name, email) {
            this.name = name;
            this.email = email;
        }

        greet() {
            return `Hello, ${this.name}`;
        }

        static createGuest() {
            return new User("Guest", "guest@example.com");
        }
    }

    // Modules (ESM - modern Node.js)
    // math.js
    export const add = (a, b) => a + b;
    export const subtract = (a, b) => a - b;
    export default class Calculator { }  // (5)!

    // app.js
    import Calculator, { add, subtract } from './math.js';
    // OR CommonJS (legacy)
    const { add, subtract } = require('./math.js');
    ```

    1. Template literals support multi-line strings and expressions
    2. Destructuring avoids repetitive `user.name`, `user.email`
    3. Promises handle async operations (avoid callback hell)
    4. Async/await makes async code look synchronous (cleaner)
    5. ESM is modern (use `"type": "module"` in package.json)

    **Real talk:**

    - Always use `const` unless you need to reassign (prefer immutability)
    - Arrow functions don't bind `this` (matters in classes/callbacks)
    - Async/await is mandatory for modern Node.js (no more callback hell)
    - ESM is the future (CommonJS is legacy but still common)
    - Array methods (`map`, `filter`, `reduce`) are idiomatic JavaScript

=== ":octicons-zap-16: Common Patterns"

    ```javascript
    // Express.js REST API (most popular framework)
    import express from 'express';
    const app = express();

    app.use(express.json());  // Parse JSON bodies  // (1)!

    // GET endpoint
    app.get('/api/users', async (req, res) => {
        const users = await db.query('SELECT * FROM users');
        res.json(users);
    });

    // POST endpoint with validation
    app.post('/api/users', async (req, res) => {
        const { name, email } = req.body;
        if (!name || !email) {
            return res.status(400).json({ error: 'Missing fields' });
        }
        const user = await db.insert({ name, email });
        res.status(201).json(user);
    });

    app.listen(3000, () => {
        console.log('Server running on port 3000');
    });  // (2)!

    // Fastify (faster alternative to Express)
    import Fastify from 'fastify';
    const fastify = Fastify({ logger: true });

    fastify.get('/api/users', async (request, reply) => {
        const users = await db.query('SELECT * FROM users');
        return users;  // Auto-serialized to JSON
    });

    await fastify.listen({ port: 3000 });  // (3)!

    // Database connection (PostgreSQL with pg)
    import pg from 'pg';
    const { Pool } = pg;

    const pool = new Pool({
        host: 'localhost',
        port: 5432,
        database: 'mydb',
        user: 'postgres',
        password: 'password',
        max: 20,  // Connection pool size
    });

    // Query with parameterized statement (prevent SQL injection)
    const getUserById = async (id) => {
        const result = await pool.query(
            'SELECT * FROM users WHERE id = $1',
            [id]  // Parameterized query
        );
        return result.rows[0];
    };  // (4)!

    // File operations (fs/promises - async API)
    import { readFile, writeFile, mkdir } from 'fs/promises';
    import { join } from 'path';

    // Read file
    const content = await readFile('data.json', 'utf-8');
    const data = JSON.parse(content);

    // Write file (create directories if needed)
    await mkdir('output', { recursive: true });
    await writeFile('output/result.json', JSON.stringify(data, null, 2));

    // HTTP requests (fetch is built-in in Node.js 18+)
    const response = await fetch('https://api.example.com/users');
    const users = await response.json();  // (5)!

    // Or use axios (more features)
    import axios from 'axios';
    const { data } = await axios.get('https://api.example.com/users', {
        headers: { 'Authorization': 'Bearer token' }
    });

    // Environment variables (.env file)
    import 'dotenv/config';  // Load .env file
    const dbUrl = process.env.DATABASE_URL;
    const apiKey = process.env.API_KEY;  // (6)!

    // Error handling middleware (Express)
    app.use((err, req, res, next) => {
        console.error(err.stack);
        res.status(500).json({ error: 'Internal server error' });
    });

    // Graceful shutdown
    process.on('SIGTERM', async () => {
        console.log('SIGTERM received, closing server...');
        await pool.end();  // Close DB connections
        server.close(() => {
            console.log('Server closed');
            process.exit(0);
        });
    });  // (7)!

    // Testing with Vitest (modern, fast)
    import { describe, it, expect } from 'vitest';

    describe('add function', () => {
        it('adds two numbers', () => {
            expect(add(2, 3)).toBe(5);
        });

        it('handles negative numbers', () => {
            expect(add(-1, 1)).toBe(0);
        });
    });  // (8)!

    // WebSockets (real-time communication)
    import { WebSocketServer } from 'ws';

    const wss = new WebSocketServer({ port: 8080 });

    wss.on('connection', (ws) => {
        ws.on('message', (message) => {
            // Broadcast to all clients
            wss.clients.forEach((client) => {
                if (client.readyState === 1) {  // OPEN
                    client.send(message);
                }
            });
        });
    });  // (9)!

    // Streams (memory-efficient file processing)
    import { createReadStream, createWriteStream } from 'fs';
    import { pipeline } from 'stream/promises';
    import { createGzip } from 'zlib';

    // Compress file (stream avoids loading entire file in memory)
    await pipeline(
        createReadStream('large-file.txt'),
        createGzip(),
        createWriteStream('large-file.txt.gz')
    );  // (10)!
    ```

    1. Express middleware parses JSON request bodies
    2. Express simple but slower than Fastify
    3. Fastify 2-3x faster than Express (native schema validation)
    4. Parameterized queries prevent SQL injection
    5. Fetch API built-in since Node.js 18 (no more axios required)
    6. dotenv loads environment variables from .env file
    7. Graceful shutdown prevents data loss (close connections cleanly)
    8. Vitest faster than Jest (ESM-native, watch mode)
    9. WebSockets enable real-time bidirectional communication
    10. Streams handle large files without loading into memory

    **Why this works:**

    - Express/Fastify handle routing, middleware, HTTP automatically
    - Connection pooling reuses database connections (performance)
    - Async/await makes async code readable (no callback hell)
    - Parameterized queries prevent SQL injection
    - Graceful shutdown prevents data corruption
    - Streams process large files efficiently (low memory usage)

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Use pnpm** - 2x faster than npm, saves disk space (deduplicated)
        - **TypeScript** - Type safety catches bugs at compile time
        - **ESM over CommonJS** - Modern module system (set `"type": "module"`)
        - **Fastify over Express** - 2-3x faster, native async/await
        - **Environment variables** - Use dotenv, never commit secrets
        - **Error handling** - Always handle promise rejections (avoid unhandled)
        - **Graceful shutdown** - Handle SIGTERM for zero-downtime deploys
        - **Logging** - Use pino or winston (not console.log in production)

    !!! warning "Performance"
        - **Single-threaded** - CPU-intensive tasks block event loop (use worker threads)
        - **Cluster mode** - Run multiple Node processes (utilize all CPU cores)
        - **Event loop blocking** - Avoid synchronous operations (readFileSync, etc.)
        - **Memory leaks** - Node doesn't GC properly if you hold references
        - **Connection pooling** - Reuse DB connections (don't create per-request)
        - **Caching** - Use Redis for frequently accessed data
        - **Profiling** - Use `node --inspect` + Chrome DevTools for bottlenecks

    !!! tip "Modern Node.js Tools"
        - **pnpm** - Fast, disk-efficient package manager (replaces npm)
        - **tsx** - Run TypeScript directly (no build step)
        - **Vitest** - Fast test runner (ESM-native, 10x faster than Jest)
        - **esbuild** - Bundle JavaScript/TypeScript (100x faster than webpack)
        - **Biome** - Linter + formatter (Rust-based, replaces ESLint + Prettier)
        - **Drizzle ORM** - Type-safe SQL (better than Prisma for performance)
        - **pino** - Fast JSON logger (5x faster than winston)

    !!! danger "Common Gotchas"
        - **Callback hell** - Use async/await (avoid nested callbacks)
        - **Unhandled promise rejections** - Always `.catch()` or `try/catch`
        - **Blocking event loop** - Synchronous operations freeze server
        - **Memory leaks** - Closures, event listeners, global variables
        - **require() vs import** - Can't mix CommonJS and ESM easily
        - **this binding** - Arrow functions don't bind `this` (use regular functions in classes)
        - **package.json scripts** - Use `&&` for sequential, `&` for parallel (Unix syntax)

    !!! info "Framework Ecosystem"
        - **Web** - Express (popular), Fastify (fast), Hono (modern)
        - **Full-stack** - Next.js, Remix, Nuxt.js, SvelteKit
        - **API** - tRPC (type-safe APIs), GraphQL (Apollo, Pothos)
        - **Database** - Prisma (ORM), Drizzle (type-safe SQL), Kysely (query builder)
        - **Testing** - Vitest, Jest, Playwright (E2E), Supertest (API testing)
        - **Real-time** - Socket.io, ws (WebSockets), Server-Sent Events

______________________________________________________________________

## :octicons-package-16: Package Management

### Modern Approach (pnpm - Recommended)

```bash
# Install pnpm (fast, disk-efficient)
npm install -g pnpm

# Initialize project
pnpm init

# Install packages
pnpm add express
pnpm add -D typescript @types/node  # Dev dependencies

# Install all dependencies
pnpm install

# Run scripts
pnpm start
pnpm test

# Update packages
pnpm update
pnpm outdated  # Check for updates
```

### Traditional Approach (npm)

```bash
# Initialize project
npm init -y

# Install packages
npm install express
npm install --save-dev typescript

# Install from package.json
npm install

# Run scripts
npm start
npm run dev

# Update packages
npm update
npm outdated
```

### Alternative Runtime (Bun - Fastest)

```bash
# Install Bun (3x faster than Node.js)
curl -fsSL https://bun.sh/install | bash

# Run TypeScript directly (no transpilation)
bun run index.ts

# Install packages (10x faster than npm)
bun install

# Run tests
bun test
```

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Free Resources

- **[Node.js Official Docs](https://nodejs.org/docs/)** - Start here for APIs
- **[MDN JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)** - JavaScript fundamentals
- **[Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)** - Production patterns
- **[Express.js Guide](https://expressjs.com/en/guide/routing.html)** - Most popular framework
- **[NPM Package Search](https://www.npmjs.com/)** - Find packages

### :octicons-code-16: Practice Projects

!!! example "Beginner"
    - **CLI tool** - Todo list, file renamer, URL shortener
    - **REST API** - CRUD operations with Express + PostgreSQL
    - **File processor** - Read CSV, transform data, write JSON
    - **Web scraper** - Cheerio for HTML parsing

!!! example "Intermediate"
    - **Real-time chat** - WebSockets with Socket.io
    - **Authentication API** - JWT tokens, bcrypt passwords, refresh tokens
    - **Microservice** - Fastify + PostgreSQL + Redis caching
    - **Image processor** - Sharp library for resizing/optimization

!!! example "Advanced"
    - **GraphQL API** - Apollo Server with DataLoader
    - **Event-driven architecture** - RabbitMQ or Kafka consumers
    - **Serverless functions** - AWS Lambda or Vercel functions
    - **npm package** - Create and publish reusable library

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [Node.js Documentation](https://nodejs.org/docs/)

    [Node.js API Reference](https://nodejs.org/api/)

    [npm Registry](https://www.npmjs.com/)

    [V8 JavaScript Engine](https://v8.dev/)

- :octicons-tools-16: __Essential Tools__

    ______________________________________________________________________

    [pnpm (package manager)](https://pnpm.io/)

    [tsx (TypeScript runner)](https://github.com/privatenumber/tsx)

    [Vitest (testing)](https://vitest.dev/)

    [esbuild (bundler)](https://esbuild.github.io/)

    [Biome (linter/formatter)](https://biomejs.dev/)

- :octicons-code-16: __Popular Frameworks__

    ______________________________________________________________________

    [Express.js](https://expressjs.com/)

    [Fastify](https://www.fastify.io/)

    [Next.js](https://nextjs.org/)

    [Prisma ORM](https://www.prisma.io/)

    [Socket.io](https://socket.io/)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [r/node](https://reddit.com/r/node)

    [Node.js Discord](https://discord.com/invite/nodejs)

    [Stack Overflow [node.js]](https://stackoverflow.com/questions/tagged/node.js)

    [OpenJS Foundation](https://openjsf.org/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-star-16: **Dominant** - Node.js powers most backend JavaScript. npm is the largest package ecosystem (2M+ packages). Fast for I/O (APIs, real-time), terrible for CPU work. Serverless Node.js everywhere (Lambda, Vercel, Cloudflare Workers). Bun and Deno are viable alternatives but Node.js still dominates.

**Tags:** nodejs, javascript, backend, server-side, runtime
