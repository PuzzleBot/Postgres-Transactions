# Postgres-Transactions
This repository contains work which was for an assignment in my Databases class (2015). The programs here are "transactions" (a series of simple operations and database queries) which a hypothetical credit card company may have.

## Running the PostgreSQL programs
To run the programs, you must first have a PostgreSQL Database ready and running. Once that is done, connect to the database using the terminal (ie. SSH into wherever the database is running, then use "psql").

First, run a3data.sql to create and initialize the tables. Afterwards, any of the other files may be run.

To a run a file, use these commands within the shell you are provided when you connect to the database using psql:

\i \<filename.sql\>
select \<filename\>();

The first command creates the function in the shell which I have defined in the code file. The second command executes the function defined in the shell. 

## What am I looking at here?

First, allow me to explain what the tables are and what their values mean:

* v - A table containing vendor (company) information and money owed to them.
* c - A table containing customer information, including their contact information, credit used, and credit limit.
* t - Transaction information. This table records money transfers between vendors and customers.

Now, for the table values:

* Vno - a unique primary key code used for joining tables.
* Vname - company name.
* City - the company's location.
* Vbalance - how much money has been transferred to the company.

* Account - a unique primary key code used for joining tables.
* Cname - the customer's name.
* Province - the customer's home province.
* Cbalance - the amount of money owed to the credit card company by the customer.
* Crlimit - the maximum amount of credit the customer may use.

* Tno - a unique primary key code for identifying transactions.
* Vno - a foreign key for linking a transaction back to the vendor in the v table.
* Account - a foreign key for linking a transaction back to the customer in the c table.
* T_date - the date the transaction occurred.
* Amount - the amount of money transferred.


## What do the functions do?
The functions are typical database functions which a hypothetical credit card company would probably have. (They are named this way because the professor explicity wanted it named that way) They do the following:

* a3data(): Creates and initializes the tables.
* p1(\<customer name\>): Displays the information of the customer(s) with the given name.
* p2(\<vendor name\>): Displays the information of all customers who have a transaction with the vendors that have the given name.
* p3(\<account number\>, \<customer name\>, \<province\>, \<credit limit\>): Creates a new customer account with the given information and a credit owing of 0, then displays the information of all customers.
* p4(): Displays the most recent transaction of each customer. This also considers customers with no transactions and explicitly points out that there are none.
* p5(): Updates each vendor's balance by adding the amounts from each transaction to them to their balance. Afterwards, it displays each vendor's primary key code with their old and new balances.
* p6(): Charges a 4% transaction fee to all vendors, deducting from their balances. Then, it displays each vendor's primary key code with their old and new balances.
* p7(): Charges a 10% overcharge fee to all customers who have exceeded their credit limits by adding to their amount owed. Afterwards, it displays each customers primary key code with their old and new balances.
* p8(\<transaction number\>, \<vendor number\>, \<account number\>, \<transaction amount\>): Adds a new transaction and processes it, updating involved vendors and customers. Afterwards, it shows the information of all affected vendors and customers.