---
title: Web Applications
sub_title: Websockets
author: Suhel Hammoud

theme:
  override:
    code:
      alignment: left
      margin:
        percent: 3
      #   padding:
      # horizontal: 4
---

**Slide 1: Introduction to ORM**

* **What is ORM?**

  * Object-Relational Mapping (ORM) is a technique that maps data between a relational database and application objects (e.g., TypeScript classes/interfaces ↔ tables).
  * Allows backend developers to work with database rows using native language constructs (methods, properties) rather than writing raw SQL.
* **Why ORMs Matter for Backend Development**

  * Reduces boilerplate SQL, making code more concise and maintainable.
  * Provides abstractions for common tasks: defining schemas, performing CRUD operations, handling relations, and running migrations.
  * Encourages a clear separation of concerns, making code easier to test and refactor.

<!-- end_slide -->



**Slide 2: Relational vs. Object Paradigm**

* **Relational Model (Tables)**

  * Data organized in tables with rows and columns; columns have fixed types.
  * Relationships represented via foreign-keys and join (link) tables.
  * Interactions typically via SQL `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
* **Object Paradigm (Classes/Objects)**

  * Data represented as TypeScript interfaces/classes with properties and methods.
  * Supports encapsulation, inheritance, and polymorphism in code.
  * Manipulation through method calls and property assignments.
* **The Impedance Mismatch**

  * Objects have rich type hierarchies; relational tables do not.
  * Mapping TypeScript types (e.g., `string | null`, `Date`) to SQL column types.
  * Navigating object graphs vs. writing explicit `JOIN` queries.

<!-- end_slide -->



**Slide 3: Core Concepts of ORM**

* **Schema / Model Definition**

  * Define database tables and columns in code. Drizzle-ORM uses a “schema” object per table.
  * Example (TypeScript, Drizzle-ORM):

```ts
import { pgTable, serial, text, varchar } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
    id: serial('id').primaryKey(),
    username: varchar('username', { length: 50 }).notNull().unique(),
    email: varchar('email', { length: 100 }).notNull().unique(),
});
```
* **Database Instance / Connection**

  * Use a database client and pass the schema to Drizzle to create a `db` object.
  * Example:

```ts
import { drizzle } from 'drizzle-orm/node-postgres';
import { Pool } from 'pg';
import { users } from './schema';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
export const db = drizzle(pool, { logger: true });
```
* **Query Builder / Fluent API**

  * Drizzle-ORM provides a type-safe, fluent API (`select`, `insert`, `update`, `delete`) without raw SQL.
  * Type checking at compile time helps catch errors early.

<!-- end_slide -->



**Slide 4: Mapping Strategies**

* **Table-per-Class (One Table per Entity)**

  * Each Drizzle schema object → its own table. Typical default.
  * Simple: schema files map 1:1 to tables.
* **Table-per-Hierarchy (Single Table Inheritance)**

  * Single table with a “discriminator” column to distinguish subtypes.
  * Example: combine `admin_users` and `regular_users` into `users` table with `role` column.
* **Table-per-Subclass (Class Table Inheritance)**

  * Base table for shared fields + separate tables for subtype-specific columns.
  * Requires manual joins in Drizzle queries, e.g.:

```ts
// Base schema
export const people = pgTable('people', {
    id: serial('id').primaryKey(),
    name: varchar('name', { length: 100 }).notNull(),
});

// Subclass schema
export const employees = pgTable('employees', {
    person_id: integer('person_id').references(() => people.id),
    position: varchar('position', { length: 50 }).notNull(),
});
```
* **Choosing a Strategy**

  * Balance: performance (fewer JOINs vs. normalized structure), ease of queries, and schema clarity.

<!-- end_slide -->



**Slide 5: Defining Relationships**

* **One-to-One**

  * Example: `User` ↔ `Profile`.
  * Profile SCHEMA:

```ts
export const profiles = pgTable('profiles', {
    id: serial('id').primaryKey(),
    userId: integer('user_id').references(() => users.id).notNull().unique(),
    bio: text('bio'),
});
```
  * Query to fetch user with profile (JOIN):

```ts
const result = await db
    .select({
    user: users,
    profile: profiles,
    })
    .from(users)
    .leftJoin(profiles, eq(profiles.userId, users.id))
    .where(eq(users.id, someUserId));
