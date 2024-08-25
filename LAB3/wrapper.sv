module wrapper (
	input logic [9:0] SW,
	input logic [2:0] KEY,
	input logic CLOCK_50,
	output logic [9:0] LEDR
);
compute (
	.in(SW[7:0]), 
	.Cin(KEY[2]), 
	.EA(SW[8]), 
	.EB(SW[9]), 
	.clk(CLOCK_50), 
	.rst(KEY[1]), 
	.final_sign(LEDR[7]), 
	.Final_exp(LEDR[6:4]), 
	.final_fract(LEDR[3:0]), 
	.zero(LEDR[9]), 
	.overflow(LEDR[8])
);


endmodule : wrapper