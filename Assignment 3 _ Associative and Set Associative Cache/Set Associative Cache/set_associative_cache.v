/*
Computer Architecture Lab 4 - 22-01-2018
	Assignment : 2 way Set Associative Mapped Cache
					Byte addressable Cache with Set Associative mapping to the Memory
					Physical Address of 12 bits (2^12 Bytes) in Main Memory
									Width	x	Depth
					Memory Size	: 2^4 Byte	x	2^8 Lines
					Cache Size	: 2^4 Byte	x	2^4 Cache Blocks

	Module : Set Associative Mapped Cache
		-- Eshita Arza	(COE15B013)
		-- Akshay Kumar	(CED15I031)
*/

module set_associative_cache(addr, clk, enable, line, chk_hit, ByTe);

	input [11:0]addr;
	input clk;
	input enable;

	output reg [127:0]line; //required block from the cache memory
	output [7:0]ByTe;
	output reg chk_hit; //1 if a hit occurs else 0

	reg [127:0]mem_line[255:0]; //main memory  - 2 pow 12 bytes
	reg [127:0]cache_line[15:0]; //cache memory - 256 bytes
	reg [4:0]tag_array[15:0];  //tag array
	reg [2:0]set_blk;
	reg [7:0]map_line;
	reg [4:0]random;

	wire [1:0]hit;
	wire [3:0]Block_Offset;
	wire [2:0]set_offset;
	wire [4:0]tag_inp;
	wire [7:0]line_addr; 

	integer i, j, k, rand, temp, rand1, rand2, set, tag1, tag2;

	always@(enable)
	begin
		for(i = 0; i < 256; ++i)
			mem_line[i] = i;
	end

//mapping from main memory to cache
	always@(enable)
	begin
		rand = 31;
		for(j = 0; j < 8; ++j) //j here is the set
			begin
			//first line in the set_block
				random = $random(rand); //chooses a value in between 0 and rand
				rand1 = random;
				set_blk = j;

				j = j * 2;

				map_line[2:0] = set_blk[2:0];
				map_line[7:3] = random[4:0];
				tag_array[j][4:0] = map_line[7:3];
				temp = map_line;
				cache_line[j] = mem_line[temp];

			//second line in the set block
				j = j + 1;

				rand2 = rand1 + 1;
				random[4:0] = rand2;

				map_line[7:3] = random[4:0];
				tag_array[j][4:0] = map_line[7:3];
				temp = map_line;
				cache_line[j] = mem_line[temp];
			end
	end

	assign line_addr[7:0] = addr[11:4];
	assign tag_inp[4:0] = addr[11:7];
	assign set_offset[2:0] = addr[6:4];
	assign Block_Offset[3:0] = addr[3:0];

	//or here we can do left shifting by two times, and adding one
	always@(posedge clk)
	begin
		set = set_offset;
		tag1 = set * 2;
		tag2 = set * 2 + 1;
	end

	//comparator for set associative, tag input is of 5 bits
	comparator_s c0(tag_inp, tag_array[tag1], hit[0]);
	comparator_s c1(tag_inp, tag_array[tag2], hit[1]);


	always@(negedge clk)
	begin
		k = line_addr;
		chk_hit = hit[0] | hit[1];

		if(chk_hit == 1'b1)
		begin
		 	if(hit[0] == 1'b1)
		 		line[127:0] = cache_line[tag1][127:0];
		 	else if(hit[1] == 1'b1)
		 		line[127:0] = cache_line[tag2][127:0];
		end 
		else if(chk_hit == 1'b0) 
		begin
		 	cache_line[tag1][127:0] = mem_line[k][127:0];
		 	tag_array[tag1] = tag_inp;
		 	line[127:0] = cache_line[tag1][127:0];
		 end
	end

	Offset_2_Byte b(line, Block_Offset, ByTe);

endmodule // set_associative_cache