module LAB2_EX1_WRAPPER
(
	input logic [1:0] KEY,
	input logic SW[1:0],
	output logic [9:0] LEDR
);

LAB2_EX1 lab2ex1
(
	.sys_clk(KEY[1]),
	.sys_reset(KEY[0]),
	.W(SW[0]),
	.Z(LEDR[9]),
	.State(LEDR[8:0])
);

endmodule