module D_FF_16B
(
	input logic clk,
	input logic rst,
	input logic [15:0]D,
	output logic [15:0]Q
);

always_ff @(posedge clk or posedge rst)
begin 
	if (rst)
	Q<= 16'b0;
	else 
	Q<= D;
end 
endmodule