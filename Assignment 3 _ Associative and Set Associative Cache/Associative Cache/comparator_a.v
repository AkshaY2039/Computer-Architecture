/*
Computer Architecture Lab 4 - 22-01-2018
	Assignment : Full Associative Cache
					Byte addressable Cache with Full Associative mapping to the Memory
					Physical Address of 12 bits (2^12 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^4 Byte	x	2^8 Lines
					Cache Size	: 2^4 Byte	x	2^4 Cache Blocks

	Module : 8b Comparator for tag
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module comparator_a(tag1, tag2, out);

	input [7:0]tag1;
	input [7:0]tag2;
	output reg out;
//	output reg chk;

	always@ *
	begin
		if(tag1 == tag2)
			out = 1'b1;
		else
			out = 1'b0;
		//chk = 1'b1;
	end

endmodule // comparator_a