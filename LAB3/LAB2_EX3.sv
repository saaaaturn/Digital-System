module LAB2_EX3
(
	input logic W,
	input logic sys_clk,
	input logic [3:0]sys_preset,
	input logic sys_reset,
	output logic [3:0]L,
	output logic Z
);
wire outp1, outp2;
wire Q1_to_D2;
wire Q2_to_D3;
wire Q3_to_D4;
//D_FF no.1
D_FF FF1
(
	.pre_set(sys_preset[3]),
	.clk(sys_clk),
	.rst(sys_reset),
	.D(W),
	.Q(Q1_to_D2)
);
//D_FF no.2
D_FF FF2
(
	.pre_set(sys_preset[2]),
	.clk(sys_clk),
	.rst(sys_reset),
	.D(Q1_to_D2),
	.Q(Q2_to_D3)
);
//D_FF no.3
D_FF FF3
(
	.pre_set(sys_preset[1]),
	.clk(sys_clk),
	.rst(sys_reset),
	.D(Q2_to_D3),
	.Q(Q3_to_D4)
);
//D_FF no.4
D_FF FF4
(
	.pre_set(sys_preset[0]),
	.clk(sys_clk),
	.rst(sys_reset),
	.D(Q3_to_D4),
	.Q(L[0])
);

assign L[3] = Q1_to_D2;
assign L[2] = Q2_to_D3;
assign L[1] = Q3_to_D4;
assign outp1 = L[0] ~^ L[2];
assign outp2 = L[1] ~^ L[3];
assign Z = outp1 & outp2;
endmodule