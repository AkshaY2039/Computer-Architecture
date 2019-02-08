/*
Computer Architecture Lab 3 - 15-01-2018
	Assignment : Direct Mapped Cache
					Byte addressable Cache with direct mapping to the Memory
					Physical Address of 32 bits (2^32 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^8 Byte	x	2^24 Lines
					Cache Size	: 2^8 Byte	x	2^8 Cache Blocks
					Cache to Memory Mapping Ratio : 1 : 2^16

	Test Bench for Direct Mapped Cache
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module direct_cache_tb ();

	reg clk;
	reg enable;
	reg [31:0]addr;

	wire [2047:0]line;
	wire [7:0]ByTe;
	wire hit;

	direct_cache dc(clk, addr, enable, line, hit, ByTe);

	initial
	begin
		clk = 0;
	end

	always
	begin
		#1 clk = ~clk;
	end

	initial
	begin
		#1
		addr = 32'b0000000000000001_11111110_00000001;
		enable = 1'b1;
		#2
		addr = 32'b0000000000000001_11111111_00000000;
		enable = 1'b0;

//			addr = 32'b0000000000000001_11111110_11111111;
//			enable = 1'b1;
//		#2
//			addr = 32'b0000000000000001_11111111_11111111;
//			enable = 1'b0;
	end

	initial
	begin 
		#100 $finish;
	end

	initial
	begin
		$monitor("time = ", $time, "\nclock = %b\naddr= %b\nline = %b\nByTe = %b\nhit = %b\n", clk, addr, line, ByTe, hit);
	end

endmodule // direct_cache_tb