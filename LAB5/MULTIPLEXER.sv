module MULTIPLEXER
(
	//data in
	input 	logic [8:0] din, g,
	input 	logic [8:0] r0,r1,r2,r3,r4,r5,r6,r7,
	//select
	input 	logic [9:0] select_mux,		//R0o, R1o, R2o, R3o, R4o, R5o, R6o, R7o, G_out, DIN_out
	//ouput
	output 	logic [8:0] bus
);
//
always_comb
begin
	case (select_mux)
	10'b1000000000:
		bus = r0;
	10'b0100000000:
		bus = r1;
	10'b0010000000:
		bus = r2;
	10'b0001000000:
		bus = r3;
	10'b0000100000:
		bus = r4;
	10'b0000010000:
		bus = r5;
	10'b0000001000:
		bus = r6;
	10'b0000000100:
		bus = r7;
	10'b0000000010:
		bus = g;
	10'b0000000001:
		bus = din;
	default:
		bus = 9'b0;
	endcase
end
//
endmodule : MULTIPLEXER