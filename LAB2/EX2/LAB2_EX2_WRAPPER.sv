module LAB2_EX2_WRAPPER
(
	input logic [1:0] KEY,
	input logic SW[1:0],
	output logic [9:0] LEDR
);

LAB2_EX2 lab2ex2
(
	.sys_clock(KEY[1]),
	.sys_reset(KEY[0]),
	.W(SW[0]),
	.Z(LEDR[9]),
	.Signals(LEDR[8:0])
);

endmodule