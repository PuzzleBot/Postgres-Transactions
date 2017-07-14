create or replace function p7() returns void as $$
	declare
		c1 cursor for SELECT Account, Cname, Cbalance, Crlimit
					  FROM c;
		acc_num VARCHAR(5);
		cust_name VARCHAR(40);
		cust_balance DECIMAL(10,2);
		credit_limit INTEGER;
		fee DECIMAL(10,2);

		c2 cursor for SELECT Cbalance
					  FROM c
					  WHERE c.Account = acc_num;

		new_balance DECIMAL(10,2);
	begin
		open c1;
		raise notice 'Charging 10 percent fee to customers exceeding the limit:';
		loop
			fetch c1 into acc_num, cust_name, cust_balance, credit_limit;
			exit when not found;

			if cust_balance > credit_limit then
				fee := (cust_balance - credit_limit) * 0.1;
				UPDATE c SET Cbalance = Cbalance + fee
					WHERE c.Account = acc_num;
				raise notice '    Added % to the balance of %', fee, acc_num;

				open c2;
				fetch c2 into new_balance;
				raise notice '    Balance for %: %', cust_name, new_balance;
				close c2;
			end if;
		end loop;
		close c1;
	end;
$$ language plpgsql;