module normal_exp (
	input logic [2:0] bigger_exp,
	input logic e,
	input logic [2:0] shift_counter,
	output logic [2:0] final_exp
);
logic [2:0] N;
assign N = shift_counter;

always @(*) begin
	if (e == 1'b1) begin
		final_exp = bigger_exp + 1;
		end
	else begin
		final_exp = bigger_exp - N;
		end
end
endmodule 