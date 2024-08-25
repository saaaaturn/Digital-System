module DECODER 
(
	input logic [2:0] sw, 		//SW
	output logic [3:0] mcode,	//morse code
	output logic [2:0] mlength	//morse length
);

always_comb begin
	case (sw)
		3'b000:	begin
					mcode = 4'b0010;
					mlength = 3'b010;
					end
					
		3'b001:	begin
					mcode = 4'b0001;
					mlength = 3'b100;
					end
					
		3'b010:	begin
					mcode = 4'b0101;
					mlength = 3'b100;
					end
		
		3'b011:	begin
					mcode = 4'b0001;
					mlength = 3'b011;
					end
					
		3'b100:	begin
					mcode = 4'b0000;
					mlength = 3'b001;
					end
					
		3'b101:	begin
					mcode = 4'b0100;
					mlength = 3'b100;
					end
					
		3'b110:	begin
					mcode = 4'b0011;
					mlength = 3'b011;
					end
					
		3'b111:	begin
					mcode = 4'b0000;
					mlength = 3'b100;
					end
	endcase
end

endmodule : DECODER