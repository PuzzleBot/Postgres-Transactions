create or replace function a3data() returns void as $$
	begin
		DROP TABLE v;
		CREATE TABLE v (Vno VARCHAR(5), Vname VARCHAR(40), City VARCHAR(40), Vbalance DECIMAL(10, 2));
		INSERT INTO v VALUES ('V1', 'Sears', 'Toronto', 200.00);
		INSERT INTO v VALUES ('V2', 'WalMart', 'Waterloo', 671.05);
		INSERT INTO v VALUES ('V3', 'Esso', 'Windsor', 0.00);
		INSERT INTO v VALUES ('V4', 'Esso', 'Waterloo', 225.00);

		DROP TABLE c;
		CREATE TABLE c (Account VARCHAR(5), Cname VARCHAR(40), Province VARCHAR(5), Cbalance DECIMAL(10,2), Crlimit INTEGER);
		INSERT INTO c VALUES ('A1', 'Smith', 'ONT', 2515.00, 2000);
		INSERT INTO c VALUES ('A2', 'Jones', 'BC', 2014.00, 2500);
		INSERT INTO c VALUES ('A3', 'Doc', 'ONT', 150.00, 1000);

		DROP TABLE t;
		CREATE TABLE t (Tno VARCHAR(5), Vno VARCHAR(5), Account VARCHAR(5), T_Date DATE, Amount DECIMAL(10,2));
		INSERT INTO t VALUES ('T1', 'V2', 'A1', '2015-07-15', 1325.00);
		INSERT INTO t VALUES ('T2', 'V2', 'A3', '2014-12-16', 1900.00);
		INSERT INTO t VALUES ('T3', 'V3', 'A1', '2015-09-01', 2500.00);
		INSERT INTO t VALUES ('T4', 'V4', 'A2', '2015-03-20', 1613.00);
		INSERT INTO t VALUES ('T5', 'V4', 'A3', '2015-07-31', 3312.00);
	end;
$$ language plpgsql;