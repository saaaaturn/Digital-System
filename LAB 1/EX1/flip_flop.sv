module D_FF_8B
(
	input logic clk,
	input logic rst,
	input logic [7:0]D,
	output logic [7:0]Q
);
reg [7:0] data;
always_ff @(posedge clk or negedge rst)
begin 
	if (!rst)
	data<= 8'b0;
	else 
	data <= D;
end 
assign Q = data;
endmodule
