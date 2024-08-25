module shifter_left (
	input logic enable,
	input logic [2:0] sel,
	input logic [7:0] ff,
	output logic [3:0] normal_fract
);
always @(*) begin
	if (~enable) begin
		unique case (sel)
			3'b000: normal_fract = ff[5:2];
			3'b001: normal_fract = ff[4:1];
			3'b010: normal_fract = ff[3:0];
			3'b011: normal_fract = {ff[2:0], 1'b0};
			3'b100: normal_fract = {ff[1:0], 2'b00};
			3'b101: normal_fract = {ff[0], 3'b000};
			3'b110: normal_fract = 4'b0000;
		endcase
		end
	else if (enable) begin
		normal_fract = ff[6:3];
		end
end
endmodule 