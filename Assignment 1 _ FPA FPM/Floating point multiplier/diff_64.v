/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Multiplier
	Module : 64b D Flip Flop
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module diff_64(d, q, clk);

	input [63:0]d;
	input clk;
	output [63:0]q;
	reg [63:0]q;

	always@ (posedge clk)
	begin
		q <= d;
	end

endmodule // diff_64