module COUNTER_PC
(
	input		logic clk, rst,
	input 	logic incr_pc, R7_in,
	input 	logic [8:0] address_in,
	output	logic [8:0] address_out
);
//
reg [8:0] data;
//
always @(posedge clk)
begin
	if (rst)
		data = 9'b0;
	else if (incr_pc)
		data = data + 1'b1;
	else if (R7_in)
		data = address_in;
	else
		data = address_out;
end
//
assign address_out = data;
//
endmodule : COUNTER_PC