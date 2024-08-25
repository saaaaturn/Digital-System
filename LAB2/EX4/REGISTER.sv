module REGISTER 
(
	input logic [3:0] mcode,
	input logic rst, load_sig, shift_sig, half_clk,
	output logic blink,
	output logic [3:0] new_mc
);
logic [3:0] temp;

always_ff @(posedge half_clk, negedge rst) begin
	if (~rst) begin
		new_mc = 4'bXXXX;
		end
	else	if (load_sig) begin
		new_mc = mcode;
		temp = mcode;
		end
	else if (shift_sig == 1'b1) begin
				blink  = temp[0];
				temp = temp >>1;
				new_mc = temp;
				end
end

endmodule : REGISTER