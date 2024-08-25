module LAB5
(
	input		logic [8:0] DIN,
	input 	logic clk,reset,RUN,
	output	logic DONE,
	output 	logic [8:0] BUS,
	output 	logic [8:0] R0data, R1data, R2data, R3data, R4data, R5data, R6data, R7data, ADDRdata, DOUTdata, Wdata,
	output	logic iz,fetchz,mvz,mviz,as1z,as2z,as3z,ld1z,ld2z,ld3z,st1z,st2z,st3z,mvnzz, waitinz, incz,
	output 	logic compareg, notzero,
	output 	logic [8:0] INSTRUCTION
);
//
wire [8:0] Gdt;
wire o_r0, o_r1, o_r2, o_r3, o_r4, o_r5, o_r6,o_r7;
wire i_r0, i_r1, i_r2, i_r3, i_r4, i_r5, i_r6,i_r7;
wire ain, gin, gout, dinout, irin, incrpc, addrin, doutin, wd, counterout;
//
CONTROLLER control_unit
(
	//input
	.run(RUN), .reset(reset), .clk(clk),
	.IR(INSTRUCTION), .Gdata (Gdt),
	//output
	.R0o(o_r0), .R1o(o_r1), .R2o(o_r2), .R3o(o_r3), .R4o(o_r4), .R5o(o_r5), .R6o(o_r6), .R7o(o_r7),
	.R0i(i_r0), .R1i(i_r1), .R2i(i_r2), .R3i(i_r3), .R4i(i_r4), .R5i(i_r5), .R6i(i_r6), .R7i(i_r7),
	.A_in(ain), .addsub(as), .G_in(gin), .done(DONE), .G_out(gout), .DIN_out(dinout), .IR_in(irin),
	.incr_pc(incrpc), .ADDR_in(addrin), .DOUT_in(doutin), .W_D(wd), .compare_G(compareg), .not_zero(notzero), .counter_out(counterout),
	.iz(iz),.fetchz(fetchz),.mvz(mvz),.mviz(mviz),.as1z(as1z),.as2z(as2z),.as3z(as3z),
	.ld1z(ld1z),.ld2z(ld2z),.ld3z(ld3z),.st1z(st1z),.st2z(st2z),.st3z(st3z),.mvnzz(mvnzz), .waitinz(waitinz), .incz(incz)
);
//
DATAPATH	datapath_unit
(
	//input
	.din(DIN), .Gdata(Gdt),
	.clk(clk), .reset(reset),
	.R0i(i_r0), .R1i(i_r1), .R2i(i_r2), .R3i(i_r3), .R4i(i_r4), .R5i(i_r5), .R6i(i_r6), .R7i(i_r7),
	.R0o(o_r0), .R1o(o_r1), .R2o(o_r2), .R3o(o_r3), .R4o(o_r4), .R5o(o_r5), .R6o(o_r6), .R7o(o_r7 | counterout),
	.A_in(ain), .addsub(as), .G_in(gin), .G_out(gout), .DIN_out(dinout), .IR_in(irin),
	.incr_pc(incrpc), .ADDR_in(addrin), .DOUT_in(doutin), .W_D(wd),
	//output
	.R0data(R0data), .R1data(R1data), .R2data(R2data), .R3data(R3data), .R4data(R4data), .R5data(R5data), .R6data(R6data), .R7data(R7data), 
	.ADDRdata(ADDRdata), .DOUTdata(DOUTdata), .Wdata(Wdata),
	.IRdata(INSTRUCTION),
	.bus(BUS)
);
endmodule : LAB5