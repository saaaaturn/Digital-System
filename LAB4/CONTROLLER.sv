module CONTROLLER 
(
	input 	logic run, reset, clk,
	input 	logic [8:0] IR,
	output 	logic R0o, R1o, R2o, R3o, R4o, R5o, R6o, R7o,
	output 	logic R0i, R1i, R2i, R3i, R4i, R5i, R6i, R7i,
	output 	logic A_in, addsub, G_in, done, G_out, DIN_out, IR_in,
	output 	logic iz,t0z,t1z,t1az,t2z,t2az,t3z
);
//DECLARE
wire mv_sig, mvi_sig, add_sig, sub_sig;	//signals for instructions
reg first_num, second_num;						//in add/sub state
reg is_as_state;
reg [2:0] opcode, start_p, end_p;			//III XXX YYY
reg f_op, f_st, f_end;							//find opcode, find start, find end signals
reg [2:0] current_state, next_state;
reg [8:0] IR_stored;
reg [2:0] III,XXX,YYY;
//
assign III 	= IR_stored [8:6];
assign XXX 	= IR_stored [5:3];
assign YYY	= IR_stored [2:0]; 
assign addsub	 = sub_sig;
//STORE IR
STORE_IR	storeir
(
	.IR				(IR),
	.en				(IR_in),
	.instruction	(IR_stored)
);
//find operation
DECODER_OP find_operations
(
	//input
	.en		(f_op),
	.opcode	(III),
	//output
	.mv		(mv_sig), 
	.mvi		(mvi_sig), 
	.add		(add_sig), 
	.sub		(sub_sig)
);
//find starting register
DECODER_ST find_startingR
(
	.en		(f_st),
	.fn_sig	(first_num),
	.sn_sig	(second_num),
	.YYY		(YYY),
	.XXX		(XXX),
	.r0o		(R0o), 
	.r1o		(R1o), 
	.r2o		(R2o), 
	.r3o		(R3o), 
	.r4o		(R4o), 
	.r5o		(R5o), 
	.r6o		(R6o), 
	.r7o		(R7o)
);
//find destination
DECODER_END find_endingR
(
	.en		(f_end),
	.is_as	(is_as_state),
	.XXX		(XXX),
	.r0i		(R0i), 
	.r1i		(R1i), 
	.r2i		(R2i), 
	.r3i		(R3i), 
	.r4i		(R4i), 
	.r5i		(R5i), 
	.r6i		(R6i), 
	.r7i		(R7i)
);
//
typedef enum logic [2:0] 
{
	idle 	= 3'b000,
	t0 	= 3'b001,
	t1 	= 3'b010,				//mv
	t1a	= 3'b011,				//use for mvi
	t2 	= 3'b100,				//add | sub
	t2a	= 3'b101,
	t3		= 3'b110
}states;
//
initial begin
	current_state <= idle;
	end

