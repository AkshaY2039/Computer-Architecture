/*
Computer Architecture Lab 4 - 22-01-2018
	Assignment : 2 way Set Associative Mapped Cache
					Byte addressable Cache with Set Associative mapping to the Memory
					Physical Address of 12 bits (2^12 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^4 Byte	x	2^8 Lines
					Cache Size	: 2^4 Byte	x	2^4 Cache Blocks

	Test Bench fot Set Associative Mapped Cache
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module set_associative_cache_tb ();

	reg clk;
	reg enable;
	reg [11:0]addr;

	wire [127:0]line;
	wire hit;
	wire [7:0]ByTe;

	set_associative_cache sac(addr, clk, enable, line, hit, ByTe);

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
		addr = 12'b11111_111_0000;
		enable = 1'b1;
		#5
		addr = 12'b00000_001_1111;
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

endmodule // set_associative_cache_tb

