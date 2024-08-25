module D_FF_Y0
(
	input logic clk,
	input logic rst,
	input logic D,
	output logic Q
);
reg data;
assign Q = data;
always_ff @(posedge clk or negedge rst)
begin 
	if (!rst)
	data<= 1'b1;
	else 
	data<= D;
end 
endmodule