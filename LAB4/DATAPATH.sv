module DATAPATH
(
	//input
	input 	logic [8:0] din,
	input 	logic clk, reset,
	input 	logic R0i, R1i, R2i, R3i, R4i, R5i, R6i, R7i,
	input 	logic R0o, R1o, R2o, R3o, R4o, R5o, R6o, R7o,
	input		logic A_in, addsub, G_in, G_out, DIN_out, IR_in,
	//output
	output 	logic [8:0] R0data, R1data, R2data, R3data, R4data, R5data, R6data, R7data, 
	output 	logic [8:0] IRdata,
	output 	logic [8:0] bus
);
//DECLARE

wire [8:0] Adata, ASdata, Gdata;
reg  [9:0] mux_select;
assign mux_select = {R0o, R1o, R2o, R3o, R4o, R5o, R6o, R7o, G_out, DIN_out};
//
REGISTER	IRregister
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(IR_in),
	.data_in		(din),
	//output
	.data_out	(IRdata)
);
//
REGISTER	r0register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R0i),
	.data_in		(bus),
	//output
	.data_out	(R0data)
);
//
REGISTER	r1register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R1i),
	.data_in		(bus),
	//output
	.data_out	(R1data)
);
//
REGISTER	r2register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R2i),
	.data_in		(bus),
	//output
	.data_out	(R2data)
);
//
REGISTER	r3register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R3i),
	.data_in		(bus),
	//output
	.data_out	(R3data)
);
//
REGISTER	r4register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R4i),
	.data_in		(bus),
	//output
	.data_out	(R4data)
);
//
REGISTER	r5register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R5i),
	.data_in		(bus),
	//output
	.data_out	(R5data)
);
//
REGISTER	r6register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R6i),
	.data_in		(bus),
	//output
	.data_out	(R6data)
);
//
REGISTER	r7register
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(R7i),
	.data_in		(bus),
	//output
	.data_out	(R7data)
);
//
REGISTER	Ainregister
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(A_in),
	.data_in		(bus),
	//output
	.data_out	(Adata)
);
//
REGISTER	Gregister
(
	//input
	.clk			(clk), 
	.reset		(reset), 
	.en			(G_in),
	.data_in		(ASdata),
	//output
	.data_out	(Gdata)
);
//
AS9B	calculating
(
	//input
	.A				(Adata),
	.B				(bus),				
	.op			(addsub),
	//output
	.as_result	(ASdata)		
);
//
MULTIPLEXER	mux_work
(
	//data in
	.din			(din),
	.g				(Gdata),
	.r0			(R0data),
	.r1			(R1data),
	.r2			(R2data),
	.r3			(R3data),
	.r4			(R4data),
	.r5			(R5data),
	.r6			(R6data),
	.r7			(R7data),
	//select
	.select_mux	(mux_select),		//R0o, R1o, R2o, R3o, R4o, R5o, R6o, R7o, G_out, DIN_out
	//ouput
	.bus			(bus)
);
endmodule : DATAPATH