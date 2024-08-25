module TOTAL
(
	input 	logic CLK, RST, RUN,
	output 	logic DONE,
	output	logic [8:0] D_IN, BUS, R0data, R1data, R2data, R3data, R4data, R5data, R6data, R7data,
	output 	logic iz,t0z,t1z,t1az,t2z,t2az,t3z,ADDSUB,
	output 	logic [8:0] INSTRUCTION
);
//
reg [4:0] ADDRESS;
//
COUNTER counting
(
	.clk			(DONE), 
	.rst			(RST),
	.ADDRESS		(ADDRESS),
	.data_out	(ADDRESS)
);
//
MEMORY memo_block
(
	.clk			(DONE),
	.ADDRESS		(ADDRESS),
	.data			(D_IN)
);
//
LAB4 processor
(
	.DIN			(D_IN),
	.clk			(CLK),
	.reset		(RST),
	.RUN			(RUN),
	.DONE			(DONE),
	.BUS			(BUS),
	.R0data(R0data), .R1data(R1data), .R2data(R2data), .R3data(R3data), .R4data(R4data), .R5data(R5data), .R6data(R6data), .R7data(R7data),
	.iz(iz),.t0z(t0z),.t1z(t1z),.t1az(t1az),.t2z(t2z),.t2az(t2az),.t3z(t3z),.as(ADDSUB),
	.INSTRUCTION(INSTRUCTION)
);
//
endmodule : TOTAL