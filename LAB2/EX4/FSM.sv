module FSM 
(
	input logic CLOCK_50, rst, load_i,	//enable=1 khi size!=0
	input logic [2:0] new_len,
	output logic shift_o, dis, k, load_o,
	output logic [1:0] state
);

typedef enum logic [1:0] 
{
	IDLE 		= 2'b00,
	INPUT 	= 2'b01,
	DISPLAY 	= 2'b10
} state_t;

logic [1:0] current_state, next_state;
//
always_ff @(posedge CLOCK_50, negedge rst) 
begin
	if (~rst) begin
		current_state <= IDLE;
		end
	else begin
		current_state <= next_state;
		end
end
//
always @(*) begin
	case (current_state)
		IDLE:		
		begin
						if (load_i) 
							begin
							next_state = IDLE;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (~load_i) 
							begin
							next_state = INPUT;
							shift_o = 1'b0;
							load_o = 1'b1;
							end
		end
		
		INPUT:	
		begin
						if (new_len == 3'b000) 
							begin
							next_state = IDLE;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (k == 1'b0) 
							begin
							next_state = INPUT;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (k == 1'b1) 
							begin
							next_state = DISPLAY;
							shift_o = 1'b1;
							load_o = 1'b0;
							end
		end
		
		DISPLAY:	
		begin
						if (k == 1'b0) 
							begin
							next_state = DISPLAY;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
						else if (k == 1'b1) 
							begin
							next_state = INPUT;
							shift_o = 1'b0;
							load_o = 1'b0;
							end
		end
	endcase
end

assign dis = (current_state == DISPLAY);

// 
int t=0;
always_ff @(posedge CLOCK_50) begin
	 t = t + 1;
		if (t == 25000000) begin
			t = 0;
			end
end
assign k = (t == 0) ? 1 : 0;
endmodule : FSM