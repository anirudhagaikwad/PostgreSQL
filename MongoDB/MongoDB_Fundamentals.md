## Table of Contents
1. [What is MongoDB?](#1-what-is-mongodb)
2. [What is mongod?](#2-what-is-mongod)
3. [MongoDB Atlas](#3-mongodb-atlas)
4. [MongoDB Compass](#4-mongodb-compass)
5. [Installing Community Server](#5-installing-community-server)
6. [Creating a Database](#6-creating-a-database)
7. [Creating Collections](#7-creating-collections)
8. [Inserting Data](#8-inserting-data)
9. [Find Operations](#9-find-operations)
10. [Sort, Limit & Skip](#10-sort-limit--skip)
11. [Update Operations](#11-update-operations)
12. [Quick Reference Cheat Sheet](#12-quick-reference-cheat-sheet)

---

## 1. What is MongoDB?

MongoDB is an open-source **NoSQL document database** that stores data in flexible, JSON-like documents called **BSON** (Binary JSON).

**Key Concepts:**

| MongoDB Term | SQL Equivalent |
|---|---|
| Database | Database |
| Collection | Table |
| Document | Row / Record |
| Field | Column |
| `_id` | Primary Key |

**Why MongoDB?**
- Schema-less — documents in a collection can have different fields
- Horizontally scalable — handles massive datasets easily
- Stores complex nested data naturally (arrays, objects)
- Fast reads with proper indexing

---

## 2. What is mongod?

`mongod` is the **MongoDB Daemon** — the primary background process that runs the database.

```bash
# Start the MongoDB daemon
mongod

# Check version
mongod --version

# Connect via shell
mongosh
```

**Important Facts:**
- Default port: **27017**
- Must be running before you can connect with `mongosh` or Compass
- Handles all data requests, writes, and management tasks

---

## 3. MongoDB Atlas

**MongoDB Atlas** is a fully managed cloud database service (Database-as-a-Service).

**Getting Started with Atlas:**
1. Go to [cloud.mongodb.com](https://cloud.mongodb.com) and register
2. Create an Organization and Project
3. Click **Build a Cluster** → Choose **Free Tier (M0)**
4. Select your cloud provider (AWS / Azure / GCP) and region
5. Under **Database Access** → Create a database user (username + password)
6. Under **Network Access** → Add your current IP address
7. Click **Connect** → Choose connection method

**Atlas vs Local:**

| Feature | Atlas | Local (Community) |
|---|---|---|
| Setup | Minutes, browser-based | Manual install |
| Cost | Free M0 tier available | Free |
| Scaling | Automatic | Manual |
| Backups | Automated | Manual |
| Best for | Cloud apps, teams | Learning, local dev |

---

## 4. MongoDB Compass

**MongoDB Compass** is the official **GUI (Graphical User Interface)** for MongoDB.

**Features:**
- Visually browse databases and collections
- Build queries with a query bar (no code required)
- Import CSV / JSON files
- Aggregation pipeline builder
- Real-time performance statistics
- Connect to local OR Atlas deployments

**Connecting Compass:**
1. Download from [mongodb.com/products/tools/compass](https://www.mongodb.com/products/tools/compass)
2. Open Compass → Paste connection string
3. For local: `mongodb://localhost:27017`
4. For Atlas: Copy connection string from Atlas → Connect → Compass

---

## 5. Installing Community Server

### Step-by-step Installation

**Step 1 — Download**
```
mongodb.com → Products → Community Edition
Select OS → Download .msi (Windows) or .tgz (Mac/Linux)
```

**Step 2 — Install**
- Run the installer
- Choose **Complete** installation type
- Check **Install MongoDB as a Windows Service** (recommended)

**Step 3 — Install MongoDB Shell (mongosh)**
```
mongodb.com → Try/Download → Shell
Download and install separately
```

**Step 4 — Verify Installation**
```bash
mongod --version     # Should print MongoDB version
mongosh --version    # Should print mongosh version
```

**Step 5 — Start & Connect**
```bash
mongod               # Start the database daemon (keep this running)
mongosh              # Open the interactive shell in a new terminal
```

---

## 6. Creating a Database

```js
// Switch to (or create) a database
use myDatabase

// Check current database
db

// List all databases (only shows DBs with data)
show dbs
```

> **Note:** MongoDB doesn't actually create the database until you insert data into it.

---

## 7. Creating Collections

```js
// Method 1: Explicit creation
db.createCollection("users")

// Method 2: Auto-created on first insert
db.users.insertOne({ name: "Alice" })

// List all collections in current database
show collections

// Drop a collection
db.users.drop()
```

---

## 8. Inserting Data

### insertOne() — Single Document

```js
db.users.insertOne({
  name: "Alice",
  age: 25,
  city: "Mumbai",
  skills: ["JavaScript", "MongoDB"]
})
```

### insertMany() — Multiple Documents

```js
db.users.insertMany([
  { name: "Alice", age: 25, city: "Mumbai" },
  { name: "Bob",   age: 30, city: "Delhi"  },
  { name: "Carol", age: 22, city: "Pune"   },
  { name: "David", age: 28, city: "Mumbai" }
])
```

> **Tip:** MongoDB automatically generates a unique `_id` (ObjectId) for every document.

---

## 9. Find Operations

### Basic Find

```js
// Find ALL documents
db.users.find()

// Find all — pretty format
db.users.find().pretty()

// Find ONE document
db.users.findOne({ name: "Alice" })

// Find with exact match filter
db.users.find({ city: "Mumbai" })
```

### Comparison Operators

```js
// Greater than / Less than
db.users.find({ age: { $gt: 20 } })       // age > 20
db.users.find({ age: { $gte: 25 } })      // age >= 25
db.users.find({ age: { $lt: 30 } })       // age < 30
db.users.find({ age: { $lte: 28 } })      // age <= 28
db.users.find({ age: { $ne: 25 } })       // age != 25

// Range query
db.users.find({ age: { $gt: 20, $lt: 30 } })

// In / Not In
db.users.find({ city: { $in: ["Mumbai", "Delhi"] } })
db.users.find({ city: { $nin: ["Pune"] } })
```

### Logical Operators

```js
// AND (implicit — just add more fields)
db.users.find({ city: "Mumbai", age: 25 })

// AND (explicit)
db.users.find({ $and: [{ city: "Mumbai" }, { age: 25 }] })

// OR
db.users.find({ $or: [{ city: "Delhi" }, { age: 22 }] })

// NOT
db.users.find({ age: { $not: { $gt: 25 } } })

// NOR
db.users.find({ $nor: [{ city: "Pune" }, { age: 30 }] })
```

### Projection (Select Specific Fields)

```js
// Include only name and city (exclude _id)
db.users.find({}, { name: 1, city: 1, _id: 0 })

// Exclude specific field
db.users.find({}, { age: 0 })
```

### Element Operators

```js
// Field exists
db.users.find({ skills: { $exists: true } })

// Field type check
db.users.find({ age: { $type: "int" } })
```

---

## 10. Sort, Limit & Skip

```js
// Sort ASCENDING (A→Z, lowest→highest)
db.users.find().sort({ age: 1 })

// Sort DESCENDING (Z→A, highest→lowest)
db.users.find().sort({ age: -1 })

// Sort by multiple fields
db.users.find().sort({ city: 1, age: -1 })

// Limit number of results
db.users.find().limit(5)

// Skip documents (for pagination)
db.users.find().skip(10).limit(5)

// Combined: filter + sort + limit
db.users.find({ city: "Mumbai" }).sort({ age: -1 }).limit(3)

// Count documents
db.users.countDocuments({ city: "Mumbai" })
```

---

## 11. Update Operations

### updateOne() — Update First Match

```js
db.users.updateOne(
  { name: "Alice" },           // Filter
  { $set: { age: 26 } }        // Update
)
```

### updateMany() — Update All Matches

```js
db.users.updateMany(
  { city: "Mumbai" },
  { $set: { status: "active" } }
)
```

### replaceOne() — Replace Entire Document

```js
db.users.replaceOne(
  { name: "Bob" },
  { name: "Bob", age: 31, city: "Goa" }    // Full replacement
)
```

### Update Operators

```js
$set        // Set a field value
$unset      // Remove a field
$inc        // Increment a number field
$mul        // Multiply a number field
$rename     // Rename a field
$min        // Update if new value is less
$max        // Update if new value is greater
$push       // Add item to array
$pull       // Remove item from array
$addToSet   // Add to array only if not exists
$pop        // Remove first (-1) or last (1) array item
```

**Examples:**

```js
// Increment age by 1
db.users.updateOne({ name: "Alice" }, { $inc: { age: 1 } })

// Remove a field
db.users.updateOne({ name: "Bob" }, { $unset: { status: "" } })

// Push to array
db.users.updateOne({ name: "Alice" }, { $push: { skills: "Python" } })

// Add to set (no duplicates)
db.users.updateOne({ name: "Alice" }, { $addToSet: { skills: "MongoDB" } })

// Upsert: insert if not found
db.users.updateOne(
  { name: "Eve" },
  { $set: { age: 27, city: "Chennai" } },
  { upsert: true }
)
```

---

## 12. Quick Reference Cheat Sheet

```js
// DATABASE
use myDB                           // Switch/create database
show dbs                           // List databases
db                                 // Current database
db.dropDatabase()                  // Drop current database

// COLLECTIONS
db.createCollection("x")           // Create collection
show collections                   // List collections
db.x.drop()                        // Drop collection

// INSERT
db.x.insertOne({...})              // Insert one
db.x.insertMany([...])             // Insert many

// READ
db.x.find()                        // Find all
db.x.find({ k: v })                // Find with filter
db.x.findOne({ k: v })             // Find first match
db.x.find({}, { field: 1 })        // With projection
db.x.countDocuments()              // Count all
db.x.countDocuments({ k: v })      // Count with filter

// SORT / LIMIT / SKIP
db.x.find().sort({ k: 1 })         // Ascending
db.x.find().sort({ k: -1 })        // Descending
db.x.find().limit(n)               // Limit n results
db.x.find().skip(n)                // Skip n results

// UPDATE
db.x.updateOne({f}, { $set: {} })  // Update one
db.x.updateMany({f}, { $set: {} }) // Update many
db.x.replaceOne({f}, {...})        // Replace one

// DELETE
db.x.deleteOne({ k: v })           // Delete one
db.x.deleteMany({ k: v })          // Delete many
db.x.deleteMany({})                // Delete ALL documents
```

---

### Comparison Operators Summary

| Operator | Meaning |
|---|---|
| `$eq` | Equal to |
| `$ne` | Not equal to |
| `$gt` | Greater than |
| `$gte` | Greater than or equal |
| `$lt` | Less than |
| `$lte` | Less than or equal |
| `$in` | In array |
| `$nin` | Not in array |

### Logical Operators Summary

| Operator | Meaning |
|---|---|
| `$and` | All conditions true |
| `$or` | At least one true |
| `$not` | Condition is false |
| `$nor` | None are true |

---


## 🗑️ Remove a Specific **Field** from a Document

Use `$unset` inside `updateOne()` or `updateMany()`.

```js
// Remove a field from ONE document
db.users.updateOne(
  { name: "Alice" },        // filter — which document
  { $unset: { age: "" } }   // remove the 'age' field
)

// Remove a field from ALL matching documents
db.users.updateMany(
  { city: "Mumbai" },
  { $unset: { status: "" } }
)

// Remove a field from EVERY document in the collection
db.users.updateMany(
  {},
  { $unset: { status: "" } }
)
```

> 💡 The value you pass to `$unset` doesn't matter — `""` is just a convention. MongoDB simply removes the field entirely.

---

## ❌ Remove a Specific **Document**

Use `deleteOne()` or `deleteMany()`.

```js
// Delete ONE document (first match)
db.users.deleteOne({ name: "Alice" })

// Delete ONE by _id (most precise)
db.users.deleteOne({ _id: ObjectId("64b1f2c3e4b0a1d2e3f45678") })

// Delete ALL documents matching a filter
db.users.deleteMany({ city: "Delhi" })

// ⚠️ Delete ALL documents in the collection
db.users.deleteMany({})
```

---

## 🔍 Quick Comparison Table

| Goal | Method |
|---|---|
| Remove a **field** from one doc | `updateOne({filter}, { $unset: { field: "" } })` |
| Remove a **field** from many docs | `updateMany({filter}, { $unset: { field: "" } })` |
| Delete a **document** (one) | `deleteOne({ filter })` |
| Delete **documents** (many) | `deleteMany({ filter })` |
| Delete **all** documents | `deleteMany({})` |

---

> ⚠️ **Warning:** `deleteMany({})` with an empty filter removes **all documents** in the collection — use it carefully! If you want to wipe everything including the collection itself, use `db.users.drop()`.
