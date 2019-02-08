/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Multiplier
	Module : Dot Block for Prefix Adder
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module predot(g, a, cin, cout);

	input g, a, cin;
	output cout;

	assign cout = g | a & cin;

endmodule // predot  