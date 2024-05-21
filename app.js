// App.js

/*
    SETUP
*/
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(express.static('public'))
PORT        = 37596;                 // Set a port number at the top so it's easy to change in the future
var db      = require('./database/db-connector')
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.


/*
    ROUTES
*/
app.get("/home", (req, res) =>
    {
        res.send(`
    <header>
        <h1>Meadowlark Books</h1>
    </header>
    <nav>
        <a href="">Home</a>
        <a href="/customers">Customers</a>
        <a href="/orders">Orders</a>
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
        <a href="/publishers">Publishers</a>
    </nav>
    <main>
        <section>
            <article id="customers">
                <h2>Customers</h2>
                <p>
                    View a list of all Customers. Allows you to add, delete, or update Customers.
                </p>
            </article>
            <article id="orders">
                <h2>Orders</h2>
                <p>
                    View a list of all Orders. Allows you to add, delete, or update Orders.
                </p>
            </article>
            <article id="books">
                <h2>Books</h2>
                <p>
                    View a list of all Books. Allows you to add, delete, or update Books.
                </p>
            </article>
            <article id="authors">
                <h2>Authors</h2>
                <p>
                    View a list of all Authors. Allows you to add, delete, or update Authors.
                </p>
            </article>
            <article id="customers">
                <h2>Publishers</h2>
                <p>
                    View a list of all Publishers. Allows you to add, delete, or update Publishers.
                </p>
            </article>
        </section>
    </main>
        `);
    });

app.get('/authors', function(req, res)
    {  
        let query1 = "SELECT * FROM Authors;";               // Define our query

        db.pool.query(query1, function(error, rows, fields){    // Execute the query

            res.render('index', {data: rows});                  // Render the index.hbs file, and also send the renderer
        })                                                      // an object where 'data' is equal to the 'rows' we
    });                                                         // received back from the query



app.post('/add-author-ajax', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let fName = parseInt(data.fName);
    if (isNaN(fName))
    {
        fName = 'NULL'
    }

    let lName = parseInt(data.lName);
    if (isNaN(lName))
    {
        lName = 'NULL'
    }

    // Create the query and run it on the database
    query1 = `INSERT INTO Authors (fName, lName) VALUES ('${data.fName}', '${data.lName}')`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            // If there was no error, perform a SELECT * on bsg_people
            query2 = `SELECT * FROM Authors;`;
            db.pool.query(query2, function(error, rows, fields){

                // If there was an error on the second query, send a 400
                if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else
                {
                    res.send(rows);
                }
            })
        }
    })
});



app.get('/orders', function(req, res)
    {  
        let query1 = `SELECT orderID, Orders.customerID, Customers.fName,  Customers.lName, dateOrdered, orderType
        FROM Orders INNER JOIN Customers ON Orders.customerID = Customers.customerID;`;               // Define our query

        let query2 = `SELECT customerID, fName, lName, phoneNumber FROM Customers;`;

        db.pool.query(query1, function(error, rows, fields){    // Execute the query

            let orders = rows;

            db.pool.query(query2, function(error, rows, fields){
                let customers = rows;
                res.render('orders.hbs', {data: orders, customers: customers});
            })



                              // Render the index.hbs file, and also send the renderer
        })                                                      // an object where 'data' is equal to the 'rows' we
    });                                                         // received back from the query

app.post('/add-order-ajax', function(req, res) 
{
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;


    // Create the query and run it on the database
    query1 = `INSERT INTO Orders (customerID, dateOrdered, orderType) VALUES \
    ((SELECT Customers.customerID FROM Customers WHERE customerID = \
    '${data.customerID}'), '${data.dateOrdered}', '${data.orderType}')`

    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }
        else
        {
            // If there was no error, perform a SELECT * on bsg_people
            query2 = `SELECT orderID, Orders.customerID, Customers.fName,  Customers.lName, dateOrdered, orderType
            FROM Orders INNER JOIN Customers ON Orders.customerID = Customers.customerID;`;
            db.pool.query(query2, function(error, rows, fields){

                // Save customers
                let customers = rows

                // If there was an error on the second query, send a 400
                if (error) {
                    
                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else
                {
                    res.send(rows);
                }
            })
        }
    })
});

app.delete('/delete-order-ajax/', function(req,res,next){
    let data = req.body;
    let orderID = parseInt(data.id);
    let deleteOrder = `DELETE FROM Orders WHERE orderID = ?`;
  
  
          // Run the 1st query
          db.pool.query(deleteOrder, [orderID], function(error, rows, fields){
              if (error) {
  
              // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
              console.log(error);
              res.sendStatus(400);
              }
  
  })});


  app.put('/put-order-ajax', function(req,res,next){
    let data = req.body;
  
    let orderID = parseInt(data.orderID);
    let customerID = parseInt(data.fullname);
  
    let queryUpdateOrder = `UPDATE Orders SET customerID = (SELECT customerID FROM Customers WHERE customerID = ?), dateOrdered = ?, orderType = ? WHERE orderID = ?;`;
    let selectOrder = `SELECT * FROM Orders WHERE orderID = ?`
  
          // Run the 1st query
          db.pool.query(queryUpdateOrder, [customerID, dateOrdered, orderType], function(error, rows, fields){
              if (error) {
  
              // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
              console.log(error);
              res.sendStatus(400);
              }
  
              // If there was no error, we run our second query and return that data so we can use it to update the people's
              // table on the front-end
              else
              {
                  // Run the second query
                  db.pool.query(selectUpdateOrder, [customerID, dateOrdered, orderType], function(error, rows, fields) {
  
                      if (error) {
                          console.log(error);
                          res.sendStatus(400);
                      } else {
                          res.send(rows);
                      }
                  })
              }
  })});



/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
