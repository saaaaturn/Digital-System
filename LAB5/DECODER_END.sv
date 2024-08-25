module DECODER_END
(
	input 	logic	en,
	input		logic is_as,
	input 	logic [2:0] XXX, 
	output 	logic r0i, r1i, r2i, r3i, r4i, r5i, r6i, r7i
);
always_comb
begin
	if(en | is_as )
		begin
		case (XXX)
			3'b000:
				begin
				r0i = 1'b1;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
			3'b001:
				begin
				r0i = 1'b0;
				r1i = 1'b1;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
			3'b010:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b1;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
			3'b011:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b1;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
			3'b100:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b1;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
			3'b101:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b1;
				r6i = 1'b0;
				r7i = 1'b0;
				end
			3'b110:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b1;
				r7i = 1'b0;
				end
			3'b111:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b1;
				end
			default:
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
		endcase
		end
	else
				begin
				r0i = 1'b0;
				r1i = 1'b0;
				r2i = 1'b0;
				r3i = 1'b0;
				r4i = 1'b0;
				r5i = 1'b0;
				r6i = 1'b0;
				r7i = 1'b0;
				end
end
//
endmodule : DECODER_END