```
* **One-to-Many / Many-to-One**

  * Example: `Author` (1) ↔ `Book` (many).
  * Define schemas:

```ts
export const authors = pgTable('authors', {
    id: serial('id').primaryKey(),
    name: varchar('name', { length: 100 }).notNull(),
});

export const books = pgTable('books', {
    id: serial('id').primaryKey(),
    title: varchar('title', { length: 200 }).notNull(),
    authorId: integer('author_id').references(() => authors.id).notNull(),
});
```
  * Fetch author with all books:

```ts
const authorWithBooks = await db
    .select({
    author: authors,
    books: books,
    })
    .from(authors)
    .leftJoin(books, eq(books.authorId, authors.id))
    .where(eq(authors.id, targetAuthorId));
```
* **Many-to-Many**

  * Example: `Student` ↔ `Course` via `enrollments` join table.
  * Define three schemas:

```ts
export const students = pgTable('students', {
    id: serial('id').primaryKey(),
    name: varchar('name', { length: 100 }).notNull(),
});

export const courses = pgTable('courses', {
    id: serial('id').primaryKey(),
    title: varchar('title', { length: 150 }).notNull(),
});

export const enrollments = pgTable('enrollments', {
    studentId: integer('student_id').references(() => students.id).notNull(),
    courseId: integer('course_id').references(() => courses.id).notNull(),
    enrolledAt: timestamp('enrolled_at').defaultNow(),
    primaryKey: ['studentId', 'courseId'],
});
```
  * Query all courses for a student:

```ts
const coursesForStudent = await db
    .select({
    course: courses,
    })
    .from(courses)
    .innerJoin(enrollments, eq(enrollments.courseId, courses.id))
    .where(eq(enrollments.studentId, someStudentId));
```
* **Cascade & Fetch Strategies**

  * Drizzle-ORM does not implicitly cascade deletes; handle via database foreign-key constraints (`ON DELETE CASCADE`) or manual deletion logic.
  * Eager loading is explicit in SELECT JOINs; no hidden lazy loading.

<!-- end_slide -->



**Slide 6: CRUD Operations with Drizzle-ORM**

* **Create (INSERT)**

  * Insert a new user:

```ts
const newUser = await db.insert(users).values({
    username: 'alice',
    email: 'alice@example.com',
}).returning();
```
* **Read (SELECT)**

  * Fetch a user by username:

```ts
const user = await db
    .select()
    .from(users)
    .where(eq(users.username, 'alice'))
    .limit(1);
```
  * Fetch all users:

```ts
const allUsers = await db.select().from(users);
```
* **Update (UPDATE)**

  * Update user’s email:

```ts
await db
    .update(users)
    .set({ email: 'newalice@example.com' })
    .where(eq(users.id, userIdToUpdate));
```
* **Delete (DELETE)**

  * Delete a user by ID:

```ts
await db
    .delete(users)
    .where(eq(users.id, userIdToDelete));
```
* **Transactions**

  * Wrap multiple operations atomically:

```ts
await db.transaction(async (tx) => {
    const u = await tx.insert(users).values({ username: 'bob', email: 'bob@ex.com' }).returning();
    await tx.insert(profiles).values({ userId: u[0].id, bio: 'Hello!' });
});
```

<!-- end_slide -->



**Slide 7: Transactions & Unit of Work**

* **Transaction Management**

  * Drizzle-ORM provides `db.transaction(...)`. All queries inside share a single database transaction.
  * On error, API automatically rolls back; on success, it commits.
* **Unit of Work Pattern**

  * Drizzle-ORM does not maintain an in-memory identity map. However, within a transaction scope, you control when to flush by awaiting each query.
  * Ordering of operations: Drizzle uses native SQL under the hood, so batching is explicit via transactions.
* **Optimistic vs. Pessimistic Locking**

  * **Optimistic:** Add a version column manually. Drizzle-ORM can update with a `WHERE version = ?` clause to detect conflicts. Example:

```ts
await db.update(posts)
    .set({ content: newContent, version: oldVersion + 1 })
    .where(and(eq(posts.id, postId), eq(posts.version, oldVersion)));
```
  * **Pessimistic:** Use raw SQL fragment for `FOR UPDATE` if needed:

```ts
const locked = await db
    .select()
    .from(posts)
    .where(eq(posts.id, postId))
    .for('update');
