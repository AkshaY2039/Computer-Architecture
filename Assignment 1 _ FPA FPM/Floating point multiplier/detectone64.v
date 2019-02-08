/*
Computer Architecture Lab 2 - 08-01-2018
	Assignment : Floating Point Multiplier
	Module : DetectOne (Detect preceeding 1 and normalize)
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module detectone64(ma1, ma2, pos, clk);

	input [63:0]ma1;
	output reg [63:0]ma2;
	input clk;
	output reg [7:0]pos;
	integer i, j;

	always@ (ma1)
	begin
		j=0;
		for(i = 0; i <=63; i = i + 1)
		begin
			if(ma1[i] == 1'd1)
				j = i;
		end

		pos = j;
		j = j - 1;
		ma2 = 64'd0;

		for(i = 63; i >= 0 && j >= 0; i = i - 1)
		begin
			ma2[i] = ma1[j];
			j = j - 1;
		end
	end

endmodule // detectone64