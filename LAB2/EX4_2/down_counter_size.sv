module COUNTER 
(
	input logic [2:0] size_in,
	input logic rst, load_i, half_clk, shift_i,
	output logic [2:0] new_size
);

always_ff @(posedge half_clk, negedge rst) begin
	if (~rst) begin
		new_size = 3'b000;
		end
	else	if (load_i) begin
		new_size = size_in;
		end
				else if (shift_i) begin 
						new_size = new_size - 1'b1;
						end
end

endmodule : COUNTER