//
always_ff @(posedge clk)
begin 
	if (reset == 1'b1)
		current_state <= idle;
	else 
		current_state <= next_state;
end
//
always@(*)
begin
	case (current_state)
	idle: 												//wait
			next_state <= t0;
	t0:													//load code
		if (run & mv_sig )
			next_state <= t1;
		else if (run & mvi_sig)
			next_state <= t1a;
		else if (run & (add_sig | sub_sig) )
			next_state <= t2;
		else
			next_state <= idle;
	t1:													//check code
		if (mv_sig == 1'b1 )
			next_state <= idle;
		else 	
			next_state <= idle;
	t1a:
			next_state <= idle;
	t2:													//add or sub
		if (mv_sig == 1'b1 || mvi_sig == 1'b1)
			next_state <= idle;
		else if (add_sig == 1'b1 || sub_sig == 1'b1)
			next_state <= t2a;
		else 
			next_state <= idle;
	t2a:
			next_state <= t3;
	t3:													//add	or sub
			next_state <= idle;
	default:
			next_state <= idle;
	endcase
end
//
always@(*)
begin
	case (current_state)
	idle: 											//reset all signals
		begin 
			A_in		= 1'b0; 
			G_in		= 1'b0; 	
			done		= 1'b0; 
			G_out		= 1'b0; 
			DIN_out	= 1'b0;
			IR_in		= 1'b0;
			//
			f_op		= 1'b0;
			f_st		= 1'b0;
			f_end		= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			is_as_state		= 1'b0;
			//
			iz = 1'b1;
			t0z= 1'b0;t1z= 1'b0;t1az= 1'b0;t2z= 1'b0;t2az= 1'b0;t3z = 1'b0;
		end
	t0:												//get IR in
		begin 
			A_in		= 1'b0; 
			G_in		= 1'b0; 	
			done		= 1'b0; 
			G_out		= 1'b0; 
			DIN_out	= 1'b0;
			IR_in		= 1'b0;						//get IR signal
			//
			f_op		= 1'b1;
			f_st		= 1'b0;
			f_end		= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			is_as_state		= 1'b0;
			//
			t0z = 1'b1;
			iz= 1'b0;t1z= 1'b0;t1az= 1'b0;t2z= 1'b0;t2az= 1'b0;t3z = 1'b0;
		end
	t1:												//check for opcode
		begin 
			A_in		= 1'b0; 
			G_in		= 1'b0; 	
			done		= (mv_sig); 				//done when mv 
			G_out		= 1'b0;
			DIN_out	= 1'b0;
			IR_in		= 1'b1;
			//
			f_op		= 1'b1;
			f_st		= 1'b1;
			f_end		= 1'b1;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			is_as_state		= 1'b0;
			//
			t1z = 1'b1;
			iz= 1'b0;t0z= 1'b0;t1az= 1'b0;t2z= 1'b0;t2az= 1'b0;t3z = 1'b0;
		end
	t1a:
		begin 
			A_in		= 1'b0; 
			G_in		= 1'b0; 	
			done		= (mvi_sig); 
			G_out		= 1'b0;
			DIN_out	= 1'b1;						//get DIN
			IR_in		= 1'b1;
			//
			f_op		= 1'b1;
			f_st		= 1'b0;
			f_end		= 1'b1;						//register
			first_num		= 1'b0;
			second_num 		= 1'b0;
			is_as_state		= 1'b0;
			//
			t1az = 1'b1;
			iz= 1'b0;t0z= 1'b0;t1z= 1'b0;t2z= 1'b0;t2az= 1'b0;t3z = 1'b0;
		end
	t2:												//add and sub state
		begin 
			A_in		= 1'b1; 
			G_in		= 1'b0; 	
			done		= 1'b0; 
			G_out		= 1'b0; 
			DIN_out	= 1'b0;
			IR_in		= 1'b0;
			//
			f_op		= 1'b1;
			f_st		= 1'b1;
			f_end		= 1'b0;
			first_num		= 1'b1;
			second_num 		= 1'b0;
			is_as_state		= 1'b0;
			//
			t2z = 1'b1;
			iz= 1'b0;t0z= 1'b0;t1az= 1'b0;t1z= 1'b0;t2az= 1'b0;t3z = 1'b0;
		end
	t2a:												//add and sub state, insert the next number
		begin 
			A_in		= 1'b0; 
			G_in		= 1'b0; 	
			done		= 1'b0; 
			G_out		= 1'b0; 
			DIN_out	= 1'b0;
			IR_in		= 1'b0;
			//
			f_op		= 1'b1;
			f_st		= 1'b1;
			f_end		= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b1;
			is_as_state		= 1'b0;
			//
			t2az = 1'b1;
			iz= 1'b0;t0z= 1'b0;t1az= 1'b0;t1z= 1'b0;t2z= 1'b0;t3z = 1'b0;
		end
	t3:
		begin 
			A_in		= 1'b0; 
			G_in		= 1'b0; 	
			done		= 1'b1; 
			G_out		= 1'b1; 
			DIN_out	= 1'b0;
			IR_in		= 1'b1;
			//
			f_op		= 1'b1;
			f_st		= 1'b0;
			f_end		= 1'b1;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			is_as_state		= 1'b1;
			//
			t3z = 1'b1;
			iz= 1'b0;t0z= 1'b0;t1az= 1'b0;t1z= 1'b0;t2az= 1'b0;t2z = 1'b0;
		end
	endcase
end	
endmodule : CONTROLLER