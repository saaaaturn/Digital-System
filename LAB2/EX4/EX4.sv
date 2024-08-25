module EX4 
(
	input logic [2:0] SW,
	input logic [1:0] KEY,
	input logic CLOCK_50,
	output logic [9:0] LEDR
);
//
logic [3:0] mc;							//morse code
logic [2:0] ml;							//morse length
logic load, rst, data1, dis_sig, k1;
logic clk, shift;
logic enable;
logic [2:0] new_ml;
logic [3:0] new_mc;
assign rst = KEY[0];
assign load = KEY[1];
//
DECODER decode 
(
	.sw(SW[2:0]), 
	.mcode(mc), 
	.mlength(ml)
);
//
COUNTER count_down
(
	.mlength(ml), 
	.rst(rst), 
	.load_sig(load1), 
	.shift_sig(shift), 
	.half_clk(CLOCK_50), 
	.new_len(new_ml)
);

//
REGISTER register 
(
	.mcode(mc), 
	.rst(rst), 
	.load_sig(load1), 
	.half_clk(CLOCK_50), 
	.shift_sig(shift), 
	.blink(data1), 
	.new_mc(new_mc)
);
//
FSM fsm 
(
	.CLOCK_50(CLOCK_50), 
	.rst(rst), 
	.dis(dis_sig), 
	.load_i(load), 
	.shift_o(shift), 
	.new_len(new_ml), 
	.k(k1), 
	.state(LEDR[3:2]), 
	.load_o(load1)
);
//
assign LEDR[0] = dis_sig & (~data1); 	// dot
assign LEDR[1] = dis_sig & data1; 		// dash

endmodule : EX4