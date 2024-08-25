	module MEMORY
	(
		input logic clk,
		input logic [4:0] ADDRESS,
		output logic [8:0] data
	);
	//ROM
	MyROM rom 
	(
		.clk (clk),
		.ADDRESS (ADDRESS),
		.DATAOUT (data)
	);
	//
	endmodule : MEMORY