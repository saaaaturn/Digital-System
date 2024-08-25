module DECODER_ST
(
	input 	logic	en, fn_sig, sn_sig,
	input 	logic [2:0] YYY, XXX,
	output 	logic r0o, r1o, r2o, r3o, r4o, r5o, r6o, r7o
);
always_comb
begin
	if((en || fn_sig) && !sn_sig)
		begin
		case (YYY)
			3'b000:
				begin
				r0o = 1'b1;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b001:
				begin
				r0o = 1'b0;
				r1o = 1'b1;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b010:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b1;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b011:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b1;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b100:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b1;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b101:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b1;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b110:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b1;
				r7o = 1'b0;
				end
			3'b111:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b1;
				end
			default:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
		endcase
		end
	else if((en & sn_sig) && !fn_sig)
		begin
		case (XXX)
			3'b000:
				begin
				r0o = 1'b1;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b001:
				begin
				r0o = 1'b0;
				r1o = 1'b1;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b010:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b1;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b011:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b1;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b100:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b1;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b101:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b1;
				r6o = 1'b0;
				r7o = 1'b0;
				end
			3'b110:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b1;
				r7o = 1'b0;
				end
			3'b111:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b1;
				end
			default:
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
		endcase
		end
	else
				begin
				r0o = 1'b0;
				r1o = 1'b0;
				r2o = 1'b0;
				r3o = 1'b0;
				r4o = 1'b0;
				r5o = 1'b0;
				r6o = 1'b0;
				r7o = 1'b0;
				end
end
//
endmodule : DECODER_ST