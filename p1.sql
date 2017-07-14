create or replace function p1(cust_name VARCHAR(40)) returns void as $$
	declare
		c1 cursor for SELECT DISTINCT Vname, T_Date, Amount
					  FROM c, t, v
					  WHERE Cname = cust_name
					  AND c.Account = t.Account
					  AND t.Vno = v.Vno;
		vend_name VARCHAR(40);
		trans_date DATE;
		trans_amount DECIMAL(10,2);
	begin
		open c1;
		raise notice 'Transaction info for %:', cust_name;
		loop
			fetch c1 into vend_name, trans_date, trans_amount;
			exit when not found;

			raise notice '    Vendor name: %', vend_name;
			raise notice '    Date: %', trans_date;
			raise notice '    Amount: %', trans_amount;
			raise notice ' ';
		end loop;
		close c1;
	end;
$$ language plpgsql;