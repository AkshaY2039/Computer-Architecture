/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Module : 32b Floating Point Adder
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module floating_adder(a,b,finalo,clk, coutx);

	input [31:0]a, b;
	input clk;
	output [31:0]finalo; //finalo is final output
	output coutx;

	wire cout0, sign, cout;
	wire [31:0]exp;
	wire [31:0]s0, s1, s2, s3, q, q1, s5, s4, s;
	wire fout, fout1, fout2, fout3, fout4, fout5, flag, out1, out2;
	wire [31:0]e1, e2, m1, m2, w3, w1, w2, out, f1, f2, fex, n1, n2, sout, sout1, sout2, sout3, n3, n4,n5, n6, fexpo, fs;
	wire [31:0]pos, pos1;

	assign e1[7:0] = a[30:23]; //exponent of a
	assign e2[7:0] = b[30:23]; //exponent of b
	assign e1[31:8] = 24'b0;
	assign e2[31:8] = 24'b0;

	assign m1[22:0] = a[22:0]; //mantissa of a
	assign m2[22:0] = b[22:0]; //mantissa of b
	assign m1[23] = 1'b1;
	assign m2[23] = 1'b1;
	assign m1[31:24] = 9'b0;
	assign m2[31:24] = 9'b0;

	//to find which exponent is greater we do 2's complement subtraction
	pipeline_prefix32 lo1(e1, e2, 1'b1, s4, cout0, clk, 32'b11111111111111111111111111111111); //e1 - e2  (2's complement subtraction)
	pipeline_prefix32 lo5(e2, e1, 1'b1, s5, cout1, clk, 32'b11111111111111111111111111111111); //e2 - e1
	assign cout = cout0; 

	//when e1 > e2 cout0 == 1
	//when e2 > e1 cout1 == 0

	//finding which mantissa is greater, to decide which value has to be subtracted from which value.
	pipeline_prefix32 lo6(m1, m2, 1'b1, s, fout1, clk, 32'b11111111111111111111111111111111); //m1 - m2
	pipeline_prefix32 lo7(m2, m1, 1'b1, s, fout2, clk, 32'b11111111111111111111111111111111); //m2 - m1
	//when m1 > m2 fout1 == 1
	//when m2 > m1 fout2 == 1

	assign sign = a[31] & fout1 | b[31] & fout2;

	//which ever has carry output as 1, that 2's complements output should be taken
	assign s0[0] = ( s4[0] & cout0 | s5[0] & (cout1) );
	assign s0[1] = ( s4[1] & cout0 | s5[1] & (cout1) );
	assign s0[2] = ( s4[2] & cout0 | s5[2] & (cout1) );
	assign s0[3] = ( s4[3] & cout0 | s5[3] & (cout1) );
	assign s0[4] = ( s4[4] & cout0 | s5[4] & (cout1) );
	assign s0[5] = ( s4[5] & cout0 | s5[5] & (cout1) );
	assign s0[6] = ( s4[6] & cout0 | s5[6] & (cout1) );
	assign s0[7] = ( s4[7] & cout0 | s5[7] & (cout1) );
	assign s0[8] = ( s4[8] & cout0 | s5[8] & (cout1) );
	assign s0[9] = ( s4[9] & cout0 | s5[9] & (cout1) );
	assign s0[10] = ( s4[10] & cout0 | s5[10] & (cout1) );
	assign s0[11] = ( s4[11] & cout0 | s5[11] & (cout1) );
	assign s0[12] = ( s4[12] & cout0 | s5[12] & (cout1) );
	assign s0[13] = ( s4[13] & cout0 | s5[13] & (cout1) );
	assign s0[14] = ( s4[14] & cout0 | s5[14] & (cout1) );
	assign s0[15] = ( s4[15] & cout0 | s5[15] & (cout1) );
	assign s0[16] = ( s4[16] & cout0 | s5[16] & (cout1) );
	assign s0[17] = ( s4[17] & cout0 | s5[17] & (cout1) );
	assign s0[18] = ( s4[18] & cout0 | s5[18] & (cout1) );
	assign s0[19] = ( s4[19] & cout0 | s5[19] & (cout1) );
	assign s0[20] = ( s4[20] & cout0 | s5[20] & (cout1) );
	assign s0[21] = ( s4[21] & cout0 | s5[21] & (cout1) );
	assign s0[22] = ( s4[22] & cout0 | s5[22] & (cout1) );
	assign s0[23] = ( s4[23] & cout0 | s5[23] & (cout1) );
	assign s0[24] = ( s4[24] & cout0 | s5[24] & (cout1) );
	assign s0[25] = ( s4[25] & cout0 | s5[25] & (cout1) );
	assign s0[26] = ( s4[26] & cout0 | s5[26] & (cout1) );
	assign s0[27] = ( s4[27] & cout0 | s5[27] & (cout1) );
	assign s0[28] = ( s4[28] & cout0 | s5[28] & (cout1) );
	assign s0[29] = ( s4[29] & cout0 | s5[29] & (cout1) );
	assign s0[30] = ( s4[30] & cout0 | s5[30] & (cout1) );
	assign s0[31] = ( s4[31] & cout0 | s5[31] & (cout1) );

	//selecting the larger expoenent's mantissa into q to shift it because
	//we are decreasing the larger exponent to the smaller expoenent
	assign q[0] = ( m1[0] & cout | m2[0] & (~cout) );
	assign q[1] = ( m1[1] & cout | m2[1] & (~cout) );
	assign q[2] = ( m1[2] & cout | m2[2] & (~cout) );
	assign q[3] = ( m1[3] & cout | m2[3] & (~cout) );
	assign q[4] = ( m1[4] & cout | m2[4] & (~cout) );
	assign q[5] = ( m1[5] & cout | m2[5] & (~cout) );
	assign q[6] = ( m1[6] & cout | m2[6] & (~cout) );
	assign q[7] = ( m1[7] & cout | m2[7] & (~cout) );
	assign q[8] = ( m1[8] & cout | m2[8] & (~cout) );
	assign q[9] = ( m1[9] & cout | m2[9] & (~cout) );
	assign q[10] = ( m1[10] & cout | m2[10] & (~cout) );
	assign q[11] = ( m1[11] & cout | m2[11] & (~cout) );
	assign q[12] = ( m1[12] & cout | m2[12] & (~cout) );
	assign q[13] = ( m1[13] & cout | m2[13] & (~cout) );
	assign q[14] = ( m1[14] & cout | m2[14] & (~cout) );
	assign q[15] = ( m1[15] & cout | m2[15] & (~cout) );
	assign q[16] = ( m1[16] & cout | m2[16] & (~cout) );
	assign q[17] = ( m1[17] & cout | m2[17] & (~cout) );
	assign q[18] = ( m1[18] & cout | m2[18] & (~cout) );
	assign q[19] = ( m1[19] & cout | m2[19] & (~cout) );
	assign q[20] = ( m1[20] & cout | m2[20] & (~cout) );
	assign q[21] = ( m1[21] & cout | m2[21] & (~cout) );
	assign q[22] = ( m1[22] & cout | m2[22] & (~cout) );
	assign q[23] = ( m1[23] & cout | m2[23] & (~cout) );
	assign q[24] = ( m1[24] & cout | m2[24] & (~cout) );
	assign q[25] = ( m1[25] & cout | m2[25] & (~cout) );
	assign q[26] = ( m1[26] & cout | m2[26] & (~cout) );
	assign q[27] = ( m1[27] & cout | m2[27] & (~cout) );
	assign q[28] = ( m1[28] & cout | m2[28] & (~cout) );
	assign q[29] = ( m1[29] & cout | m2[29] & (~cout) );
	assign q[30] = ( m1[30] & cout | m2[30] & (~cout) );
	assign q[31] = ( m1[31] & cout | m2[31] & (~cout) );

	// to left shift the selected mantissa; left because we are decreasing the value of the exponent
	bitreversal bl2(q, 1'b1, w1);
	right_shifter sh1(w1, s0[4:0], w2, clk); /////out[4:0]
	bitreversal bl1(w2, 1'b1, w3);

	//taking the values of the final mantissa's and exponent into f1, f2, fexp
	//assign f1 = (m1 & ~cout | w3 & (cout));   //maybe we have to expand and write
	assign f1[0] = ( m1[0] & (~cout) | w3[0] & (cout) );
	assign f1[1] = ( m1[1] & (~cout) | w3[1] & (cout) );
	assign f1[2] = ( m1[2] & (~cout) | w3[2] & (cout) );
	assign f1[3] = ( m1[3] & (~cout) | w3[3] & (cout) );
	assign f1[4] = ( m1[4] & (~cout) | w3[4] & (cout) );
	assign f1[5] = ( m1[5] & (~cout) | w3[5] & (cout) );
	assign f1[6] = ( m1[6] & (~cout) | w3[6] & (cout) );
	assign f1[7] = ( m1[7] & (~cout) | w3[7] & (cout) );
	assign f1[8] = ( m1[8] & (~cout) | w3[8] & (cout) );
	assign f1[9] = ( m1[9] & (~cout) | w3[9] & (cout) );
	assign f1[10] = ( m1[10] & (~cout) | w3[10] & (cout) );
	assign f1[11] = ( m1[11] & (~cout) | w3[11] & (cout) );
	assign f1[12] = ( m1[12] & (~cout) | w3[12] & (cout) );
	assign f1[13] = ( m1[13] & (~cout) | w3[13] & (cout) );
	assign f1[14] = ( m1[14] & (~cout) | w3[14] & (cout) );
	assign f1[15] = ( m1[15] & (~cout) | w3[15] & (cout) );
	assign f1[16] = ( m1[16] & (~cout) | w3[16] & (cout) );
	assign f1[17] = ( m1[17] & (~cout) | w3[17] & (cout) );
	assign f1[18] = ( m1[18] & (~cout) | w3[18] & (cout) );
	assign f1[19] = ( m1[19] & (~cout) | w3[19] & (cout) );
	assign f1[20] = ( m1[20] & (~cout) | w3[20] & (cout) );
	assign f1[21] = ( m1[21] & (~cout) | w3[21] & (cout) );
	assign f1[22] = ( m1[22] & (~cout) | w3[22] & (cout) );
	assign f1[23] = ( m1[23] & (~cout) | w3[23] & (cout) );
	assign f1[24] = ( m1[24] & (~cout) | w3[24] & (cout) );
	assign f1[25] = ( m1[25] & (~cout) | w3[25] & (cout) );
	assign f1[26] = ( m1[26] & (~cout) | w3[26] & (cout) );
	assign f1[27] = ( m1[27] & (~cout) | w3[27] & (cout) );
	assign f1[28] = ( m1[28] & (~cout) | w3[28] & (cout) );
	assign f1[29] = ( m1[29] & (~cout) | w3[29] & (cout) );
	assign f1[30] = ( m1[30] & (~cout) | w3[30] & (cout) );
	assign f1[31] = ( m1[31] & (~cout) | w3[31] & (cout) );

	//assign f2 = (m2 & (cout) | w3 & (~cout));   //maybe we have to expand and write
	assign f2[0] = ( m2[0] & (cout) | w3[0] & (~cout) );
	assign f2[1] = ( m2[1] & (cout) | w3[1] & (~cout) );
	assign f2[2] = ( m2[2] & (cout) | w3[2] & (~cout) );
	assign f2[3] = ( m2[3] & (cout) | w3[3] & (~cout) );
	assign f2[4] = ( m2[4] & (cout) | w3[4] & (~cout) );
	assign f2[5] = ( m2[5] & (cout) | w3[5] & (~cout) );
	assign f2[6] = ( m2[6] & (cout) | w3[6] & (~cout) );
	assign f2[7] = ( m2[7] & (cout) | w3[7] & (~cout) );
	assign f2[8] = ( m2[8] & (cout) | w3[8] & (~cout) );
	assign f2[9] = ( m2[9] & (cout) | w3[9] & (~cout) );
	assign f2[10] = ( m2[10] & (cout) | w3[10] & (~cout) );
	assign f2[11] = ( m2[11] & (cout) | w3[11] & (~cout) );
	assign f2[12] = ( m2[12] & (cout) | w3[12] & (~cout) );
	assign f2[13] = ( m2[13] & (cout) | w3[13] & (~cout) );
	assign f2[14] = ( m2[14] & (cout) | w3[14] & (~cout) );
	assign f2[15] = ( m2[15] & (cout) | w3[15] & (~cout) );
	assign f2[16] = ( m2[16] & (cout) | w3[16] & (~cout) );
	assign f2[17] = ( m2[17] & (cout) | w3[17] & (~cout) );
	assign f2[18] = ( m2[18] & (cout) | w3[18] & (~cout) );
	assign f2[19] = ( m2[19] & (cout) | w3[19] & (~cout) );
	assign f2[20] = ( m2[20] & (cout) | w3[20] & (~cout) );
	assign f2[21] = ( m2[21] & (cout) | w3[21] & (~cout) );
	assign f2[22] = ( m2[22] & (cout) | w3[22] & (~cout) );
	assign f2[23] = ( m2[23] & (cout) | w3[23] & (~cout) );
	assign f2[24] = ( m2[24] & (cout) | w3[24] & (~cout) );
	assign f2[25] = ( m2[25] & (cout) | w3[25] & (~cout) );
	assign f2[26] = ( m2[26] & (cout) | w3[26] & (~cout) );
	assign f2[27] = ( m2[27] & (cout) | w3[27] & (~cout) );
	assign f2[28] = ( m2[28] & (cout) | w3[28] & (~cout) );
	assign f2[29] = ( m2[29] & (cout) | w3[29] & (~cout) );
	assign f2[30] = ( m2[30] & (cout) | w3[30] & (~cout) );
	assign f2[31] = ( m2[31] & (cout) | w3[31] & (~cout) );

	//assign fex = (e1 & (~cout) | e2 & cout);     //maybe we have to expand and write
	assign fex[0] = ( e1[0] & (~cout) | e2[0] & (cout) );
	assign fex[1] = ( e1[1] & (~cout) | e2[1] & (cout) );
	assign fex[2] = ( e1[2] & (~cout) | e2[2] & (cout) );
	assign fex[3] = ( e1[3] & (~cout) | e2[3] & (cout) );
	assign fex[4] = ( e1[4] & (~cout) | e2[4] & (cout) );
	assign fex[5] = ( e1[5] & (~cout) | e2[5] & (cout) );
	assign fex[6] = ( e1[6] & (~cout) | e2[6] & (cout) );
	assign fex[7] = ( e1[7] & (~cout) | e2[7] & (cout) );
	assign fex[8] = ( e1[8] & (~cout) | e2[8] & (cout) );
	assign fex[9] = ( e1[9] & (~cout) | e2[9] & (cout) );
	assign fex[10] = ( e1[10] & (~cout) | e2[10] & (cout) );
	assign fex[11] = ( e1[11] & (~cout) | e2[11] & (cout) );
	assign fex[12] = ( e1[12] & (~cout) | e2[12] & (cout) );
	assign fex[13] = ( e1[13] & (~cout) | e2[13] & (cout) );
	assign fex[14] = ( e1[14] & (~cout) | e2[14] & (cout) );
	assign fex[15] = ( e1[15] & (~cout) | e2[15] & (cout) );
	assign fex[16] = ( e1[16] & (~cout) | e2[16] & (cout) );
	assign fex[17] = ( e1[17] & (~cout) | e2[17] & (cout) );
	assign fex[18] = ( e1[18] & (~cout) | e2[18] & (cout) );
	assign fex[19] = ( e1[19] & (~cout) | e2[19] & (cout) );
	assign fex[20] = ( e1[20] & (~cout) | e2[20] & (cout) );
	assign fex[21] = ( e1[21] & (~cout) | e2[21] & (cout) );
	assign fex[22] = ( e1[22] & (~cout) | e2[22] & (cout) );
	assign fex[23] = ( e1[23] & (~cout) | e2[23] & (cout) );
	assign fex[24] = ( e1[24] & (~cout) | e2[24] & (cout) );
	assign fex[25] = ( e1[25] & (~cout) | e2[25] & (cout) );
	assign fex[26] = ( e1[26] & (~cout) | e2[26] & (cout) );
	assign fex[27] = ( e1[27] & (~cout) | e2[27] & (cout) );
	assign fex[28] = ( e1[28] & (~cout) | e2[28] & (cout) );
	assign fex[29] = ( e1[29] & (~cout) | e2[29] & (cout) );
	assign fex[30] = ( e1[30] & (~cout) | e2[30] & (cout) );
	assign fex[31] = ( e1[31] & (~cout) | e2[31] & (cout) );

	//adding & subtracting the exponents
	pipeline_prefix32 lo8(f1, f2, 1'b0, sout1, fout3, clk, 32'b00000000000000000000000000000000); //addition
	pipeline_prefix32 lo9(f1, f2, 1'b1, sout2, fout4, clk, 32'b11111111111111111111111111111111); //f1 - f2 assuming f1 > f2
	pipeline_prefix32 lo10(f2, f1, 1'b1, sout3, fout5, clk, 32'b11111111111111111111111111111111); //f2 - f1 assuming f2 > f1

	//taking the final sum or difference into sout
	assign sout[0] = (a[31] & b[31] & sout1[0]) | ((~a[31]) & (~b[31]) & sout1[0]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[0] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[0] );
	assign sout[1] = (a[31] & b[31] & sout1[1]) | ((~a[31]) & (~b[31]) & sout1[1]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[1] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[1] );
	assign sout[2] = (a[31] & b[31] & sout1[2]) | ((~a[31]) & (~b[31]) & sout1[2]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[2] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[2] );
	assign sout[3] = (a[31] & b[31] & sout1[3]) | ((~a[31]) & (~b[31]) & sout1[3]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[3] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[3] );
	assign sout[4] = (a[31] & b[31] & sout1[4]) | ((~a[31]) & (~b[31]) & sout1[4]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[4] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[4] );
	assign sout[5] = (a[31] & b[31] & sout1[5]) | ((~a[31]) & (~b[31]) & sout1[5]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[5] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[5] );
	assign sout[6] = (a[31] & b[31] & sout1[6]) | ((~a[31]) & (~b[31]) & sout1[6]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[6] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[6] );
	assign sout[7] = (a[31] & b[31] & sout1[7]) | ((~a[31]) & (~b[31]) & sout1[7]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[7] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[7] );
	assign sout[8] = (a[31] & b[31] & sout1[8]) | ((~a[31]) & (~b[31]) & sout1[8]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[8] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[8] );
	assign sout[9] = (a[31] & b[31] & sout1[9]) | ((~a[31]) & (~b[31]) & sout1[9]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[9] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[9] );
	assign sout[10] = (a[31] & b[31] & sout1[10]) | ((~a[31]) & (~b[31]) & sout1[10]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[10] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[10] );
	assign sout[11] = (a[31] & b[31] & sout1[11]) | ((~a[31]) & (~b[31]) & sout1[11]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[11] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[11] );
	assign sout[12] = (a[31] & b[31] & sout1[12]) | ((~a[31]) & (~b[31]) & sout1[12]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[12] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[12] );
	assign sout[13] = (a[31] & b[31] & sout1[13]) | ((~a[31]) & (~b[31]) & sout1[13]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[13] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[13] );
	assign sout[14] = (a[31] & b[31] & sout1[14]) | ((~a[31]) & (~b[31]) & sout1[14]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[14] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[14] );
	assign sout[15] = (a[31] & b[31] & sout1[15]) | ((~a[31]) & (~b[31]) & sout1[15]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[15] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[15] );
	assign sout[16] = (a[31] & b[31] & sout1[16]) | ((~a[31]) & (~b[31]) & sout1[16]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[16] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[16] );
	assign sout[17] = (a[31] & b[31] & sout1[17]) | ((~a[31]) & (~b[31]) & sout1[17]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[17] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[17] );
	assign sout[18] = (a[31] & b[31] & sout1[18]) | ((~a[31]) & (~b[31]) & sout1[18]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[18] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[18] );
	assign sout[19] = (a[31] & b[31] & sout1[19]) | ((~a[31]) & (~b[31]) & sout1[19]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[19] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[19] );
	assign sout[20] = (a[31] & b[31] & sout1[20]) | ((~a[31]) & (~b[31]) & sout1[20]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[20] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[20] );
	assign sout[21] = (a[31] & b[31] & sout1[21]) | ((~a[31]) & (~b[31]) & sout1[21]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[21] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[21] );
	assign sout[22] = (a[31] & b[31] & sout1[22]) | ((~a[31]) & (~b[31]) & sout1[22]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[22] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[22] );
	assign sout[23] = (a[31] & b[31] & sout1[23]) | ((~a[31]) & (~b[31]) & sout1[23]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[23] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[23] );
	assign sout[24] = (a[31] & b[31] & sout1[24]) | ((~a[31]) & (~b[31]) & sout1[24]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[24] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[24] );
	assign sout[25] = (a[31] & b[31] & sout1[25]) | ((~a[31]) & (~b[31]) & sout1[25]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[25] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[25] );
	assign sout[26] = (a[31] & b[31] & sout1[26]) | ((~a[31]) & (~b[31]) & sout1[26]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[26] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[26] );
	assign sout[27] = (a[31] & b[31] & sout1[27]) | ((~a[31]) & (~b[31]) & sout1[27]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[27] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[27] );
	assign sout[28] = (a[31] & b[31] & sout1[28]) | ((~a[31]) & (~b[31]) & sout1[28]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[28] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[28] );
	assign sout[29] = (a[31] & b[31] & sout1[29]) | ((~a[31]) & (~b[31]) & sout1[29]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[29] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[29] );
	assign sout[30] = (a[31] & b[31] & sout1[30]) | ((~a[31]) & (~b[31]) & sout1[30]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[30] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[30] );
	assign sout[31] = (a[31] & b[31] & sout1[31]) | ((~a[31]) & (~b[31]) & sout1[31]) | ( (((~a[31]) & (b[31]) & (fout1))| ((a[31]) & (~b[31]) & (fout1)) )  &  sout2[31] ) | ((((~a[31]) & (b[31]) & (fout2)) | ((a[31]) & (~b[31]) & (fout2)) ) & sout3[31] );

	//detecting one and shifting in a way to normalise it
	//detect one in sout and make it in the form 1.000 (i.e 000011001001110 will become 1001001110)
	//pos is the position of 1 after adding the mantissa's
	detectone d1(sout, n5, pos[7:0], clk);    
	assign pos[31:8] = 24'd0;

	//TO FIND THE POS OF 1 IN THE UNCHANGED MANTISSA	
	assign q1[0] = ( m2[0] & cout | m1[0] & (~cout) );
	assign q1[1] = ( m2[1] & cout | m1[1] & (~cout) );
	assign q1[2] = ( m2[2] & cout | m1[2] & (~cout) );
	assign q1[3] = ( m2[3] & cout | m1[3] & (~cout) );
	assign q1[4] = ( m2[4] & cout | m1[4] & (~cout) );
	assign q1[5] = ( m2[5] & cout | m1[5] & (~cout) );
	assign q1[6] = ( m2[6] & cout | m1[6] & (~cout) );
	assign q1[7] = ( m2[7] & cout | m1[7] & (~cout) );
	assign q1[8] = ( m2[8] & cout | m1[8] & (~cout) );
	assign q1[9] = ( m2[9] & cout | m1[9] & (~cout) );
	assign q1[10] = ( m2[10] & cout | m1[10] & (~cout) );
	assign q1[11] = ( m2[11] & cout | m1[11] & (~cout) );
	assign q1[12] = ( m2[12] & cout | m1[12] & (~cout) );
	assign q1[13] = ( m2[13] & cout | m1[13] & (~cout) );
	assign q1[14] = ( m2[14] & cout | m1[14] & (~cout) );
	assign q1[15] = ( m2[15] & cout | m1[15] & (~cout) );
	assign q1[16] = ( m2[16] & cout | m1[16] & (~cout) );
	assign q1[17] = ( m2[17] & cout | m1[17] & (~cout) );
	assign q1[18] = ( m2[18] & cout | m1[18] & (~cout) );
	assign q1[19] = ( m2[19] & cout | m1[19] & (~cout) );
	assign q1[20] = ( m2[20] & cout | m1[20] & (~cout) );
	assign q1[21] = ( m2[21] & cout | m1[21] & (~cout) );
	assign q1[22] = ( m2[22] & cout | m1[22] & (~cout) );
	assign q1[23] = ( m2[23] & cout | m1[23] & (~cout) );
	assign q1[24] = ( m2[24] & cout | m1[24] & (~cout) );
	assign q1[25] = ( m2[25] & cout | m1[25] & (~cout) );
	assign q1[26] = ( m2[26] & cout | m1[26] & (~cout) );
	assign q1[27] = ( m2[27] & cout | m1[27] & (~cout) );
	assign q1[28] = ( m2[28] & cout | m1[28] & (~cout) );
	assign q1[29] = ( m2[29] & cout | m1[29] & (~cout) );
	assign q1[30] = ( m2[30] & cout | m1[30] & (~cout) );
	assign q1[31] = ( m2[31] & cout | m1[31] & (~cout) );

	detectone d2(q1, n6, pos1[7:0], clk); 
	assign pos1[31:8] = 24'd0;

	//finding the difference between the two positions to add it to the fexp
	pipeline_prefix32 lo3(pos, pos1, 1'b1, s3, out2, clk, 32'b11111111111111111111111111111111); //pos - pos1; pos is greater than pos1

	pipeline_prefix32 lo4(fex, s3, 1'b0, fexpo, out1, clk, 32'd0); //fex + s3 

	assign finalo[31] = sign; //not correct
	assign finalo[22:0] = n5[31:9];
	assign finalo[30:23] = fexpo[7:0]; 

endmodule // floating_adder