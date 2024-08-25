module TOTAL
(
	input 	logic CLK, RST, RUN,
	output 	logic DONE,
	output	logic [8:0] D_IN, BUS, R0data, R1data, R2data, R3data, R4data, R5data, R6data, R7data,
	output 	logic iz,fetchz,mvz,mviz,as1z,as2z,as3z,ld1z,ld2z,ld3z,st1z,st2z,st3z,mvnzz, waitinz, incz, 
	output 	logic compareg, notzero,
	output 	logic [8:0] INSTRUCTION
);
//
reg [4:0] ADDRESS;
reg [8:0] DOUTdata, busdata;
reg [6:0] ADDRdata;
reg Wdata;
//
MyROM	memo_block
	
(
 .data_in		(DOUTdata), 
 .addr			(ADDRdata),
 .clk				(CLK),
 .Enable_W		(Wdata),
 .data_out		(D_IN)
);
//
LAB5 processor
(
	.DIN			(D_IN),
	.clk			(CLK),
	.reset		(RST),
	.RUN			(RUN),
	.DONE			(DONE),
	.BUS			(BUS),
	.R0data(R0data), .R1data(R1data), .R2data(R2data), .R3data(R3data), .R4data(R4data), .R5data(R5data), .R6data(R6data), .R7data(R7data),
	.ADDRdata(ADDRdata), .DOUTdata (DOUTdata), .Wdata(Wdata),
	.iz(iz),.fetchz(fetchz),.mvz(mvz),.mviz(mviz),.as1z(as1z),.as2z(as2z),.as3z(as3z),
	.ld1z(ld1z),.ld2z(ld2z),.ld3z(ld3z),.st1z(st1z),.st2z(st2z),.st3z(st3z),.mvnzz(mvnzz), .waitinz(waitinz), .incz(incz),
	.compareg(compareg), .notzero(notzero),
	.INSTRUCTION(INSTRUCTION)
);
endmodule : TOTAL