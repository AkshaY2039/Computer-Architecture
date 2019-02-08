/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Multiplier
	Module : D Flip Flop
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module diff(d, q, clk);

	input d, clk;
	output q;
	reg q;

	always@ (posedge clk)
	begin
		q <= d;
	end

endmodule // diff
