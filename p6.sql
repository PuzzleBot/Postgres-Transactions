create or replace function p6() returns void as $$
	declare
		c1 cursor for SELECT Vno, Vbalance
					  FROM v;

		vend_num VARCHAR(5);
		vend_balance DECIMAL(10,2);
		fee DECIMAL(10,2);

		c2 cursor for SELECT Vbalance
					  FROM v
					  WHERE v.Vno = vend_num;

		vend_newBalance DECIMAL(10,2);
	begin
		raise notice 'Charging 4 percent fee to all vendors...';
		open c1;
		loop
			fetch c1 into vend_num, vend_balance;
			exit when not found;
			fee := vend_balance * 0.04;
			UPDATE v SET Vbalance = Vbalance - fee
				WHERE Vno = vend_num;

			open c2;
			fetch c2 into vend_newBalance;
			raise notice '    Vno %: Charged %, Balance: %', vend_num, fee, vend_newBalance;
			close c2;
		end loop;
		close c1;
	end;
$$ language plpgsql;