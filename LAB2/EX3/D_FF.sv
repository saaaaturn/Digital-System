module D_FF
(
	input logic pre_set,
	input logic clk,
	input logic rst,
	input logic D,
	output logic Q
);

always_ff @(posedge clk or negedge rst)
begin 
	if (!rst)
	Q<= 1'b0;
	else if (pre_set)
	Q<= 1'b1;
	else 
	Q<= D;
end 
endmodule