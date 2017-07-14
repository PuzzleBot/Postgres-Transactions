create or replace function p4() returns void as $$
	declare
		c1 cursor for SELECT DISTINCT c.Account, Cname, Amount, Vname
					  FROM c, t, v
					  WHERE c.Account = t.Account
					  AND t.Vno = v.Vno
					  AND (T_Date >= ALL(SELECT T_Date
										 FROM t
										 WHERE c.Account = t.Account
										 )
						   OR 1 = (SELECT COUNT(*)
								   FROM t
								   WHERE c.Account = t.Account
								   )
						   );
		c2 cursor for SELECT DISTINCT c.Account, Cname
					  FROM c
					  WHERE 0 = (SELECT COUNT(*)
								 FROM t
								 WHERE c.Account = t.Account
								 );

		acc_num VARCHAR(5);
		cust_name VARCHAR(40);
		trans_amount DECIMAL(10,2);
		vend_name VARCHAR(40);
	begin
		open c1;
		raise notice 'Most recent transactions of each customer:';
		loop
			fetch c1 into acc_num, cust_name, trans_amount, vend_name;
			exit when not found;
			raise notice '    (%) Name: %, Vendor: %, Amount: %', acc_num, cust_name, vend_name, trans_amount;
		end loop;
		close c1;

		open c2;
		loop
			fetch c2 into acc_num, cust_name;
			exit when not found;
			raise notice '    (%) Name: %, no transaction', acc_num, cust_name;
		end loop;
		close c2;
	end;
$$ language plpgsql;