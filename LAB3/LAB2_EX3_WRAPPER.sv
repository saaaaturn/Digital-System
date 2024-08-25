module LAB2_EX3_WRAPPER
(
	input logic [1:0] KEY,
	input logic [4:0]SW,
	output logic [4:0] LEDR
);
LAB2_EX3 lab2ex3
(
	.W(SW[4]),
	.sys_clk(KEY[1]),
	.sys_reset(KEY[0]),
	.sys_preset(SW[3:0]),
	.L(LEDR[3:0]),
	.Z(LEDR[4])
);
endmodule