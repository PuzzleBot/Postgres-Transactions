create or replace function p2(vend_name VARCHAR(40)) returns void as $$
	declare
		c1 cursor for SELECT DISTINCT c.Account, Cname, Province
					  FROM c, t, v
					  WHERE Vname = vend_name
					  AND c.Account = t.Account
					  AND t.Vno = v.Vno;
		acc_num VARCHAR(5);
		cust_name VARCHAR(40);
		prov VARCHAR(5);
	begin
		open c1;
		raise notice 'Customers that have transactions with %:', vend_name;
		loop
			fetch c1 into acc_num, cust_name, prov;
			exit when not found;

			raise notice '    Account number: %', acc_num;
			raise notice '    Customer name: %', cust_name;
			raise notice '    Province: %', prov;
			raise notice ' ';
		end loop;
		close c1;
	end;
$$ language plpgsql;