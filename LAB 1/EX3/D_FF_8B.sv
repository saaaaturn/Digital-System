module D_FF_8B
(
	input logic clk,
	input logic rst,
	input logic E_gate,
	input logic [7:0]D,
	output logic [7:0]Q
);

always_ff @(posedge clk or posedge rst )
begin 
	if (rst )
	Q<= 8'b0;
	else if (E_gate)
	Q<= D;
end 
endmodule