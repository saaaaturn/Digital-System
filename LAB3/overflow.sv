module overflow (
	input logic [2:0] Exp,
	output logic overflow
);
assign overflow = (Exp == 3'b111) ? 1'b1 : 1'b0;
endmodule 