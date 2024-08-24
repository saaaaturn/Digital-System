module EX2_WRAPPER (
	input logic [8:0] SW,
	input logic [1:0] KEY,
	output logic [9:0] LEDR,
	output logic [6:0] HEX0,HEX1,HEX2,HEX3
);
assign LEDR[7:0] = SW[7:0];
wire [7:0] sum,A,Cin;

assign A = SW;
assign Cin = SW[8];

EX2 lab1ex2 
(
	.cin(Cin), 
	.A0(A), .sum(sum), 
	.Carry(LEDR[8]), 
	.overflow(LEDR[9]), 
	.clk(KEY[1]), 
	.rst(KEY[0])
);

HEX hex2 
(
	.data_in(A[3:0]), 
	.display_out(HEX2)
);
HEX hex3 
(
	.data_in(A[7:4]), 
	.display_out(HEX3)
);
HEX hex0 
(
	.data_in(sum[3:0]), 
	.display_out(HEX0)
);
HEX hex1 
(
	.data_in(sum[7:4]), 
	.display_out(HEX1)
);

endmodule	