```
* **Best Practices**

  * Keep transactions short to minimize lock contention.
  * For high-throughput inserts, consider batching multiple `insert(...).values([...])` in one call.

<!-- end_slide -->



**Slide 8: Performance Considerations**

* **N+1 Query Problem**

  * Happens if you SELECT a list of authors, then loop and run a separate SELECT for each author’s books.
  * Mitigation in Drizzle: use a single JOIN to fetch authors and books together:

```ts
const data = await db
    .select({
    author: authors,
    book: books,
    })
    .from(authors)
    .leftJoin(books, eq(books.authorId, authors.id));
```
* **Batching & Bulk Operations**

  * Insert many rows at once:

```ts
await db.insert(users).values([
    { username: 'u1', email: 'u1@ex.com' },
    { username: 'u2', email: 'u2@ex.com' },
    // ...
]);
```
  * Update multiple rows with one query using `set` + `where in`:

```ts
await db
    .update(orders)
    .set({ status: 'shipped' })
    .where(inArray(orders.id, [1, 2, 3]));
```
* **Caching**

  * Drizzle-ORM does not include a built-in second-level cache. Rely on external caching (e.g., Redis) if needed.
  * First-level caching (within a single transaction) is the responsibility of your application code—prevent duplicate reads by retaining object references.
* **SQL Profiling & Logging**

  * Enable Drizzle’s `logger: true` option to log executed SQL and parameters.
  * Analyze slow queries via Postgres’s `EXPLAIN ANALYZE` for optimization.

<!-- end_slide -->



**Slide 9: Schema Generation & Migrations**

* **Automatic Schema Generation**

  * Drizzle can generate SQL `CREATE TABLE` statements from schema definitions:

```ts
import { migrate } from 'drizzle-orm/node-postgres/migrator';

await migrate(drizzleDb, { migrationsFolder: './drizzle_migrations' });
```
  * It creates timestamped migration files reflecting schema changes.
* **Migration Workflow**

  1. Define or modify schema objects (e.g., add a column to `users`).
  2. Run `drizzle migrate create add-user-age` to generate a new migration file.
  3. Edit the generated SQL if needed, then run `drizzle migrate up` to apply.
* **Best Practices**

  * Keep migration scripts under version control.
  * Test migrations on a staging database before production.
  * Avoid data-destructive operations in one step (e.g., drop column after backfilling data).

<!-- end_slide -->



**Slide 10: Using Drizzle-ORM in a Node.js Project**

* **Step 1: Install Dependencies**

```bash
npm install drizzle-orm pg drizzle-kit
```
* **Step 2: Define Schemas**

  * Create `src/schema.ts`:

```ts
import { pgTable, serial, varchar, integer, timestamp, text } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
    id: serial('id').primaryKey(),
    username: varchar('username', { length: 50 }).notNull().unique(),
    email: varchar('email', { length: 100 }).notNull().unique(),
    createdAt: timestamp('created_at').defaultNow(),
});

export const posts = pgTable('posts', {
    id: serial('id').primaryKey(),
    authorId: integer('author_id').references(() => users.id).notNull(),
    title: varchar('title', { length: 200 }).notNull(),
    content: text('content'),
    publishedAt: timestamp('published_at'),
});
```
* **Step 3: Initialize Drizzle in `db.ts`**

```ts
import { drizzle } from 'drizzle-orm/node-postgres';
import { Pool } from 'pg';
import { users, posts } from './schema';

const pool = new Pool({
connectionString: process.env.DATABASE_URL,
});

export const db = drizzle(pool, { logger: true });
```
* **Step 4: Perform Migrations**

  * Configure `drizzle.config.ts`:

```ts
import type { Config } from 'drizzle-kit';

