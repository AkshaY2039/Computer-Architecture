/*
Computer Architecture Lab 4 - 22-01-2018
	Assignment : Full Associative Cache
					Byte addressable Cache with Full Associative mapping to the Memory
					Physical Address of 12 bits (2^12 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^4 Byte	x	2^8 Lines
					Cache Size	: 2^4 Byte	x	2^4 Cache Blocks

	Test Bench Associative Mapped Cache
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module associative_cache_tb();

	reg clk;
	reg enable;
	reg [11:0]addr;

	wire [127:0]line;
	wire hit;
	wire [7:0]ByTe;

	associative_cache ac(addr, clk, enable, line, hit, ByTe);

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
			addr = 12'b00000000_0000;
			enable = 1'b1;
		#2
			addr = 12'b00000001_1111;
			enable = 1'b0;
	end

	initial
	begin 
		#15 $finish;
	end

	initial
	begin
		$monitor("time = ", $time, "\nclock = %b\naddr= %b\nline = %b\nByTe = %b\nhit = %b\n", clk, addr, line, ByTe, hit);
	end

endmodule // associative_cache_tb