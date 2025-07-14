# Bookstore Inventory App

A Node.js and MySQL-powered inventory management system for bookstores. This application enables users to manage books, authors, customers, orders, and publishers through a web-based interface.

## Features

- View and manage:
  - Books and their authors
  - Customers and orders
  - Book-publisher relationships
- Add new records (books, customers, orders, etc.)
- Relational data linking via foreign keys
- Uses Handlebars templates for dynamic page rendering

## Tech Stack

- **Backend**: Node.js, Express.js
- **Database**: MySQL (with DDL/DML scripts)
- **Frontend**: HTML/CSS, Handlebars
- **Other Tools**: Body-parser, Express-handlebars

## Project Structure

```
├── app.js                # Main Express server
├── db-connector.js       # MySQL connection logic
├── *.js                  # Route logic for adding authors, books, orders, etc.
├── *.hbs / *.html        # View templates
├── DDL.sql               # Database schema
├── DML.sql               # Sample data inserts
```

## Installation

1. **Clone the repo:**

```bash
git clone https://github.com/UTBucky/bookstore-inventory-app
cd bookstore-inventory-app
```

2. **Install dependencies:**

```bash
npm install
```

3. **Set up MySQL:**

- Run `DDL.sql` to create the schema
- Run `DML.sql` to seed sample data

4. **Configure database connection:**

Edit `db-connector.js` with your MySQL credentials:
```js
const db = mysql.createConnection({
  host: 'localhost',
  user: 'your_username',
  password: 'your_password',
  database: 'your_database'
});
```

5. **Start the server:**

```bash
node app.js
```

6. **Visit in browser:**

```
http://localhost:3000
```
