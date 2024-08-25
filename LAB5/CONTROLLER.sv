module CONTROLLER
(
	input 	logic run, reset, clk,
	input 	logic [8:0] IR, Gdata,
	output 	logic R0o, R1o, R2o, R3o, R4o, R5o, R6o, R7o,
	output 	logic R0i, R1i, R2i, R3i, R4i, R5i, R6i, R7i,
	output 	logic A_in, addsub, G_in, done, G_out, DIN_out, IR_in, incr_pc, ADDR_in, DOUT_in, W_D, compare_G, not_zero, counter_out,
	output 	logic iz,fetchz,mvz,mviz,as1z,as2z,as3z,ld1z,ld2z,ld3z,st1z,st2z,st3z,mvnzz, waitinz, incz
);
//DECLARE
wire mv_sig, mvi_sig, add_sig, sub_sig, ld_sig, st_sig, mvnz_sig ;	//signals for instructions
reg first_num, second_num;						//in add/sub state
reg as_result;
reg nz;
reg [2:0] opcode, start_p, end_p;			//III XXX YYY
reg f_op, f_st, f_end;							//find opcode, find start, find end signals
reg [3:0] current_state, next_state;
reg [8:0] IR_stored;
reg [2:0] III,XXX,YYY;
//
assign III 	= IR_stored [8:6];
assign XXX 	= IR_stored [5:3];
assign YYY	= IR_stored [2:0]; 
assign addsub	 = sub_sig;
assign not_zero = nz;
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
	.sub		(sub_sig),
	.ld		(ld_sig),
	.st		(st_sig),
	.mvnz		(mvnz_sig)
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
	.is_as	(as_result),
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
checkG checkforov0
(
	.en		(compare_G),
	.G_data	(Gdata),
	.checked	(nz)
);
//