export default {
    schema: './src/schema.ts',
    out: './drizzle_migrations',
    driver: 'pg',
    dbCredentials: {
    connectionString: process.env.DATABASE_URL,
    },
} satisfies Config;
```
  * Run: `npx drizzle-kit generate` → creates migration SQL. Then `npx drizzle-kit push` → applies to DB.
* **Step 5: Use in Business Logic**

  * Example of creating a post:

```ts
async function createPost(authorId: number, title: string, content: string) {
    return await db.insert(posts).values({
    authorId,
    title,
    content,
    publishedAt: new Date(),
    }).returning();
}
```

<!-- end_slide -->



**Slide 11: Best Practices & Anti-Patterns**

* **Keep a Clear Domain Layer**

  * Define interfaces or classes representing domain concepts, separate from raw schema definitions if needed.
  * Example: a `UserEntity` class may wrap Drizzle’s return type.
* **Avoid Unnecessary Column Fetching**

  * Only select columns you need. Use `.select({ id: users.id, username: users.username })` instead of `.select().from(users)` when large tables exist.
* **Prevent N+1 in GraphQL or REST Resolvers**

  * Batch related queries using `JOIN`s or Data Loaders to avoid per-record lookups.
* **Isolate Data Access**

  * Encapsulate all Drizzle calls in repository/service modules. Controllers or resolvers should not directly import `db` to run queries everywhere.
* **Handle Errors Gracefully**

  * Catch Drizzle’s query errors (e.g., unique constraint violations) and map to application errors.
  * Example:

```ts
try {
    await db.insert(users).values({ username: 'bob', email: 'bob@ex.com' });
} catch (err) {
    if (err.code === '23505') {
    throw new Error('User already exists');
    }
    throw err;
}
```
* **Testing with an Isolated Database**

  * Use an in-memory or disposable database (e.g., a Dockerized Postgres) for test runs.
  * Reset state between tests: `await db.delete(posts).execute(); await db.delete(users).execute();`

<!-- end_slide -->



**Slide 12: Putting It All Together: Sample Workflow**

1. **Define Schemas** (`schema.ts`)

   * Use Drizzle’s core types (`serial`, `varchar`, `integer`, ...) to describe tables.
2. **Configure Connection & Drizzle Instance** (`db.ts`)

   * Instantiate `Pool` and call `drizzle(pool, { logger: true })`.
3. **Run Migrations**

   * `npx drizzle-kit generate` → review SQL → `npx drizzle-kit push` → apply to DB.
4. **Encapsulate Data Access in Repositories**

   * Example `userRepository.ts`:

```ts
export const userRepo = {
async create(data: { username: string; email: string }) {
    return await db.insert(users).values(data).returning();
},
async findById(id: number) {
    return await db.select().from(users).where(eq(users.id, id)).limit(1);
},
// ...
};
```
5. **Use in Service/Controller**

   * Example service:

```ts
async function registerUser(username: string, email: string) {
const [created] = await userRepo.create({ username, email });
return created;
}
```
6. **Manage Transactions for Multi-Step Operations**

   * Example: create order + order items in one transaction:

```ts
await db.transaction(async (tx) => {
const [order] = await tx.insert(orders).values({ userId, total }).returning();
await tx.insert(orderItems).values(itemData.map((item) => ({ ...item, orderId: order.id })));
});
```
7. **Optimize & Monitor**

   * Enable `logger: true` to inspect SQL.
   * Add indexes (e.g., `uniqueIndex('email_idx').on(users.email)`) as needed.

<!-- end_slide -->


**Slide 13: Summary & Takeaways**

* **ORM Advantages with Drizzle**

  * Type-safe queries in TypeScript, reducing runtime errors.
  * Clear schema definitions with minimal boilerplate.
  * Built-in migration tooling (`drizzle-kit`) for schema versioning.
* **Key Concepts Recap**

  * Schema definition (`pgTable`, column types), relations via foreign keys.
  * CRUD operations: `db.insert`, `db.select`, `db.update`, `db.delete`.
  * Transactions: `db.transaction(...)` for atomicity.
* **Performance Considerations**

  * Avoid N+1 by using JOINs explicitly.
  * Batch inserts/updates via arrays in `.values([...])`.
  * Enable logging and profile slow queries externally.
* **Best Practices**

  * Encapsulate data access in repository layers.
  * Write and version-control migration scripts.
  * Handle constraint errors gracefully.
  * Keep transactions short and test migrations before production.
* **Next Steps**

  * Build a small Node.js/Express or NestJS backend with Drizzle-ORM.
  * Explore advanced Drizzle features: custom SQL fragments, raw queries, and custom mappers.
  * Integrate caching layers (Redis) for frequently accessed data.

<!-- end_slide -->
