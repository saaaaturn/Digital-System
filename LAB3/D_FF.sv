module D_FF 
#(parameter WIDTH=8)
(
	input logic clk, rst, E,
	input logic [WIDTH-1:0] data_i,
	output logic [WIDTH-1:0] data_o
);
reg [WIDTH-1:0] data;
always@ (posedge clk or negedge rst) begin
	if (~rst) begin
		data <= 8'b00000000;
		end 
	else if (E) begin
		data <= data_i;
		end
end
assign data_o=data;
endmodule : D_FF