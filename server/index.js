const express = require('express');
const app = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const bcrypt = require('bcrypt');
const saltRounds = 10;  // Used for bcrypt hashing
const session = require('express-session');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

// Body Parser middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:false}));
app.use(cookieParser());

// Express session
app.use(session({
  secret: 'asjf9238fja098f',
  resave: false,
  saveUninitialized: false,
  //cookie: { secure: true }
}));

// Passport init
app.use(passport.initialize());
app.use(passport.session());

// Passport creates user session
passport.serializeUser(function (userName, done) {
	done(null, userName);
});

passport.deserializeUser(function (userName, done) {	
	done(null, userName);
});

// Checks whether a user is logged in; redirects to home page if not.
function authenticationMiddleware() {
	return (req, res, next) => {
		console.log(`req.session.passport.user: ${JSON.stringify(req.session.passport)}`);
	    if (req.isAuthenticated()) return next();
	    res.redirect('/');
	}
}

// Impose MySQL connection pool
const pool = mysql.createPool({
	connectionLimit: 10,
	host     : 'localhost',
	user     : 'root',
	password : 'password',
	database : 'princedb' // database must already exist in MySQL
})

// Create connection
function getConnection() {
	return pool;
}

// Upon successful login, create local session in cookie
passport.use(new LocalStrategy(
	function(username, password, done) {
		const lQuery =	'Select password From User Where user_name = ?';
		getConnection().query(lQuery, [username], (err, results, fields) => {
			if(err) {done(err)};

			if (results.length === 0) {
				done(null, false);
			}

			// Compare plain text password to hashed password in database
			const hash = results[0].password.toString();
			bcrypt.compare(password, hash, (err, response) => {
				if (response === true) {
					return done(null, username);  // local cookie contains the username
				}
				return done(null, false);				
			});			
		});
	}
));

// Checks whether a user is a manager.
function checkManager() {
	return (req, res, next) => {
		const user = req.user;
		const typeQuery =	"Select type From User Where user_name = ?";
		getConnection().query(typeQuery, [user], (err, results, fields) => {
			if(err){
				console.log('Failed to query for user type: ' + err);
				res.redirect('/');
			}
			else if (results[0].type === 1) {
				console.log('User is a manager.');
				return next();
			}
			else if (results[0].type === 0) {
				console.log('User is an employee.');
				res.redirect('/employee');
			}
			else res.redirect('/');
		});
	}
}

app.listen('3000', () => {
    console.log('Server started on port 3000');
});

/* ROUTES */

// Home page
app.get('/', (req, res) => {
	res.sendFile('index.html', { root: './pages' });
	console.log('Home page sent.');
});

app.post('/login', passport.authenticate('local', {
	successRedirect: '/manager',
	failureRedirect: '/'
}));

// Add new user/password request
app.post('/register', (req, res, next) => {
	const nUser = req.body.newUser;
	const nPass = req.body.newPassword;

	const rQuery = 'Insert into User (user_name, password) Values (?, ?)';
	// Hash password using bcrypt then Insert
	bcrypt.hash(nPass, saltRounds, function(err, hash) {
		getConnection().query(rQuery, [nUser, hash], (err, results, fields) => {
			if (err) {
				console.log('Failed to execute Insert user query: ' + err);
				res.sendStatus(500);
				return;
			}
			console.log('User added: ' + nUser);
			// Log in user as an employee after successful registration
			req.login(nUser, function(err){
				if (err) {
					console.log('Failed to log in user: ' + err);
					res.sendStatus(500);
					return;
				}
				res.redirect('/employee'); // New user will always be a basic employee (non-manager)
			});			
		});
	});
});

/* Employee Routes */

// Employee user page
app.get('/employee', authenticationMiddleware(), (req, res) => {
	res.sendFile('employee.html', { root: './pages' });
	console.log('Employee page sent.');
});

//Inserts customer info
app.post('/insert_customer', authenticationMiddleware(), (req, res) => {
	const customerId = req.body.create_customer_id;
	const customerFname = req.body.create_customer_fname;
	const customerLname = req.body.create_customer_lname;
	const customerAddress = req.body.create_customer_address;

	const aQuery = 	'Insert into customer (C_id, Fname, Lname, Address) Values (?, ?, ?, ?)';

	getConnection().query(aQuery, [customerId, customerFname, customerLname, customerAddress], (err, results, fields) => {
		if (err) {
			console.log('Failed to execute Insert query: ' + err);
			res.sendStatus(500);
			return;
		}
		console.log('Inserted a new customer.');
		res.end();
	});	
});

