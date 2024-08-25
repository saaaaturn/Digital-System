module totalAB (
	input logic Cin,
	input logic a, b, choose,
	input logic [7:0] ffAB,
	input logic [7:0] ffBA,
	output logic [7:0] out,
	output logic final_sign
);
logic [2:0] sel;
assign sel = {choose, Cin, a, b};

always @(*) begin
	unique case (sel)
		4'b0000:	begin
					out = ffAB;
					final_sign = 1'b0;
					end
					
		4'b0001:	begin
					out = ffBA;
					final_sign = 1'b0;
					end
					
		4'b0010:	begin
					out = ffBA;
					final_sign = 1'b1;
					end
					
		4'b0011:	begin
					out = ffAB;
					final_sign = 1'b1;
					end
					
		4'b0100:	begin
					out = ffBA;
					final_sign = 1'b0;
					end
					
		4'b0101:	begin
					out = ffAB;
					final_sign = 1'b0;
					end
					
		4'b0110:	begin
					out = ffAB;
					final_sign = 1'b1;
					end
					
		4'b0111:	begin
					out = ffBA;
					final_sign = 1'b1;
					end
									
		4'b1000: begin
					out = ffAB;
					final_sign = 1'b0;
					end
					
		4'b1001: begin
					out = ffBA;
					final_sign = 1'b1;
					end
		
		4'b1010: begin
					out = ffBA;
					final_sign = 1'b0;
					end
					
		4'b1011: begin
					out = ffAB;
					final_sign = 1'b1;
					end
					
		4'b1100: begin
					out = ffBA;
					final_sign = 1'b1;
					end
					
		4'b1101: begin
					out = ffAB;
					final_sign = 1'b0;
					end
					
		4'b1110: begin
					out = ffAB;
					final_sign = 1'b1;
					end
					
		4'b1111: begin
					out = ffBA;
					final_sign = 1'b0;
					end
	endcase
end
endmodule

		