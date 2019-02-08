/*
Computer Architecture Lab 3 - 15-01-2018
	Assignment : Direct Mapped Cache
					Byte addressable Cache with direct mapping to the Memory
					Physical Address of 32 bits (2^32 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^8 Byte	x	2^24 Lines
					Cache Size	: 2^8 Byte	x	2^8 Cache Blocks
					Cache to Memory Mapping Ratio : 1 : 2^16

	Module : 16b Comparator for tag
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module comparator(tag1, tag2, out, chk);

	input [15:0]tag1;
	input [15:0]tag2;
	output reg out;
	output reg chk;

	always@ *
	begin
		if(tag1 == tag2)
			out = 1'b1;
		else
			out = 1'b0;
		chk = 1'b1;
	end

endmodule // comparator