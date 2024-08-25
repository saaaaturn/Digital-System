module EX4 
(
	input logic [2:0] SW,
	input logic [1:0] KEY,
	input logic CLOCK_50,
	output logic [9:0] LEDR
);
//
logic [3:0] light;
logic [2:0] length;
logic load, rst, data1, dis1, k1;
logic clk, shift;
logic enable;
logic [2:0] new_s;
logic [3:0] new_d;
assign rst = KEY[0];
assign load = KEY[1];
//
DECODER decode 
(
	.in(SW[2:0]), 
	.code_o(light), 
	.size_o(length)
);
//
COUNTER count_down
(
	.size_in(length), 
	.rst(rst), 
	.load_i(load1), 
	.shift_i(shift), 
	.half_clk(CLOCK_50), 
	.new_size(new_s)
);
//
HALF_SEC hs_clk 
(
	.CLOCK_50(CLOCK_50), 
	.half_clk(clk)
);
//
REGISTER register 
(
	.code_in(light), 
	.rst(rst), 
	.load_i(load1), 
	.half_clk(CLOCK_50), 
	.shift_i(shift), 
	.data(data1), 
	.new_data(new_d)
);
//
FSM fsm 
(
	.CLOCK_50(CLOCK_50), 
	.rst(rst), 
	.dis(dis1), 
	.load_i(load), 
	.shift_o(shift), 
	.new_size(new_s), 
	.k(k1), 
	.state(LEDR[3:2]), 
	.load_o(load1)
);
//
assign LEDR[0] = dis1 & (~data1); 	// dot
assign LEDR[1] = dis1 & data1; 		// dash

endmodule : EX4