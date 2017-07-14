create or replace function p5() returns void as $$
	declare
		vend_number VARCHAR(5);
		amount_sum DECIMAL(10,2);

		vend_name VARCHAR(40);
		vend_balance DECIMAL(10,2);

		c1 cursor for SELECT Vno, SUM(Amount)
					  FROM t
					  GROUP BY Vno
					  HAVING COUNT(*) > 0;
		c2 cursor for SELECT Vno, Vname, Vbalance
					  FROM v
					  WHERE Vno = vend_number;

	begin
		open c1;
		loop
			fetch c1 into vend_number, amount_sum;
			exit when not found;

			UPDATE v SET Vbalance = Vbalance + amount_sum
				WHERE Vno = vend_number;
			raise notice 'Added % to the balance of vendor %.', amount_sum, vend_number;

			open c2;
			fetch c2 into vend_number, vend_name, vend_balance;
			raise notice 'Vno: %, Vendor: %, New balance: %', vend_number, vend_name, vend_balance;
			close c2;
		end loop;
		close c1;
	end;
$$ language plpgsql;