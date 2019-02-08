/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Module : 32b Pipelined Prefix Adder
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module pipeline_prefix32(x, b, cin, s, cout, clk, m);

	input [31:0]x, m, b;
	input cin;
	input clk;
	output [31:0]s;
	output cout;

	wire [31:0]g, a, p, c;
	wire [31:0]y;

	assign y = b ^ m;
	assign c[0] = cin;
	assign p = x ^ y;
	assign g = x & y;
	assign a = x | y;

	wire [14:0] gw1, aw1;
	wire [13:0] gw2, aw2;
	wire [11:0] gw3, aw3;
	wire [7:0] gw4, aw4;
	wire [1:0] fdw1;
	wire [3:0] fdw2;
	wire [7:0] fdw3;
	wire [15:0] fdw4;
	wire [31:0] fdw5, fdw6;
	wire [30:0] faw1, fgw1;
	wire [28:0] fgw2, faw2;
	wire [24:0] fgw3, faw3;
	wire [16:0] fgw4, faw4;
	wire fgw5,faw5,fdw;
	wire [31:0]p2, p3, p4, p6, p5, p1;

	//level 1
	predot d1(g[0], a[0], c[0], c[1]);
	precircle c1(g[2], a[2], g[1], a[1], gw1[0], aw1[0]);
	precircle c2(g[4], a[4], g[3], a[3], gw1[1], aw1[1]);
	precircle c3(g[6], a[6], g[5], a[5], gw1[2], aw1[2]);
	precircle c4(g[8], a[8], g[7], a[7], gw1[3], aw1[3]);
	precircle c5(g[10], a[10], g[9], a[9], gw1[4], aw1[4]);
	precircle c6(g[12], a[12], g[11], a[11], gw1[5], aw1[5]);
	precircle c7(g[14], a[14], g[13], a[13], gw1[6], aw1[6]);
	precircle c8(g[16], a[16], g[15], a[15], gw1[7], aw1[7]);
	precircle c9(g[18], a[18], g[17], a[17], gw1[8], aw1[8]);
	precircle c10(g[20], a[20], g[19], a[19], gw1[9], aw1[9]);
	precircle c11(g[22], a[22], g[21], a[21], gw1[10], aw1[10]);
	precircle c12(g[24], a[24], g[23], a[23], gw1[11], aw1[11]);
	precircle c13(g[26], a[26], g[25], a[25], gw1[12], aw1[12]);
	precircle c14(g[28], a[28], g[27], a[27], gw1[13], aw1[13]);
	precircle c15(g[30], a[30], g[29], a[29], gw1[14], aw1[14]);
	diff fw0(c[0], fdw1[0], clk);
	diff fw1(c[1], fdw1[1], clk);
	diff fw2(g[1], fgw1[0], clk);
	diff fw3(a[1], faw1[0], clk);
	diff fw4(gw1[0], fgw1[1], clk);
	diff fw5(aw1[0], faw1[1], clk);
	diff fw6(g[3], fgw1[2], clk);
	diff fw7(a[3], faw1[2], clk);
	diff fw8(gw1[1], fgw1[3], clk);
	diff fw9(aw1[1], faw1[3], clk);
	diff fw10(g[5], fgw1[4], clk);
	diff fw11(a[5], faw1[4], clk);
	diff fw12(gw1[2], fgw1[5], clk);
	diff fw13(aw1[2], faw1[5], clk);
	diff fw14(g[7], fgw1[6], clk);
	diff fw15(a[7], faw1[6], clk);
	diff fw16(gw1[3], fgw1[7], clk);
	diff fw17(aw1[3], faw1[7], clk);
	diff fw18(g[9], fgw1[8], clk);
	diff fw19(a[9], faw1[8], clk);
	diff fw20(gw1[4], fgw1[9], clk);
	diff fw21(aw1[4], faw1[9], clk);
	diff fw22(g[11], fgw1[10], clk);
	diff fw23(a[11], faw1[10], clk);
	diff fw24(gw1[5], fgw1[11], clk);
	diff fw25(aw1[5], faw1[11], clk);
	diff fw26(g[13], fgw1[12], clk);
	diff fw27(a[13], faw1[12], clk);
	diff fw28(gw1[6], fgw1[13], clk);
	diff fw29(aw1[6], faw1[13], clk);
	diff fw30(g[15], fgw1[14], clk);
	diff fw31(a[15], faw1[14], clk);
	diff fw32(gw1[7], fgw1[15], clk);
	diff fw33(aw1[7], faw1[15], clk);
	diff fw34(g[17], fgw1[16], clk);
	diff fw35(a[17], faw1[16], clk);
	diff fw36(gw1[8], fgw1[17], clk);
	diff fw37(aw1[8], faw1[17], clk);
	diff fw38(g[19], fgw1[18], clk);
	diff fw39(a[19], faw1[18], clk);
	diff fw40(gw1[9], fgw1[19], clk);
	diff fw41(aw1[9], faw1[19], clk);
	diff fw42(g[21], fgw1[20], clk);
	diff fw43(a[21], faw1[20], clk);
	diff fw44(gw1[10], fgw1[21], clk);
	diff fw45(aw1[10], faw1[21], clk);
	diff fw46(g[23], fgw1[22], clk);
	diff fw47(a[23], faw1[22], clk);
	diff fw48(gw1[11], fgw1[23], clk);
	diff fw49(aw1[11], faw1[23], clk);
	diff fw50(g[25], fgw1[24], clk);
	diff fw51(a[25], faw1[24], clk);
	diff fw52(gw1[12], fgw1[25], clk);
	diff fw53(aw1[12], faw1[25], clk);
	diff fw54(g[27], fgw1[26], clk);
	diff fw55(a[27], faw1[26], clk);
	diff fw56(gw1[13], fgw1[27], clk);
	diff fw57(aw1[13], faw1[27], clk);
	diff fw58(g[29], fgw1[28], clk);
	diff fw59(a[29], faw1[28], clk);
	diff fw60(gw1[14], fgw1[29], clk);
	diff fw61(aw1[14], faw1[29], clk);
	diff fw62(g[31], fgw1[30], clk);
	diff fw63(a[31], faw1[30], clk);
	diff ex0(p[0], p1[0], clk);
	diff ex1(p[1], p1[1], clk);
	diff ex2(p[2], p1[2], clk);
	diff ex3(p[3], p1[3], clk);
	diff ex4(p[4], p1[4], clk);
	diff ex5(p[5], p1[5], clk);
	diff ex6(p[6], p1[6], clk);
	diff ex7(p[7], p1[7], clk);
	diff ex8(p[8], p1[8], clk);
	diff ex9(p[9], p1[9], clk);
	diff ex10(p[10], p1[10], clk);
	diff ex11(p[11], p1[11], clk);
	diff ex12(p[12], p1[12], clk);
	diff ex13(p[13], p1[13], clk);
	diff ex14(p[14], p1[14], clk);
	diff ex15(p[15], p1[15], clk);
	diff ex16(p[16], p1[16], clk);
	diff ex17(p[17], p1[17], clk);
	diff ex18(p[18], p1[18], clk);
	diff ex19(p[19], p1[19], clk);
	diff ex20(p[20], p1[20], clk);
	diff ex21(p[21], p1[21], clk);
	diff ex22(p[22], p1[22], clk);
	diff ex23(p[23], p1[23], clk);
	diff ex24(p[24], p1[24], clk);
	diff ex25(p[25], p1[25], clk);
	diff ex26(p[26], p1[26], clk);
	diff ex27(p[27], p1[27], clk);
	diff ex28(p[28], p1[28], clk);
	diff ex29(p[29], p1[29], clk);
	diff ex30(p[30], p1[30], clk);
	diff ex31(p[31], p1[31], clk);

	//level 2
	predot d2(fgw1[0], faw1[0], fdw1[1], c[2]);
	predot d3(fgw1[1], faw1[1], fdw1[1], c[3]);
	precircle c16(fgw1[4], faw1[4], fgw1[3], faw1[3], gw2[0], aw2[0]);
	precircle c17(fgw1[5], faw1[5], fgw1[3], faw1[3], gw2[1], aw2[1]);
	precircle c18(fgw1[8], faw1[8], fgw1[7], faw1[7], gw2[2], aw2[2]);
	precircle c19(fgw1[9], faw1[9], fgw1[7], faw1[7], gw2[3], aw2[3]);
	precircle c20(fgw1[12], faw1[12], fgw1[11], faw1[11], gw2[4], aw2[4]);
	precircle c21(fgw1[13], faw1[13], fgw1[11], faw1[11], gw2[5], aw2[5]);
	precircle c22(fgw1[16], faw1[16], fgw1[15], faw1[15], gw2[6], aw2[6]);
	precircle c23(fgw1[17], faw1[17], fgw1[15], faw1[15], gw2[7], aw2[7]);
	precircle c24(fgw1[20], faw1[20], fgw1[19], faw1[19], gw2[8], aw2[8]);
	precircle c25(fgw1[21], faw1[21], fgw1[19], faw1[19], gw2[9], aw2[9]);
	precircle c26(fgw1[24], faw1[24], fgw1[23], faw1[23], gw2[10], aw2[10]);
	precircle c27(fgw1[25], faw1[25], fgw1[23], faw1[23], gw2[11], aw2[11]);
	precircle c28(fgw1[28], faw1[28], fgw1[27], faw1[27], gw2[12], aw2[12]);
	precircle c29(fgw1[29], faw1[29], fgw1[27], faw1[27], gw2[13], aw2[13]);

	diff fw64(fdw1[0], fdw2[0], clk);
	diff fw65(fdw1[1], fdw2[1], clk);
	diff fw66(c[2], fdw2[2], clk);
	diff fw67(c[3], fdw2[3], clk);
	diff fw68(fgw1[2], fgw2[0], clk);
	diff fw69(faw1[2], faw2[0], clk);
	diff fw70(fgw1[3], fgw2[1], clk);
	diff fw71(faw1[3], faw2[1], clk);
	diff fw72(gw2[0], fgw2[2], clk);
	diff fw73(aw2[0], faw2[2], clk);
	diff fw74(gw2[1], fgw2[3], clk);
	diff fw75(aw2[1], faw2[3], clk);
	diff fw76(fgw1[6], fgw2[4], clk);
	diff fw77(faw1[6], faw2[4], clk);
	diff fw78(fgw1[7], fgw2[5], clk);
	diff fw79(faw1[7], faw2[5], clk);
	diff fw80(gw2[2], fgw2[6], clk);
	diff fw81(aw2[2], faw2[6], clk);
	diff fw82(gw2[3], fgw2[7], clk);
	diff fw83(aw2[3], faw2[7], clk);
	diff fw84(fgw1[10], fgw2[8], clk);
	diff fw85(faw1[10], faw2[8], clk);
	diff fw86(fgw1[11], fgw2[9], clk);
	diff fw87(faw1[11], faw2[9], clk);
	diff fw88(gw2[4], fgw2[10], clk);
	diff fw89(aw2[4], faw2[10], clk);
	diff fw90(gw2[5], fgw2[11], clk);
	diff fw91(aw2[5], faw2[11], clk);
	diff fw92(fgw1[14], fgw2[12], clk);
	diff fw93(faw1[14], faw2[12], clk);
	diff fw94(fgw1[15], fgw2[13], clk);
	diff fw95(faw1[15], faw2[13], clk);
	diff fw96(gw2[6], fgw2[14], clk);
	diff fw97(aw2[6], faw2[14], clk);
	diff fw98(gw2[7], fgw2[15], clk);
	diff fw99(aw2[7], faw2[15], clk);
	diff fw100(fgw1[18], fgw2[16], clk);
	diff fw101(faw1[18], faw2[16], clk);
	diff fw102(fgw1[19], fgw2[17], clk);
	diff fw103(faw1[19], faw2[17], clk);
	diff fw104(gw2[8], fgw2[18], clk);
	diff fw105(aw2[8], faw2[18], clk);
	diff fw106(gw2[9], fgw2[19], clk);
	diff fw107(aw2[9], faw2[19], clk);
	diff fw108(fgw1[22], fgw2[20], clk);
	diff fw109(faw1[22], faw2[20], clk);
	diff fw110(fgw1[23], fgw2[21], clk);
	diff fw111(faw1[23], faw2[21], clk);
	diff fw112(gw2[10], fgw2[22], clk);
	diff fw113(aw2[10], faw2[22], clk);
	diff fw114(gw2[11], fgw2[23], clk);
	diff fw115(aw2[11], faw2[23], clk);
	diff fw116(fgw1[26], fgw2[24], clk);
	diff fw117(faw1[26], faw2[24], clk);
	diff fw118(fgw1[27], fgw2[25], clk);
	diff fw119(faw1[27], faw2[25], clk);
	diff fw120(gw2[12], fgw2[26], clk);
	diff fw121(aw2[12], faw2[26], clk);
	diff fw122(gw2[13], fgw2[27], clk);
	diff fw123(aw2[13], faw2[27], clk);
	diff fw124(fgw1[30], fgw2[28], clk);
	diff fw125(faw1[30], faw2[28], clk);
	diff exe0(p1[0], p2[0], clk);
	diff exe1(p1[1], p2[1], clk);
	diff exe2(p1[2], p2[2], clk);
	diff exe3(p1[3], p2[3], clk);
	diff exe4(p1[4], p2[4], clk);
	diff exe5(p1[5], p2[5], clk);
	diff exe6(p1[6], p2[6], clk);
	diff exe7(p1[7], p2[7], clk);
	diff exe8(p1[8], p2[8], clk);
	diff exe9(p1[9], p2[9], clk);
	diff exe10(p1[10], p2[10], clk);
	diff exe11(p1[11], p2[11], clk);
	diff exe12(p1[12], p2[12], clk);
	diff exe13(p1[13], p2[13], clk);
	diff exe14(p1[14], p2[14], clk);
	diff exe15(p1[15], p2[15], clk);
	diff exe16(p1[16], p2[16], clk);
	diff exe17(p1[17], p2[17], clk);
	diff exe18(p1[18], p2[18], clk);
	diff exe19(p1[19], p2[19], clk);
	diff exe20(p1[20], p2[20], clk);
	diff exe21(p1[21], p2[21], clk);
	diff exe22(p1[22], p2[22], clk);
	diff exe23(p1[23], p2[23], clk);
	diff exe24(p1[24], p2[24], clk);
	diff exe25(p1[25], p2[25], clk);
	diff exe26(p1[26], p2[26], clk);
	diff exe27(p1[27], p2[27], clk);
	diff exe28(p1[28], p2[28], clk);
	diff exe29(p1[29], p2[29], clk);
	diff exe30(p1[30], p2[30], clk);
	diff exe31(p1[31], p2[31], clk);

	//level 3
	predot d4(fgw2[0], faw2[0], fdw2[3], c[4]);
	predot d5(fgw2[1], faw2[1], fdw2[3], c[5]);
	predot d6(fgw2[2], faw2[2], fdw2[3], c[6]);
	predot d7(fgw2[3], faw2[3], fdw2[3], c[7]);
	precircle c30(fgw2[8], faw2[8], fgw2[7], faw2[7], gw3[0], aw3[0]);
	precircle c31(fgw2[9], faw2[9], fgw2[7], faw2[7], gw3[1], aw3[1]);
	precircle c32(fgw2[10], faw2[10], fgw2[7], faw2[7], gw3[2], aw3[2]);
	precircle c33(fgw2[11], faw2[11], fgw2[7], faw2[7], gw3[3], aw3[3]);
	precircle c34(fgw2[16], faw2[16], fgw2[15], faw2[15], gw3[4], aw3[4]);
	precircle c35(fgw2[17], faw2[17], fgw2[15], faw2[15], gw3[5], aw3[5]);
	precircle c36(fgw2[18], faw2[18], fgw2[15], faw2[15], gw3[6], aw3[6]);
	precircle c37(fgw2[19], faw2[19], fgw2[15], faw2[15], gw3[7], aw3[7]);
	precircle c38(fgw2[24], faw2[24], fgw2[23], faw2[23], gw3[8], aw3[8]);
	precircle c39(fgw2[25], faw2[25], fgw2[23], faw2[23], gw3[9], aw3[9]);
	precircle c40(fgw2[26], faw2[26], fgw2[23], faw2[23], gw3[10], aw3[10]);
	precircle c41(fgw2[27], faw2[27], fgw2[23], faw2[23], gw3[11], aw3[11]);
	diff fw126(fdw2[0], fdw3[0], clk);
	diff fw127(fdw2[1], fdw3[1], clk);
	diff fw128(fdw2[2], fdw3[2], clk);
	diff fw129(fdw2[3], fdw3[3], clk);
	diff fw130(c[4], fdw3[4], clk);
	diff fw131(c[5], fdw3[5], clk);
	diff fw132(c[6], fdw3[6], clk);
	diff fw133(c[7], fdw3[7], clk);
	diff fw134(fgw2[4], fgw3[0], clk);
	diff fw135(faw2[4], faw3[0], clk);
	diff fw136(fgw2[5], fgw3[1], clk);
	diff fw137(faw2[5], faw3[1], clk);
	diff fw138(fgw2[6], fgw3[2], clk);
	diff fw139(faw2[6], faw3[2], clk);
	diff fw140(fgw2[7], fgw3[3], clk);
	diff fw141(faw2[7], faw3[3], clk);
	diff fw142(gw3[0], fgw3[4], clk);
	diff fw143(aw3[0], faw3[4], clk);
	diff fw144(gw3[1], fgw3[5], clk);
	diff fw145(aw3[1], faw3[5], clk);
	diff fw146(gw3[2], fgw3[6], clk);
	diff fw147(aw3[2], faw3[6], clk);
	diff fw148(gw3[3], fgw3[7], clk);
	diff fw149(aw3[3], faw3[7], clk);
	diff fw150(fgw2[12], fgw3[8], clk);
	diff fw151(faw2[12], faw3[8], clk);
	diff fw152(fgw2[13], fgw3[9], clk);
	diff fw153(faw2[13], faw3[9], clk);
	diff fw154(fgw2[14], fgw3[10], clk);
	diff fw155(faw2[14], faw3[10], clk);
	diff fw156(fgw2[15], fgw3[11], clk);
	diff fw157(faw2[15], faw3[11], clk);
	diff fw158(gw3[4], fgw3[12], clk);
	diff fw159(aw3[4], faw3[12], clk);
	diff fw160(gw3[5], fgw3[13], clk);
	diff fw161(aw3[5], faw3[13], clk);
	diff fw162(gw3[6], fgw3[14], clk);
	diff fw163(aw3[6], faw3[14], clk);
	diff fw164(gw3[7], fgw3[15], clk);
	diff fw165(aw3[7], faw3[15], clk);
	diff fw166(fgw2[20], fgw3[16], clk);
	diff fw167(faw2[20], faw3[16], clk);
	diff fw168(fgw2[21], fgw3[17], clk);
	diff fw169(faw2[21], faw3[17], clk);
	diff fw170(fgw2[22], fgw3[18], clk);
	diff fw171(faw2[22], faw3[18], clk);
	diff fw172(fgw2[23], fgw3[19], clk);
	diff fw173(faw2[23], faw3[19], clk);
	diff fw174(gw3[8], fgw3[20], clk);
	diff fw175(aw3[8], faw3[20], clk);
	diff fw176(gw3[9], fgw3[21], clk);
	diff fw177(aw3[9], faw3[21], clk);
	diff fw178(gw3[10], fgw3[22], clk);
	diff fw179(aw3[10], faw3[22], clk);
	diff fw180(gw3[11], fgw3[23], clk);
	diff fw181(aw3[11], faw3[23], clk);
	diff fw182(fgw2[28], fgw3[24], clk);
	diff fw183(faw2[28], faw3[24], clk);
	diff axe0(p2[0], p3[0], clk);
	diff axe1(p2[1], p3[1], clk);
	diff axe2(p2[2], p3[2], clk);
	diff axe3(p2[3], p3[3], clk);
	diff axe4(p2[4], p3[4], clk);
	diff axe5(p2[5], p3[5], clk);
	diff axe6(p2[6], p3[6], clk);
	diff axe7(p2[7], p3[7], clk);
	diff axe8(p2[8], p3[8], clk);
	diff axe9(p2[9], p3[9], clk);
	diff axe10(p2[10], p3[10], clk);
	diff axe11(p2[11], p3[11], clk);
	diff axe12(p2[12], p3[12], clk);
	diff axe13(p2[13], p3[13], clk);
	diff axe14(p2[14], p3[14], clk);
	diff axe15(p2[15], p3[15], clk);
	diff axe16(p2[16], p3[16], clk);
	diff axe17(p2[17], p3[17], clk);
	diff axe18(p2[18], p3[18], clk);
	diff axe19(p2[19], p3[19], clk);
	diff axe20(p2[20], p3[20], clk);
	diff axe21(p2[21], p3[21], clk);
	diff axe22(p2[22], p3[22], clk);
	diff axe23(p2[23], p3[23], clk);
	diff axe24(p2[24], p3[24], clk);
	diff axe25(p2[25], p3[25], clk);
	diff axe26(p2[26], p3[26], clk);
	diff axe27(p2[27], p3[27], clk);
	diff axe28(p2[28], p3[28], clk);
	diff axe29(p2[29], p3[29], clk);
	diff axe30(p2[30], p3[30], clk);
	diff axe31(p2[31], p3[31], clk);

	//level 4
	predot d8(fgw3[0], faw3[0], fdw3[7], c[8]);
	predot d9(fgw3[1], faw3[1], fdw3[7], c[9]);
	predot d10(fgw3[2], faw3[2], fdw3[7], c[10]);
	predot d11(fgw3[3], faw3[3], fdw3[7], c[11]);
	predot d12(fgw3[4], faw3[4], fdw3[7], c[12]);
	predot d13(fgw3[5], faw3[5], fdw3[7], c[13]);
	predot d14(fgw3[6], faw3[6], fdw3[7], c[14]);
	predot d15(fgw3[7], faw3[7], fdw3[7], c[15]);
	precircle c42(fgw3[16], faw3[16], fgw3[15], faw3[15], gw4[0], aw4[0]);
	precircle c43(fgw3[17], faw3[17], fgw3[15], faw3[15], gw4[1], aw4[1]);
	precircle c44(fgw3[18], faw3[18], fgw3[15], faw3[15], gw4[2], aw4[2]);
	precircle c45(fgw3[19], faw3[19], fgw3[15], faw3[15], gw4[3], aw4[3]);
	precircle c46(fgw3[20], faw3[20], fgw3[15], faw3[15], gw4[4], aw4[4]);
	precircle c47(fgw3[21], faw3[21], fgw3[15], faw3[15], gw4[5], aw4[5]);
	precircle c48(fgw3[22], faw3[22], fgw3[15], faw3[15], gw4[6], aw4[6]);
	precircle c49(fgw3[23], faw3[23], fgw3[15], faw3[15], gw4[7], aw4[7]);
	diff fw184(fdw3[0], fdw4[0], clk);
	diff fw185(fdw3[1], fdw4[1], clk);
	diff fw186(fdw3[2], fdw4[2], clk);
	diff fw187(fdw3[3], fdw4[3], clk);
	diff fw188(fdw3[4], fdw4[4], clk);
	diff fw189(fdw3[5], fdw4[5], clk);
	diff fw190(fdw3[6], fdw4[6], clk);
	diff fw191(fdw3[7], fdw4[7], clk);
	diff fw192(c[8], fdw4[8], clk);
	diff fw193(c[9], fdw4[9], clk);
	diff fw194(c[10], fdw4[10], clk);
	diff fw195(c[11], fdw4[11], clk);
	diff fw196(c[12], fdw4[12], clk);
	diff fw197(c[13], fdw4[13], clk);
	diff fw198(c[14], fdw4[14], clk);
	diff fw199(c[15], fdw4[15], clk);
	diff fw200(fgw3[8], fgw4[0], clk);
	diff fw201(faw3[8], faw4[0], clk);
	diff fw202(fgw3[9], fgw4[1], clk);
	diff fw203(faw3[9], faw4[1], clk);
	diff fw204(fgw3[10], fgw4[2], clk);
	diff fw205(faw3[10], faw4[2], clk);
	diff fw206(fgw3[11], fgw4[3], clk);
	diff fw207(faw3[11], faw4[3], clk);
	diff fw208(fgw3[12], fgw4[4], clk);
	diff fw209(faw3[12], faw4[4], clk);
	diff fw210(fgw3[13], fgw4[5], clk);
	diff fw211(faw3[13], faw4[5], clk);
	diff fw212(fgw3[14], fgw4[6], clk);
	diff fw213(faw3[14], faw4[6], clk);
	diff fw214(fgw3[15], fgw4[7], clk);
	diff fw215(faw3[15], faw4[7], clk);
	diff fw216(gw4[0], fgw4[8], clk);
	diff fw217(aw4[0], faw4[8], clk);
	diff fw218(gw4[1], fgw4[9], clk);
	diff fw219(aw4[1], faw4[9], clk);
	diff fw220(gw4[2], fgw4[10], clk);
	diff fw221(aw4[2], faw4[10], clk);
	diff fw222(gw4[3], fgw4[11], clk);
	diff fw223(aw4[3], faw4[11], clk);
	diff fw224(gw4[4], fgw4[12], clk);
	diff fw225(aw4[4], faw4[12], clk);
	diff fw226(gw4[5], fgw4[13], clk);
	diff fw227(aw4[5], faw4[13], clk);
	diff fw228(gw4[6], fgw4[14], clk);
	diff fw229(aw4[6], faw4[14], clk);
	diff fw230(gw4[7], fgw4[15], clk);
	diff fw231(aw4[7], faw4[15], clk);
	diff fw232(fgw3[24], fgw4[16], clk);
	diff fw233(faw3[24], faw4[16], clk);
	diff bex0(p3[0], p4[0], clk);
	diff bex1(p3[1], p4[1], clk);
	diff bex2(p3[2], p4[2], clk);
	diff bex3(p3[3], p4[3], clk);
	diff bex4(p3[4], p4[4], clk);
	diff bex5(p3[5], p4[5], clk);
	diff bex6(p3[6], p4[6], clk);
	diff bex7(p3[7], p4[7], clk);
	diff bex8(p3[8], p4[8], clk);
	diff bex9(p3[9], p4[9], clk);
	diff bex10(p3[10], p4[10], clk);
	diff bex11(p3[11], p4[11], clk);
	diff bex12(p3[12], p4[12], clk);
	diff bex13(p3[13], p4[13], clk);
	diff bex14(p3[14], p4[14], clk);
	diff bex15(p3[15], p4[15], clk);
	diff bex16(p3[16], p4[16], clk);
	diff bex17(p3[17], p4[17], clk);
	diff bex18(p3[18], p4[18], clk);
	diff bex19(p3[19], p4[19], clk);
	diff bex20(p3[20], p4[20], clk);
	diff bex21(p3[21], p4[21], clk);
	diff bex22(p3[22], p4[22], clk);
	diff bex23(p3[23], p4[23], clk);
	diff bex24(p3[24], p4[24], clk);
	diff bex25(p3[25], p4[25], clk);
	diff bex26(p3[26], p4[26], clk);
	diff bex27(p3[27], p4[27], clk);
	diff bex28(p3[28], p4[28], clk);
	diff bex29(p3[29], p4[29], clk);
	diff bex30(p3[30], p4[30], clk);
	diff bex31(p3[31], p4[31], clk);

	//level 5
	predot d16(fgw4[0], faw4[0], fdw4[15], c[16]);
	predot d17(fgw4[1], faw4[1], fdw4[15], c[17]);
	predot d18(fgw4[2], faw4[2], fdw4[15], c[18]);
	predot d19(fgw4[3], faw4[3], fdw4[15], c[19]);
	predot d20(fgw4[4], faw4[4], fdw4[15], c[20]);
	predot d21(fgw4[5], faw4[5], fdw4[15], c[21]);
	predot d22(fgw4[6], faw4[6], fdw4[15], c[22]);
	predot d23(fgw4[7], faw4[7], fdw4[15], c[23]);
	predot d24(fgw4[8], faw4[8], fdw4[15], c[24]);
	predot d25(fgw4[9], faw4[9], fdw4[15], c[25]);
	predot d26(fgw4[10], faw4[10], fdw4[15], c[26]);
	predot d27(fgw4[11], faw4[11], fdw4[15], c[27]);
	predot d28(fgw4[12], faw4[12], fdw4[15], c[28]);
	predot d29(fgw4[13], faw4[13], fdw4[15], c[29]);
	predot d30(fgw4[14], faw4[14], fdw4[15], c[30]);
	predot d31(fgw4[15], faw4[15], fdw4[15], c[31]);
	diff fw234(fdw4[0], fdw5[0], clk);
	diff fw235(fdw4[1], fdw5[1], clk);
	diff fw236(fdw4[2], fdw5[2], clk);
	diff fw237(fdw4[3], fdw5[3], clk);
	diff fw238(fdw4[4], fdw5[4], clk);
	diff fw239(fdw4[5], fdw5[5], clk);
	diff fw240(fdw4[6], fdw5[6], clk);
	diff fw241(fdw4[7], fdw5[7], clk);
	diff fw242(fdw4[8], fdw5[8], clk);
	diff fw243(fdw4[9], fdw5[9], clk);
	diff fw244(fdw4[10], fdw5[10], clk);
	diff fw245(fdw4[11], fdw5[11], clk);
	diff fw246(fdw4[12], fdw5[12], clk);
	diff fw247(fdw4[13], fdw5[13], clk);
	diff fw248(fdw4[14], fdw5[14], clk);
	diff fw249(fdw4[15], fdw5[15], clk);
	diff fw250(c[16], fdw5[16], clk);
	diff fw251(c[17], fdw5[17], clk);
	diff fw252(c[18], fdw5[18], clk);
	diff fw253(c[19], fdw5[19], clk);
	diff fw254(c[20], fdw5[20], clk);
	diff fw255(c[21], fdw5[21], clk);
	diff fw256(c[22], fdw5[22], clk);
	diff fw257(c[23], fdw5[23], clk);
	diff fw258(c[24], fdw5[24], clk);
	diff fw259(c[25], fdw5[25], clk);
	diff fw260(c[26], fdw5[26], clk);
	diff fw261(c[27], fdw5[27], clk);
	diff fw262(c[28], fdw5[28], clk);
	diff fw263(c[29], fdw5[29], clk);
	diff fw264(c[30], fdw5[30], clk);
	diff fw265(c[31], fdw5[31], clk);
	diff fw266(fgw4[16], fgw5, clk);
	diff fw267(faw4[16], faw5, clk);
	diff cex0(p4[0], p5[0], clk);
	diff cex1(p4[1], p5[1], clk);
	diff cex2(p4[2], p5[2], clk);
	diff cex3(p4[3], p5[3], clk);
	diff cex4(p4[4], p5[4], clk);
	diff cex5(p4[5], p5[5], clk);
	diff cex6(p4[6], p5[6], clk);
	diff cex7(p4[7], p5[7], clk);
	diff cex8(p4[8], p5[8], clk);
	diff cex9(p4[9], p5[9], clk);
	diff cex10(p4[10], p5[10], clk);
	diff cex11(p4[11], p5[11], clk);
	diff cex12(p4[12], p5[12], clk);
	diff cex13(p4[13], p5[13], clk);
	diff cex14(p4[14], p5[14], clk);
	diff cex15(p4[15], p5[15], clk);
	diff cex16(p4[16], p5[16], clk);
	diff cex17(p4[17], p5[17], clk);
	diff cex18(p4[18], p5[18], clk);
	diff cex19(p4[19], p5[19], clk);
	diff cex20(p4[20], p5[20], clk);
	diff cex21(p4[21], p5[21], clk);
	diff cex22(p4[22], p5[22], clk);
	diff cex23(p4[23], p5[23], clk);
	diff cex24(p4[24], p5[24], clk);
	diff cex25(p4[25], p5[25], clk);
	diff cex26(p4[26], p5[26], clk);
	diff cex27(p4[27], p5[27], clk);
	diff cex28(p4[28], p5[28], clk);
	diff cex29(p4[29], p5[29], clk);
	diff cex30(p4[30], p5[30], clk);
	diff cex31(p4[31], p5[31], clk);


	//level 6
	predot d32(fgw5, faw5, c[31], fdw);

	diff fw268(fdw5[0], fdw6[0], clk);
	diff fw269(fdw5[1], fdw6[1], clk);
	diff fw270(fdw5[2], fdw6[2], clk);
	diff fw271(fdw5[3], fdw6[3], clk);
	diff fw272(fdw5[4], fdw6[4], clk);
	diff fw273(fdw5[5], fdw6[5], clk);
	diff fw274(fdw5[6], fdw6[6], clk);
	diff fw275(fdw5[7], fdw6[7], clk);
	diff fw276(fdw5[8], fdw6[8], clk);
	diff fw277(fdw5[9], fdw6[9], clk);
	diff fw278(fdw5[10], fdw6[10], clk);
	diff fw279(fdw5[11], fdw6[11], clk);
	diff fw280(fdw5[12], fdw6[12], clk);
	diff fw281(fdw5[13], fdw6[13], clk);
	diff fw282(fdw5[14], fdw6[14], clk);
	diff fw283(fdw5[15], fdw6[15], clk);
	diff fw284(fdw5[16], fdw6[16], clk);
	diff fw285(fdw5[17], fdw6[17], clk);
	diff fw286(fdw5[18], fdw6[18], clk);
	diff fw287(fdw5[19], fdw6[19], clk);
	diff fw288(fdw5[20], fdw6[20], clk);
	diff fw289(fdw5[21], fdw6[21], clk);
	diff fw290(fdw5[22], fdw6[22], clk);
	diff fw291(fdw5[23], fdw6[23], clk);
	diff fw292(fdw5[24], fdw6[24], clk);
	diff fw293(fdw5[25], fdw6[25], clk);
	diff fw294(fdw5[26], fdw6[26], clk);
	diff fw295(fdw5[27], fdw6[27], clk);
	diff fw296(fdw5[28], fdw6[28], clk);
	diff fw297(fdw5[29], fdw6[29], clk);
	diff fw298(fdw5[30], fdw6[30], clk);
	diff fw299(fdw5[31], fdw6[31], clk);
	diff fw300(fdw, cout, clk);

	diff dex0(p5[0], p6[0], clk);
	diff dex1(p5[1], p6[1], clk);
	diff dex2(p5[2], p6[2], clk);
	diff dex3(p5[3], p6[3], clk);
	diff dex4(p5[4], p6[4], clk);
	diff dex5(p5[5], p6[5], clk);
	diff dex6(p5[6], p6[6], clk);
	diff dex7(p5[7], p6[7], clk);
	diff dex8(p5[8], p6[8], clk);
	diff dex9(p5[9], p6[9], clk);
	diff dex10(p5[10], p6[10], clk);
	diff dex11(p5[11], p6[11], clk);
	diff dex12(p5[12], p6[12], clk);
	diff dex13(p5[13], p6[13], clk);
	diff dex14(p5[14], p6[14], clk);
	diff dex15(p5[15], p6[15], clk);
	diff dex16(p5[16], p6[16], clk);
	diff dex17(p5[17], p6[17], clk);
	diff dex18(p5[18], p6[18], clk);
	diff dex19(p5[19], p6[19], clk);
	diff dex20(p5[20], p6[20], clk);
	diff dex21(p5[21], p6[21], clk);
	diff dex22(p5[22], p6[22], clk);
	diff dex23(p5[23], p6[23], clk);
	diff dex24(p5[24], p6[24], clk);
	diff dex25(p5[25], p6[25], clk);
	diff dex26(p5[26], p6[26], clk);
	diff dex27(p5[27], p6[27], clk);
	diff dex28(p5[28], p6[28], clk);
	diff dex29(p5[29], p6[29], clk);
	diff dex30(p5[30], p6[30], clk);
	diff dex31(p5[31], p6[31], clk);

	assign s = p6 ^ fdw6;
	//assign s = y;

endmodule // pipeline_prefix32