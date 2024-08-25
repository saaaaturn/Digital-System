module DECODER_OP
(
	input 	logic	en,
	input 	logic [2:0] opcode,
	output 	logic mv, mvi, add, sub
);
always_comb
begin
	if(en)
		begin
		case (opcode)
			3'b000:
				begin
				mv 	= 1'b1;
				mvi 	= 1'b0;
				add 	= 1'b0;
				sub	= 1'b0;
				end
			3'b001:
				begin
				mv 	= 1'b0;
				mvi 	= 1'b1;
				add 	= 1'b0;
				sub	= 1'b0;
				end
			3'b010:
				begin
				mv 	= 1'b0;
				mvi 	= 1'b0;
				add 	= 1'b1;
				sub	= 1'b0;
				end
			3'b011:
				begin
				mv 	= 1'b0;
				mvi 	= 1'b0;
				add 	= 1'b0;
				sub	= 1'b1;
				end
			default:
				begin
				mv 	= 1'b0;
				mvi 	= 1'b0;
				add 	= 1'b0;
				sub	= 1'b0;
				end
		endcase
		end
	else 
		begin
		mv 	= 1'b0;
		mvi 	= 1'b0;
		add 	= 1'b0;
		sub	= 1'b0;
		end	
end
//
endmodule : DECODER_OP