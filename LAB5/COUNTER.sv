	module COUNTER
	(
		input 	logic clk, rst,
		input		logic [4:0] ADDRESS,
		output	logic [4:0] data_out
	);
	//
	reg [4:0] data ; 
	//
	always @(posedge clk) 
	begin
		if(rst == 1'b1 ) 
			begin
			data = 5'b00000;
			end
		else 
			begin
			data = ADDRESS;
			data = data + 1'b1;
			end
	end
	//
	assign  data_out = data; 
	endmodule : COUNTER