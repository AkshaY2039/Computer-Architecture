/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Module : 2b Multiplexer
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module mux(i1, i0, s, out);

	input i0, i1, s;
	output out;
	wire out;

	assign out = (i0 & (~s)) | (i1 & s);

endmodule // mux