/* 
	Show a list of products, their barcodes, and their aisles
*/
app.get('/product_aisles', authenticationMiddleware(), (req, res) => {
	const paQuery =	'SELECT product.Name As Product, Barcode, aisle.Name As Aisle '
				+	'FROM aisle, product '
				+	'where aisle.A_id = product.Aisle_id';
	getConnection().query(paQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for products.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Product aisle info fetched.');
	});
});

/* 
 * Query: Given a product name, fetch the names of employees who stock
 * the aisles that contain them, the aisle names, and quantity of the product
 */
app.get('/stock_info/:product', authenticationMiddleware(), (req, res) => {
	const pName = req.params.product;
	const pQuery =	'Select Fname as Employee, Lname as Name, '
				+	'Aisle.Name as Aisle, count(Product.Name) As Count '
				+	'From Employee, Aisle, Product, Stocks '
				+	'Where SSN = Essn And A_id = Stocks.Aisle_id '
					+	'And Product.Aisle_id = A_id '
					+	'And Product.Name = ? '
				+	'Group By Lname';
	getConnection().query(pQuery, [pName], (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for employees.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Product stocking info fetched.');
	});
});

/*
 * Given a date, show transactions that occured on that day.
 * Fetch customer's name, customer id, the transaction id, and the name
 * of the employee who handled the transaction. 
 */
app.get('/transactions_on_date/:date', authenticationMiddleware(), (req, res) => {
	const tDate = req.params.date;
	const tQuery =	'Select customer.fname as Customer, customer.lname as Name, '
					+	'transaction.c_id as Account, t_id as Transaction, '
					+	'employee.fname as Employee, employee.lname as Name '
				+	'From transaction, employee, customer '
				+	'Where essn = ssn And transaction.c_id = customer.c_id '
					+	'And date = ?';
	getConnection().query(tQuery, [tDate], (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for transactions.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Transactions fetched.');		
	});	
});

/*
 * Get the names of employees that handled transactions, the transaction id, and transaction date.
 */
app.get('/employee_transactions', authenticationMiddleware(), (req, res) => {
	const etQuery =	'Select Fname as Employee, Lname as Name, '
				+	'T_id as Transaction, Date '
				+	'From Employee, Transaction '
				+	'Where Ssn = Essn';
	getConnection().query(etQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for employee transactions.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Employee and transaction info fetched.');
	});	
});

/*
 * Get a basic transaction history, showing date, transaction id, and customer id for each record.
 */
app.get('/customer_transactions', authenticationMiddleware(), (req, res) => {
	const ctQuery =	'Select Date,  T_id as Transaction, C_id as Customer '
				+	'From Customer Natural Join Transaction';
	getConnection().query(ctQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for customer transactions.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Customer transactions info fetched.');
	});	
});

/*
 * Get transaction count for each day.
 */
