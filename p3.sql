create or replace function p3(acc_num VARCHAR(5), cust_name VARCHAR(40), prov VARCHAR(5), cred_limit INTEGER) returns void as $$
	declare
		c1 cursor for SELECT *
					  FROM c;
		outAcc_num VARCHAR(5);
		outCust_name VARCHAR(40);
		outProv VARCHAR(5);
		outCust_balance DECIMAL(10,2); 
		outCred_limit INTEGER;
	begin
		INSERT INTO c VALUES (acc_num, cust_name, prov, 0.0, cred_limit);
		raise notice 'Account % for % has been inserted.', acc_num, cust_name;
		open c1;
		raise notice 'All customer records:';
		loop
			fetch c1 into outAcc_num, outCust_name, outProv, outCust_balance, outCred_limit;
			exit when not found;
			raise notice '    Account: %, Cname: %, Province: %, Cbalance: %, Crlimit: %', outAcc_num, outCust_name, outProv, outCust_balance, outCred_limit;
		end loop;
		close c1;
	end;
$$ language plpgsql;