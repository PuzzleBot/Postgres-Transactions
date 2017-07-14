create or replace function p8(trans_num VARCHAR(5), vend_num VARCHAR(5), acc_num VARCHAR(5), trans_amount DECIMAL(10,2)) returns void as $$
	declare
		c1 cursor for SELECT CURRENT_DATE;
		trans_date DATE;

		c2 cursor for SELECT *
					  FROM v
					  WHERE v.Vno = vend_num;

		c3 cursor for SELECT *
					  FROM c
					  WHERE c.Account = acc_num;

		out_Vno VARCHAR(5);
		out_Vname VARCHAR(40);
		out_City VARCHAR(40);
		out_Vbalance DECIMAL(10,2);

		out_Account VARCHAR(5);
		out_Cname VARCHAR(40);
		out_Province VARCHAR(5);
		out_Cbalance DECIMAL(10,2);
		out_Crlimit INTEGER;

	begin
		open c1;
		fetch c1 into trans_date;
		close c1;

		raise notice 'Adding new transaction...';
		INSERT INTO t VALUES (trans_num, vend_num, acc_num, trans_date, trans_amount);

		raise notice 'Transaction added:';
		raise notice 'TransNum %: Account % to Vendor % on %, Amount: %', trans_num, acc_num, vend_num, trans_date, trans_amount;
		raise notice ' ';

		-- Vbalance is presumed to be the amount of money granted by the credit agency.
		-- It is increased when a customer makes a transaction.
		UPDATE v SET Vbalance = Vbalance + trans_amount
			WHERE v.Vno = vend_num;

		-- Cbalance is presumed to be the amount of money the customer owes to the credit agency.
		-- It is increased when a customer makes a transaction.
		UPDATE c SET Cbalance = Cbalance + trans_amount
			WHERE c.Account = acc_num;

		open c2;
		open c3;
		fetch c2 into out_Vno, out_Vname, out_City, out_Vbalance;
		fetch c3 into out_Account, out_Cname, out_Province, out_Cbalance, out_Crlimit;

		raise notice 'Updated records:';
		raise notice '(Vendor %) Name: %, City: %, Balance: %', out_Vno, out_Vname, out_City, out_Vbalance;
		raise notice '(Account %) Name: %, Province: %, Balance: %, Limit: %', out_Account, out_Cname, out_Province, out_Cbalance, out_Crlimit;

		close c2;
		close c3;

	end;
$$ language plpgsql;