typedef enum logic [3:0] 
{
	inc	= 4'b0000,				//increase counter
	waitin= 4'b0001,				//IR in
	idle 	= 4'b0010,
	fetch = 4'b0011,
	//
	mv 	= 4'b0100,				//mv
	//
	mvi	= 4'b0101,				//use for mvi
	//
	as1 	= 4'b0110,				//add | sub
	as2	= 4'b0111,
	as3	= 4'b1000,
	//
	ld1	= 4'b1001,				//ld
	ld2	= 4'b1010,
	ld3	= 4'b1011,
	//
	st1	= 4'b1100,				//st
	st2	= 4'b1101,
	st3	= 4'b1110,		
	//
	mvnz	= 4'b1111				//check g value
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
				next_state <= inc;
		inc:													//increase counter
				next_state <= waitin;
		waitin:												//IR_in
				next_state <= fetch;
		fetch:												//check for code
				if		  (run & mv_sig)
				next_state <= mv;
				else if (run & mvi_sig) 
				next_state <= mvi;
				else if (run & (add_sig | sub_sig) )
				next_state <= as1;
				else if (run & ld_sig)
				next_state <= ld1;
				else if (run & st_sig)
				next_state <= st1;
				else if (run & mvnz_sig)
				next_state <= mvnz;
				else
				next_state <= idle;
		mv:													//mv	
				next_state <= idle;
		mvi:													//mvi
				next_state <= idle;
		as1:													//add or sub
				if (mv_sig | mvi_sig | ld_sig | st_sig | mvnz_sig )
				next_state <= idle;
				else if (add_sig | sub_sig)
				next_state <= as2;
				else 
				next_state <= idle;
		as2:
				if (mv_sig | mvi_sig | ld_sig | st_sig | mvnz_sig )
				next_state <= idle;
				else if (add_sig | sub_sig)
				next_state <= as3;
				else 
				next_state <= idle;
		as3:													//add	or sub 
				next_state <= idle;
		ld1:
				if (mv_sig | mvi_sig | add_sig | sub_sig | st_sig | mvnz_sig )
				next_state <= idle;
				else if (ld_sig)
				next_state <= ld2;
				else 
				next_state <= idle;
		ld2:
				if (mv_sig | mvi_sig | add_sig | sub_sig | st_sig | mvnz_sig )
				next_state <= idle;
				else if (ld_sig)
				next_state <= ld3;
				else 
				next_state <= idle;
		ld3:	
				next_state <= idle;
		st1:
				if (mv_sig | mvi_sig | add_sig | sub_sig | ld_sig | mvnz_sig )
				next_state <= idle;
				else if (st_sig)
				next_state <= st2;
				else 
				next_state <= idle;
		st2: 
				if (mv_sig | mvi_sig | add_sig | sub_sig | ld_sig | mvnz_sig )
				next_state <= idle;
				else if (st_sig)
				next_state <= st3;
				else 
				next_state <= idle;
		st3: 	
				next_state <= idle;
		mvnz:
				if (mv_sig | mvi_sig | add_sig | sub_sig | ld_sig | st_sig )
				next_state <= idle;
				else if (st_sig & nz)
				next_state <= mv;
				else 
				next_state <= idle;
		default:
				next_state <= idle;
	endcase
end
//
always@(*)
begin
	case (current_state)
	inc:										//increase R7
		begin 
			A_in				= 1'b0; 
			G_in				= 1'b0; 	
			done				= 1'b0; 
			G_out				= 1'b0; 
			DIN_out			= 1'b0;
			IR_in				= 1'b0;
			incr_pc			= 1'b1;		//incr_pc
			ADDR_in			= 1'b1;		//ADDR_in
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b1;		//
			//
			f_op				= 1'b0;
			f_st				= 1'b0;
			f_end				= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;
			fetchz			= 1'b0;
			mvz				= 1'b0;
			mviz				= 1'b0;
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;	
			incz	 			= 1'b1;		//incz
		end
	waitin:									//IR_in
		begin 
			A_in				= 1'b0; 
			G_in				= 1'b0; 	
			done				= 1'b0; 
			G_out				= 1'b0; 
			DIN_out			= 1'b0;
			IR_in				= 1'b1;		//IR_in
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b0;
			f_st				= 1'b0;
			f_end				= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;
			fetchz			= 1'b0;
			mvz				= 1'b0;
			mviz				= 1'b0;
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b1;		//waitinz
			incz	 			= 1'b0;
		end
	idle: 											//reset all signals
		begin 
			A_in				= 1'b0; 
			G_in				= 1'b0; 	
			done				= 1'b0; 
			G_out				= 1'b0; 
			DIN_out			= 1'b0;
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b0;
			f_st				= 1'b0;
			f_end				= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b1;		//iz
			fetchz			= 1'b0;
			mvz				= 1'b0;
			mviz				= 1'b0;
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	fetch:												//get IR in
		begin 
			A_in				= 1'b0; 
			G_in				= 1'b0; 	
			done				= 1'b0; 
			G_out				= 1'b0; 
			DIN_out			= 1'b0;
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b1;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;
			f_st				= 1'b0;
			f_end				= 1'b0;
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b1;		//fetchz
			mvz				= 1'b0;
			mviz				= 1'b0;
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	mv:												//check for opcode
		begin 
			A_in				= 1'b0; 
			G_in				= 1'b0; 	
			done				= 1'b1; 		//done
			G_out				= 1'b0; 
			DIN_out			= 1'b0;
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b1;		//f_st
			f_end				= 1'b1;		//f_end
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b1;		//mvz
			mviz				= 1'b0;
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
			
	mvi:
		begin 
			A_in				= 1'b0; 
			G_in				= 1'b0; 	
			done				= 1'b1; 		//done
			G_out				= 1'b0; 
			DIN_out			= 1'b1;		//DIN_out
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b0;		
			f_end				= 1'b1;		//f_end
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b1;		//mvi
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	as1:												//add and sub state
		begin 
			A_in				= 1'b1; 		//A_in
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b1;		//f_st
			f_end				= 1'b0;		
			first_num		= 1'b1;		//first_num
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b1;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	as2:												//add and sub state, insert the next number
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b1;		//f_st	
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b1;		//second_num
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b1;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	as3:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b1; 		//done	
			G_out				= 1'b1; 		//G_out
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b0;		
			f_end				= 1'b1;		//f_end
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b1;		//as_signal
			//state signals	
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b1;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	ld1:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b1;		//ADDR_in
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b1;		//f_st
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b1;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	ld2:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b0;		
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b1;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	ld3:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b1; 		//	
			G_out				= 1'b0; 
			DIN_out			= 1'b1;		//	
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b1;		
			DOUT_in			= 1'b0;
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b0;		
			f_end				= 1'b1;		
			first_num		= 1'b0;
			second_num 		= 1'b0;
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b1;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	st1:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b1;		//
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b1;		//
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b1;		//
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b1;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	st2:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b1;		//
			DOUT_in			= 1'b0;		
			W_D				= 1'b0;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//f_op
			f_st				= 1'b1;		//
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b0;		//
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b1;	st3z	= 1'b0;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	st3:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;		
			W_D				= 1'b1;
			compare_G		= 1'b0;
			counter_out		= 1'b0;
			//
			f_op				= 1'b0;		
			f_st				= 1'b0;		
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b0;		
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b1;
			mvnzz				= 1'b0;
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	mvnz:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;		
			W_D				= 1'b0;
			compare_G		= 1'b0;		//
			counter_out		= 1'b0;
			//
			f_op				= 1'b1;		//	
			f_st				= 1'b0;		
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b0;		
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b1;		//
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	default:
		begin 
			A_in				= 1'b0; 	
			G_in				= 1'b0; 	
			done				= 1'b0; 		
			G_out				= 1'b0; 
			DIN_out			= 1'b0;		
			IR_in				= 1'b0;		
			incr_pc			= 1'b0;		
			ADDR_in			= 1'b0;		
			DOUT_in			= 1'b0;		
			W_D				= 1'b0;
			compare_G		= 1'b1;		//
			counter_out		= 1'b0;
			//
			f_op				= 1'b0;		//	
			f_st				= 1'b0;		
			f_end				= 1'b0;		
			first_num		= 1'b0;
			second_num 		= 1'b0;		
			as_result		= 1'b0;
			//state signals
			iz 				= 1'b0;		
			fetchz			= 1'b0;
			mvz				= 1'b0;		
			mviz				= 1'b0;		
			as1z				= 1'b0;	as2z	= 1'b0;	as3z	= 1'b0;
			ld1z				= 1'b0;	ld2z	= 1'b0;	ld3z	= 1'b0;
			st1z				= 1'b0;	st2z	= 1'b0;	st3z	= 1'b0;
			mvnzz				= 1'b0;		//
			waitinz			= 1'b0;		
			incz	 			= 1'b0;
		end
	endcase
end	
endmodule : CONTROLLER