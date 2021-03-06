/*
Computer Architecture Lab 3 - 15-01-2018
	Assignment : Direct Mapped Cache
					Byte addressable Cache with direct mapping to the Memory
					Physical Address of 32 bits (2^32 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^8 Byte	x	2^24 Lines
					Cache Size	: 2^8 Byte	x	2^8 Cache Blocks
					Cache to Memory Mapping Ratio : 1 : 2^16

	Module : Offset_2_Byte (converting 8 bit Block Offest to required byte)
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module Offset_2_Byte (line, Block_Offset, ByTe);

	input [7:0]Block_Offset;
	input [2047:0]line;
	output reg [7:0]ByTe;

	wire [7:0]line_segment[255:0];

	assign line_segment[0][7:0] = line[7:0];
	assign line_segment[1][7:0] = line[15:8];
	assign line_segment[2][7:0] = line[23:16];
	assign line_segment[3][7:0] = line[31:24];
	assign line_segment[4][7:0] = line[39:32];
	assign line_segment[5][7:0] = line[47:40];
	assign line_segment[6][7:0] = line[55:48];
	assign line_segment[7][7:0] = line[63:56];
	assign line_segment[8][7:0] = line[71:64];
	assign line_segment[9][7:0] = line[79:72];
	assign line_segment[10][7:0] = line[87:80];
	assign line_segment[11][7:0] = line[95:88];
	assign line_segment[12][7:0] = line[103:96];
	assign line_segment[13][7:0] = line[111:104];
	assign line_segment[14][7:0] = line[119:112];
	assign line_segment[15][7:0] = line[127:120];
	assign line_segment[16][7:0] = line[135:128];
	assign line_segment[17][7:0] = line[143:136];
	assign line_segment[18][7:0] = line[151:144];
	assign line_segment[19][7:0] = line[159:152];
	assign line_segment[20][7:0] = line[167:160];
	assign line_segment[21][7:0] = line[175:168];
	assign line_segment[22][7:0] = line[183:176];
	assign line_segment[23][7:0] = line[191:184];
	assign line_segment[24][7:0] = line[199:192];
	assign line_segment[25][7:0] = line[207:200];
	assign line_segment[26][7:0] = line[215:208];
	assign line_segment[27][7:0] = line[223:216];
	assign line_segment[28][7:0] = line[231:224];
	assign line_segment[29][7:0] = line[239:232];
	assign line_segment[30][7:0] = line[247:240];
	assign line_segment[31][7:0] = line[255:248];
	assign line_segment[32][7:0] = line[263:256];
	assign line_segment[33][7:0] = line[271:264];
	assign line_segment[34][7:0] = line[279:272];
	assign line_segment[35][7:0] = line[287:280];
	assign line_segment[36][7:0] = line[295:288];
	assign line_segment[37][7:0] = line[303:296];
	assign line_segment[38][7:0] = line[311:304];
	assign line_segment[39][7:0] = line[319:312];
	assign line_segment[40][7:0] = line[327:320];
	assign line_segment[41][7:0] = line[335:328];
	assign line_segment[42][7:0] = line[343:336];
	assign line_segment[43][7:0] = line[351:344];
	assign line_segment[44][7:0] = line[359:352];
	assign line_segment[45][7:0] = line[367:360];
	assign line_segment[46][7:0] = line[375:368];
	assign line_segment[47][7:0] = line[383:376];
	assign line_segment[48][7:0] = line[391:384];
	assign line_segment[49][7:0] = line[399:392];
	assign line_segment[50][7:0] = line[407:400];
	assign line_segment[51][7:0] = line[415:408];
	assign line_segment[52][7:0] = line[423:416];
	assign line_segment[53][7:0] = line[431:424];
	assign line_segment[54][7:0] = line[439:432];
	assign line_segment[55][7:0] = line[447:440];
	assign line_segment[56][7:0] = line[455:448];
	assign line_segment[57][7:0] = line[463:456];
	assign line_segment[58][7:0] = line[471:464];
	assign line_segment[59][7:0] = line[479:472];
	assign line_segment[60][7:0] = line[487:480];
	assign line_segment[61][7:0] = line[495:488];
	assign line_segment[62][7:0] = line[503:496];
	assign line_segment[63][7:0] = line[511:504];
	assign line_segment[64][7:0] = line[519:512];
	assign line_segment[65][7:0] = line[527:520];
	assign line_segment[66][7:0] = line[535:528];
	assign line_segment[67][7:0] = line[543:536];
	assign line_segment[68][7:0] = line[551:544];
	assign line_segment[69][7:0] = line[559:552];
	assign line_segment[70][7:0] = line[567:560];
	assign line_segment[71][7:0] = line[575:568];
	assign line_segment[72][7:0] = line[583:576];
	assign line_segment[73][7:0] = line[591:584];
	assign line_segment[74][7:0] = line[599:592];
	assign line_segment[75][7:0] = line[607:600];
	assign line_segment[76][7:0] = line[615:608];
	assign line_segment[77][7:0] = line[623:616];
	assign line_segment[78][7:0] = line[631:624];
	assign line_segment[79][7:0] = line[639:632];
	assign line_segment[80][7:0] = line[647:640];
	assign line_segment[81][7:0] = line[655:648];
	assign line_segment[82][7:0] = line[663:656];
	assign line_segment[83][7:0] = line[671:664];
	assign line_segment[84][7:0] = line[679:672];
	assign line_segment[85][7:0] = line[687:680];
	assign line_segment[86][7:0] = line[695:688];
	assign line_segment[87][7:0] = line[703:696];
	assign line_segment[88][7:0] = line[711:704];
	assign line_segment[89][7:0] = line[719:712];
	assign line_segment[90][7:0] = line[727:720];
	assign line_segment[91][7:0] = line[735:728];
	assign line_segment[92][7:0] = line[743:736];
	assign line_segment[93][7:0] = line[751:744];
	assign line_segment[94][7:0] = line[759:752];
	assign line_segment[95][7:0] = line[767:760];
	assign line_segment[96][7:0] = line[775:768];
	assign line_segment[97][7:0] = line[783:776];
	assign line_segment[98][7:0] = line[791:784];
	assign line_segment[99][7:0] = line[799:792];
	assign line_segment[100][7:0] = line[807:800];
	assign line_segment[101][7:0] = line[815:808];
	assign line_segment[102][7:0] = line[823:816];
	assign line_segment[103][7:0] = line[831:824];
	assign line_segment[104][7:0] = line[839:832];
	assign line_segment[105][7:0] = line[847:840];
	assign line_segment[106][7:0] = line[855:848];
	assign line_segment[107][7:0] = line[863:856];
	assign line_segment[108][7:0] = line[871:864];
	assign line_segment[109][7:0] = line[879:872];
	assign line_segment[110][7:0] = line[887:880];
	assign line_segment[111][7:0] = line[895:888];
	assign line_segment[112][7:0] = line[903:896];
	assign line_segment[113][7:0] = line[911:904];
	assign line_segment[114][7:0] = line[919:912];
	assign line_segment[115][7:0] = line[927:920];
	assign line_segment[116][7:0] = line[935:928];
	assign line_segment[117][7:0] = line[943:936];
	assign line_segment[118][7:0] = line[951:944];
	assign line_segment[119][7:0] = line[959:952];
	assign line_segment[120][7:0] = line[967:960];
	assign line_segment[121][7:0] = line[975:968];
	assign line_segment[122][7:0] = line[983:976];
	assign line_segment[123][7:0] = line[991:984];
	assign line_segment[124][7:0] = line[999:992];
	assign line_segment[125][7:0] = line[1007:1000];
	assign line_segment[126][7:0] = line[1015:1008];
	assign line_segment[127][7:0] = line[1023:1016];
	assign line_segment[128][7:0] = line[1031:1024];
	assign line_segment[129][7:0] = line[1039:1032];
	assign line_segment[130][7:0] = line[1047:1040];
	assign line_segment[131][7:0] = line[1055:1048];
	assign line_segment[132][7:0] = line[1063:1056];
	assign line_segment[133][7:0] = line[1071:1064];
	assign line_segment[134][7:0] = line[1079:1072];
	assign line_segment[135][7:0] = line[1087:1080];
	assign line_segment[136][7:0] = line[1095:1088];
	assign line_segment[137][7:0] = line[1103:1096];
	assign line_segment[138][7:0] = line[1111:1104];
	assign line_segment[139][7:0] = line[1119:1112];
	assign line_segment[140][7:0] = line[1127:1120];
	assign line_segment[141][7:0] = line[1135:1128];
	assign line_segment[142][7:0] = line[1143:1136];
	assign line_segment[143][7:0] = line[1151:1144];
	assign line_segment[144][7:0] = line[1159:1152];
	assign line_segment[145][7:0] = line[1167:1160];
	assign line_segment[146][7:0] = line[1175:1168];
	assign line_segment[147][7:0] = line[1183:1176];
	assign line_segment[148][7:0] = line[1191:1184];
	assign line_segment[149][7:0] = line[1199:1192];
	assign line_segment[150][7:0] = line[1207:1200];
	assign line_segment[151][7:0] = line[1215:1208];
	assign line_segment[152][7:0] = line[1223:1216];
	assign line_segment[153][7:0] = line[1231:1224];
	assign line_segment[154][7:0] = line[1239:1232];
	assign line_segment[155][7:0] = line[1247:1240];
	assign line_segment[156][7:0] = line[1255:1248];
	assign line_segment[157][7:0] = line[1263:1256];
	assign line_segment[158][7:0] = line[1271:1264];
	assign line_segment[159][7:0] = line[1279:1272];
	assign line_segment[160][7:0] = line[1287:1280];
	assign line_segment[161][7:0] = line[1295:1288];
	assign line_segment[162][7:0] = line[1303:1296];
	assign line_segment[163][7:0] = line[1311:1304];
	assign line_segment[164][7:0] = line[1319:1312];
	assign line_segment[165][7:0] = line[1327:1320];
	assign line_segment[166][7:0] = line[1335:1328];
	assign line_segment[167][7:0] = line[1343:1336];
	assign line_segment[168][7:0] = line[1351:1344];
	assign line_segment[169][7:0] = line[1359:1352];
	assign line_segment[170][7:0] = line[1367:1360];
	assign line_segment[171][7:0] = line[1375:1368];
	assign line_segment[172][7:0] = line[1383:1376];
	assign line_segment[173][7:0] = line[1391:1384];
	assign line_segment[174][7:0] = line[1399:1392];
	assign line_segment[175][7:0] = line[1407:1400];
	assign line_segment[176][7:0] = line[1415:1408];
	assign line_segment[177][7:0] = line[1423:1416];
	assign line_segment[178][7:0] = line[1431:1424];
	assign line_segment[179][7:0] = line[1439:1432];
	assign line_segment[180][7:0] = line[1447:1440];
	assign line_segment[181][7:0] = line[1455:1448];
	assign line_segment[182][7:0] = line[1463:1456];
	assign line_segment[183][7:0] = line[1471:1464];
	assign line_segment[184][7:0] = line[1479:1472];
	assign line_segment[185][7:0] = line[1487:1480];
	assign line_segment[186][7:0] = line[1495:1488];
	assign line_segment[187][7:0] = line[1503:1496];
	assign line_segment[188][7:0] = line[1511:1504];
	assign line_segment[189][7:0] = line[1519:1512];
	assign line_segment[190][7:0] = line[1527:1520];
	assign line_segment[191][7:0] = line[1535:1528];
	assign line_segment[192][7:0] = line[1543:1536];
	assign line_segment[193][7:0] = line[1551:1544];
	assign line_segment[194][7:0] = line[1559:1552];
	assign line_segment[195][7:0] = line[1567:1560];
	assign line_segment[196][7:0] = line[1575:1568];
	assign line_segment[197][7:0] = line[1583:1576];
	assign line_segment[198][7:0] = line[1591:1584];
	assign line_segment[199][7:0] = line[1599:1592];
	assign line_segment[200][7:0] = line[1607:1600];
	assign line_segment[201][7:0] = line[1615:1608];
	assign line_segment[202][7:0] = line[1623:1616];
	assign line_segment[203][7:0] = line[1631:1624];
	assign line_segment[204][7:0] = line[1639:1632];
	assign line_segment[205][7:0] = line[1647:1640];
	assign line_segment[206][7:0] = line[1655:1648];
	assign line_segment[207][7:0] = line[1663:1656];
	assign line_segment[208][7:0] = line[1671:1664];
	assign line_segment[209][7:0] = line[1679:1672];
	assign line_segment[210][7:0] = line[1687:1680];
	assign line_segment[211][7:0] = line[1695:1688];
	assign line_segment[212][7:0] = line[1703:1696];
	assign line_segment[213][7:0] = line[1711:1704];
	assign line_segment[214][7:0] = line[1719:1712];
	assign line_segment[215][7:0] = line[1727:1720];
	assign line_segment[216][7:0] = line[1735:1728];
	assign line_segment[217][7:0] = line[1743:1736];
	assign line_segment[218][7:0] = line[1751:1744];
	assign line_segment[219][7:0] = line[1759:1752];
	assign line_segment[220][7:0] = line[1767:1760];
	assign line_segment[221][7:0] = line[1775:1768];
	assign line_segment[222][7:0] = line[1783:1776];
	assign line_segment[223][7:0] = line[1791:1784];
	assign line_segment[224][7:0] = line[1799:1792];
	assign line_segment[225][7:0] = line[1807:1800];
	assign line_segment[226][7:0] = line[1815:1808];
	assign line_segment[227][7:0] = line[1823:1816];
	assign line_segment[228][7:0] = line[1831:1824];
	assign line_segment[229][7:0] = line[1839:1832];
	assign line_segment[230][7:0] = line[1847:1840];
	assign line_segment[231][7:0] = line[1855:1848];
	assign line_segment[232][7:0] = line[1863:1856];
	assign line_segment[233][7:0] = line[1871:1864];
	assign line_segment[234][7:0] = line[1879:1872];
	assign line_segment[235][7:0] = line[1887:1880];
	assign line_segment[236][7:0] = line[1895:1888];
	assign line_segment[237][7:0] = line[1903:1896];
	assign line_segment[238][7:0] = line[1911:1904];
	assign line_segment[239][7:0] = line[1919:1912];
	assign line_segment[240][7:0] = line[1927:1920];
	assign line_segment[241][7:0] = line[1935:1928];
	assign line_segment[242][7:0] = line[1943:1936];
	assign line_segment[243][7:0] = line[1951:1944];
	assign line_segment[244][7:0] = line[1959:1952];
	assign line_segment[245][7:0] = line[1967:1960];
	assign line_segment[246][7:0] = line[1975:1968];
	assign line_segment[247][7:0] = line[1983:1976];
	assign line_segment[248][7:0] = line[1991:1984];
	assign line_segment[249][7:0] = line[1999:1992];
	assign line_segment[250][7:0] = line[2007:2000];
	assign line_segment[251][7:0] = line[2015:2008];
	assign line_segment[252][7:0] = line[2023:2016];
	assign line_segment[253][7:0] = line[2031:2024];
	assign line_segment[254][7:0] = line[2039:2032];
	assign line_segment[255][7:0] = line[2047:2040];

	always@ *
	begin
		ByTe = line_segment[Block_Offset];
	end

endmodule // Offset_2_Byte