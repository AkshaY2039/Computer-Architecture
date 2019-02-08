/*
Computer Architecture Lab 4 - 22-01-2018
	Assignment : 2 way Set Associative Mapped Cache
					Byte addressable Cache with Set Associative mapping to the Memory
					Physical Address of 12 bits (2^12 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^4 Byte	x	2^8 Lines
					Cache Size	: 2^4 Byte	x	2^4 Cache Blocks

	Module : Offset_2_Byte (converting 4 bit Block Offest to required byte)
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module Offset_2_Byte (line, Block_Offset, ByTe);

	input [3:0]Block_Offset;
	input [127:0]line;
	output reg [7:0]ByTe;

	wire [7:0]line_segment[15:0];

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

	always@ *
	begin
		ByTe = line_segment[Block_Offset];
	end

endmodule // Offset_2_Byte