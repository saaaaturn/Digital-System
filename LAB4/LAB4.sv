module LAB4
(
	input		logic [8:0] DIN,
	input 	logic clk,reset,RUN,
	output	logic DONE,
	output 	logic [8:0] BUS,
	output 	logic [8:0] R0data, R1data, R2data, R3data, R4data, R5data, R6data, R7data,
	output	logic iz,t0z,t1z,t1az,t2z,t2az,t3z,as,
	output 	logic [8:0] INSTRUCTION
);
//
wire o_r0, o_r1, o_r2, o_r3, o_r4, o_r5, o_r6,o_r7;
wire i_r0, i_r1, i_r2, i_r3, i_r4, i_r5, i_r6,i_r7;
wire ain, gin, gout, dinout, irin;
//
CONTROLLER control_unit
(
	//input
	.run(RUN), .reset(reset), .clk(clk),
	.IR(INSTRUCTION),
	//output
	.R0o(o_r0), .R1o(o_r1), .R2o(o_r2), .R3o(o_r3), .R4o(o_r4), .R5o(o_r5), .R6o(o_r6), .R7o(o_r7),
	.R0i(i_r0), .R1i(i_r1), .R2i(i_r2), .R3i(i_r3), .R4i(i_r4), .R5i(i_r5), .R6i(i_r6), .R7i(i_r7),
	.A_in(ain), .addsub(as), .G_in(gin), .done(DONE), .G_out(gout), .DIN_out(dinout), .IR_in(irin),
	.iz(iz),.t0z(t0z),.t1z(t1z),.t1az(t1az),.t2z(t2z),.t2az(t2az),.t3z(t3z)
);
//
DATAPATH	datapath_unit
(
	//input
	.din(DIN),
	.clk(clk), .reset(reset),
	.R0i(i_r0), .R1i(i_r1), .R2i(i_r2), .R3i(i_r3), .R4i(i_r4), .R5i(i_r5), .R6i(i_r6), .R7i(i_r7),
	.R0o(o_r0), .R1o(o_r1), .R2o(o_r2), .R3o(o_r3), .R4o(o_r4), .R5o(o_r5), .R6o(o_r6), .R7o(o_r7),
	.A_in(ain), .addsub(as), .G_in(gin), .G_out(gout), .DIN_out(dinout), .IR_in(irin),
	//output
	.R0data(R0data), .R1data(R1data), .R2data(R2data), .R3data(R3data), .R4data(R4data), .R5data(R5data), .R6data(R6data), .R7data(R7data), 
	.IRdata(INSTRUCTION),
	.bus(BUS)
);
endmodule : LAB4