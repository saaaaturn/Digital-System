module COUNTER 
(
	input logic [2:0] mlength,
	input logic rst, load_sig, half_clk, shift_sig,
	output logic [2:0] new_len
);

always_ff @(posedge half_clk, negedge rst) begin
	if (~rst) begin
		new_len = 3'b000;
		end
	else	if (load_sig) begin
		new_len = mlength;
		end
				else if (shift_sig) begin 
						new_len = new_len - 1'b1;
						end
end

endmodule : COUNTER