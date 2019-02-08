/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Adder
	Module : Detect One
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module detectone(ma1, ma2, pos, clk);

	input [31:0]ma1;
	output reg [31:0]ma2;
	input clk;
	output reg [7:0]pos;
	integer i, j;

	always@ (ma1)
	begin
		j = 0;
		for(i = 0; i <= 31; i = i + 1)
		begin
			if(ma1[i] == 1)
			j = i;
		end

		pos = j;
		j = j - 1;
		ma2 = 0;

		for(i = 31; i >= 0 && j >= 0; i = i - 1)
		begin
			ma2[i] = ma1[j];
			j = j - 1;
		end
	end

endmodule // detectone