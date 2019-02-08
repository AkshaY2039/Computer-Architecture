/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Test Bench for Floating Point Adder
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module floating_adder_tb1();

	reg [31:0]a, b;
	reg clk;
	output [31:0]out;
	output cout;

	floating_adder fa1(a, b, out, clk, cout);
		
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
		b = 32'b1_10000000_11000000000000000000000;
		a = 32'b1_10000000_00000000000000000000000;
	end
	//0_01111110_00000000000000000000000
	//0_01111111_01100110011001100110011
	initial
	begin 
		#100 $finish;
	end

	initial 
	begin
		$monitor("time = ", $time ," a = %b ,b = %b ,c = %b, cout = %b", a, b, out, cout);
	end

endmodule // floating_adder_tb1