app.get('/transactions_per_day', authenticationMiddleware(), (req, res) => {
		const tdQuery =	'SELECT Date, COUNT(t_id) As Count '
					+	'FROM Transaction '
					+	'GROUP BY date;';
	getConnection().query(tdQuery, (err, rows, fields) => {
		if (err) {
			console.log("Failed to query for transaction info.");
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Transaction info fetched.');
	});
});

/* Manager Exclusive Routes */

// Manager user page
app.get('/manager', authenticationMiddleware(), checkManager(), (req, res) => {
	res.sendFile('manager.html', { root: './pages' });
	console.log('Manager page sent.')
});

// Inserts a new aisle, and its unique id is auto-incremented in database
app.post('/insert_aisle', authenticationMiddleware(), checkManager(), (req, res) => {
	const itemName = req.body.create_aisle_item;
	const aQuery = 	'Insert into aisle (Name) Values (?)';
	getConnection().query(aQuery, [itemName], (err, results, fields) => {
		if (err) {
			console.log('Failed to execute Insert query: ' + err);
			res.sendStatus(500);
			return;
		}
		console.log('Inserted a new aisle.');
		res.end();
	});
});

/*
 * Given a manager's name, fetch the names of aisles that their subordinates stock,
 * and the names of the employee that stocks the aisle.
 */
app.get('/manager_aisle/:fname/:lname', authenticationMiddleware(), checkManager(), (req, res) => {
	const fName = req.params.fname;
	const lName = req.params.lname;
	const mQuery =	'Select Name as Aisle, E.Fname As Employee, E.Lname As Name '
				+	'From Employee E, Employee S, Aisle, Stocks '
				+	'Where E.Ssn = Essn And A_id = Aisle_id '
					+	'And E.Super_ssn = S.Ssn And S.Fname = ? '
    				+	'And S.Lname = ?';
	getConnection().query(mQuery, [fName, lName], (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for aisles.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Manager aisle info fetched.');				
	});
});

/*
 * Get the names of employees that stock aisles and the corresponding aisle name.
 */
app.get('/employee_stocks', authenticationMiddleware(), checkManager(), (req, res) => {
	const sQuery =	'Select Fname as Employee, Lname as Name, Name as Aisle '
				+	'From Employee, Stocks, Aisle '
				+	'Where Ssn = Essn And Aisle_id = A_id';
	getConnection().query(sQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for aisles.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Employee and aisle info fetched.');
	});	
});

/*
 * Get aggregate data about Employee wages.
 */
app.get('/wage_info', authenticationMiddleware(), checkManager(), (req, res) => {
		const iQuery =	'Select COUNT(*) as Count, MAX(wage) as Maximum, '
						+	'MIN(wage) as Minimum, AVG(wage) as Average '
					+ 	'From Employee';
	getConnection().query(iQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for employee wages.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Employee wage info fetched.');
	});	
});

/*
 * Get a supplier count.
 */
app.get('/supplier_count', authenticationMiddleware(), checkManager(), (req, res) => {
	const sQuery =	'SELECT COUNT(s_id) as Count '
				+	'FROM Supplier;';
	getConnection().query(sQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for supplier info.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Supplier info fetched.');
	});	
});

/*
	Show all employees that order from suppliers and the suppliers they ordered from.
*/
app.get('/orders_from', authenticationMiddleware(), checkManager(), (req, res) => {
	const oQuery =	'SELECT Fname As Employee, Lname as Name, name As Supplier '
				+	'FROM  employee , orders_from, supplier '
				+	'where ssn	= Essn and S_id = supplier_id';
	getConnection().query(oQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for Employees who ordered from suppliers.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Employee order info fetched.');
	});
});

/*
	Show products, barcodes, and quantity shipped from suppliers.
*/
app.get('/supplier_shipped', authenticationMiddleware(), checkManager(), (req, res) => {
	const ssQuery =	'SELECT product.Name As Product, Product_barcode As Barcode, '
				+		'Quantity_shipped as Shipped, supplier.name As Supplier '
				+	'FROM product, supplier, supplies '
				+	'where product.Barcode = supplies.Product_barcode and '
				+		'supplies.Supplier_id = supplier.S_id '
				+	'group by product.Name';
	getConnection().query(ssQuery, (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for supplier info.');
			res.sendStatus(500);
			res.end();
			return;
		}
		res.send(rows);  // Sends rows to client as a JSON string
		console.log('Supplier info fetched.');
	});
});

/*
	Given a username, change the user's type in database to a manager.
*/
app.get('/promote_user/:username', authenticationMiddleware(), checkManager(), (req, res) => {
	const userName = req.params.username;
	const checkQuery =	'Select * From User Where user_name = ?';
	const updateQuery =	'Update User Set type = 1 Where user_name = ?';
	// Check to see if user exists before updating.
	getConnection().query(checkQuery, [userName], (err, rows, fields) => {
		if (err) {
			console.log('Failed to query for user.');
			res.sendStatus(500);
			res.end();
			return;
		}
		if (rows.length === 0) {
			console.log('Could not find user.');
			res.sendStatus(500);
			res.end();
			return;
		}
		// If a user is found, make another query to update.
		getConnection().query(updateQuery, [userName], (err, rows, fields) => {
			if (err) {
				console.log('Failed to change user type to manager: ' + err);
				res.sendStatus(500);
				return;
			}
			console.log('Changed user type to manager.');
			res.end();
		});
	});
});