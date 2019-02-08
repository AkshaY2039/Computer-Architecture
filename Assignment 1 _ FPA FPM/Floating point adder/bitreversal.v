/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Module : 32b Bit Reversal
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module bitreversal(x, s, c);

	input [31:0]x;
	input s;
	output [31:0]c;

	mux o1(x[31], x[0], s, c[0]);
	mux o2(x[30], x[1], s, c[1]);
	mux o3(x[29], x[2], s, c[2]);
	mux o4(x[28], x[3], s, c[3]);
	mux o5(x[27], x[4], s, c[4]);
	mux o6(x[26], x[5], s, c[5]);
	mux o7(x[25], x[6], s, c[6]);
	mux o8(x[24], x[7], s, c[7]);
	mux o9(x[23], x[8], s, c[8]);
	mux o10(x[22], x[9], s, c[9]);
	mux o11(x[21], x[10], s, c[10]);
	mux o12(x[20], x[11], s, c[11]);
	mux o13(x[19], x[12], s, c[12]);
	mux o14(x[18], x[13], s, c[13]);
	mux o15(x[17], x[14], s, c[14]);
	mux o16(x[16], x[15], s, c[15]);
	mux o17(x[15], x[16], s, c[16]);
	mux o18(x[14], x[17], s, c[17]);
	mux o19(x[13], x[18], s, c[18]);
	mux o20(x[12], x[19], s, c[19]);
	mux o21(x[11], x[20], s, c[20]);
	mux o22(x[10], x[21], s, c[21]);
	mux o23(x[9], x[22], s, c[22]);
	mux o24(x[8], x[23], s, c[23]);
	mux o25(x[7], x[24], s, c[24]);
	mux o26(x[6], x[25], s, c[25]);
	mux o27(x[5], x[26], s, c[26]);
	mux o28(x[4], x[27], s, c[27]);
	mux o29(x[3], x[28], s, c[28]);
	mux o30(x[2], x[29], s, c[29]);
	mux o31(x[1], x[30], s, c[30]);
	mux o32(x[0], x[31], s, c[31]);

endmodule // bitreversal