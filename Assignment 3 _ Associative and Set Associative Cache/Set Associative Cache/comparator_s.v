/*
Computer Architecture Lab 4 - 22-01-2018
	Assignment : 2 way Set Associative Mapped Cache
					Byte addressable Cache with Set Associative mapping to the Memory
					Physical Address of 12 bits (2^12 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^4 Byte	x	2^8 Lines
					Cache Size	: 2^4 Byte	x	2^4 Cache Blocks

	Module : 4b comparator for tag
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module comparator_s(tag1, tag2, out);

	input [4:0]tag1;
	input [4:0]tag2;
	output reg out;
	output reg chk;

	always@ *
	begin
		if(tag1 == tag2)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule // comparator_s