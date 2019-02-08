/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Multiplier
	Module : 32b Floating Point Multiplier
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module floating_multi(a, b, finalo, clk);

	input [31:0]a, b;
	input clk;
	wire [63:0]man;
	wire [31:0]pos;
	wire [63:0]mant;
	wire sign;
	output [31:0]finalo;

	wire [31:0]e1, e2, m1, m2, exp1, exp;
	wire cout1, cout2;

	assign e1[7:0] = a[30:23];
	assign e2[7:0] = b[30:23];
	assign e1[31:8] = 24'b0;
	assign e2[31:8] = 24'b0;

	assign m1[22:0] = a[22:0];
	assign m2[22:0] = b[22:0];
	assign m1[23] = 1'b1;
	assign m2[23] = 1'b1;
	assign m1[31:24] = 9'b0;
	assign m2[31:24] = 9'b0;

	assign sign = ((~a[31] & b[31]) || (~b[31] & a[31]));

	multiplier ml1(m1, m2, man, clk);

	pipeline_prefix32 lm1(e1, e2, 1'b0, exp1, cout1, clk, 32'd0);
	pipeline_prefix32 lm2(exp1, 32'd127, 1'b1, exp, cout2, clk, 32'b11111111111111111111111111111111);

	detectone64 d2(man, mant, pos[7:0], clk); 
	assign pos[31:8] = 24'd0;

	assign finalo[31] = sign;
	assign finalo[30:23] = exp[7:0];
	assign finalo[22:0] = mant[63:41];

endmodule // floating_multi

//already normalised
//we are considering the implicit one for multiplication
//size has to be reduced to 1 8 23

//man is the final mantissa
//exp is the final exponent
//sign is finalo sign