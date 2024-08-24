module LAB1_WRAPPER (
	input logic [7:0] SW,
	input logic [1:0]KEY,
	output logic [9:0] LEDR,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3
);

assign LEDR[7:0] = SW [7:0];
wire [7:0] sum, A;
assign A = SW;

LAB1 lab1ex1 (
	.data_in(A), 
	.data_out(sum), 
	.carry_flag(LEDR[8]), 
	.overflow_flag(LEDR[9]), 
	.clk_system(KEY[1]), 
	.rst_system(KEY[0])
);
SEVEN_SEGS displayhex2 (.data_in(A[3:0]), .display_out(HEX2));
SEVEN_SEGS displayhex3 (.data_in(A[7:4]), .display_out(HEX3));
SEVEN_SEGS displayhex0 (.data_in(sum[3:0]), .display_out(HEX0));
SEVEN_SEGS displayhex1 (.data_in(sum[7:4]), .display_out(HEX1));
endmodule