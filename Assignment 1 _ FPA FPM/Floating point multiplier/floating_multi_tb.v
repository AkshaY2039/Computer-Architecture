/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Multiplier
	Test Bench for Floating Point Multiplier
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module floating_multi_tb();

	reg [31:0]a, b;
	//wire [63:0]man;
	//wire sign;
	//wire [31:0]exp;
	wire [31:0]finalo;
	reg clk;

	floating_multi fm1(a, b, finalo, clk);

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
		#0
		a = 32'b1_01111110_00000000000000000000010;
		b = 32'b1_10000000_00000000000000000000001;
	end

	initial
	begin 
		#100 $finish;
	end

	initial 
	begin
		$monitor("time = ", $time , " a = %b , b = %b , finalo = %b, clk = %d", a, b, finalo, clk);
	end

endmodule // floating_multi_tb