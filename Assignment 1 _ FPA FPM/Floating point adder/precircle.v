/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Module : Circle Block for Prefix Adder
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module precircle(gl, al, gr, ar, gout, aout);

	input gl, al, gr, ar;
	output gout, aout;

	assign gout = gl | al & gr;
	assign aout = al & ar;

endmodule // precircle