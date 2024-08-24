module D_FF_1B
(
	input logic clk,
	input logic rst,
	input logic D,
	output logic Q
);
reg data;
always_ff @(posedge clk or negedge rst)
begin 
	if (!rst)
	data<= 1'b0;
	else 
	data<= D;
end 
assign Q = data;
endmodule