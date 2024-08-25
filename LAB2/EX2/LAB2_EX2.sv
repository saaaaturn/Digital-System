module LAB2_EX2
(
	input logic sys_clock,
	input logic sys_reset,
	input logic W,
	output logic Z,
	output logic [8:0]Signals
);
typedef enum logic [3:0] {A,B,C,D,E,F,G,H,I} States;
States current_state, next_state;

wire [8:0]Q;

initial begin
	current_state = A;
end

always_ff@ (posedge sys_clock or negedge sys_reset)	
	if	(!sys_reset)
	current_state <= A;
	else
	current_state <= next_state;
//STATES
always_ff@(posedge sys_clock or negedge sys_reset)
case (current_state)
	A:
			if (!W)
			next_state <= B;
			else if (W)
			next_state <= F;
	B: 
			if (W) 
			next_state <= F;
			else if (!W) 
			next_state <= C;
	C:
			if (W)
			next_state <= F;
			else if (!W) 
			next_state <= D;
	D:
			if (W)
			next_state <= F;
			else if (!W) 
			next_state <= E;
	E:
			if (W)
			next_state <= F;
			else if (!W)
			next_state <= E;
	F:
			if (!W)
			next_state <= B;
			else if (W)
			next_state <= G;
	G:
			if (!W)
			next_state <= B;
			else if (W)
			next_state <= H;
	H:
			if (!W)
			next_state <= B;
			else if (W)
			next_state <= I;
	I:
			if (!W)
			next_state <= B;
			else if (W)
			next_state <= I;
	default: 
			next_state <= A;
	endcase
///////////////////////////////////
always_ff@(posedge sys_clock or negedge sys_reset)
case (current_state)
	A:	
		Q <= 9'b000000001;
	B: 
		Q <= 9'b000000010;	
	C:
		Q <= 9'b000000100;	
	D:
		Q <= 9'b000001000;	
	E:
		Q <= 9'b000010000;	
	F:
		Q <= 9'b000100000;			
	G:
		Q <= 9'b001000000;
	H:
		Q <= 9'b010000000;	
	I:
		Q <= 9'b100000000;
	default: 
		Q <= 9'b000000001;
	endcase

// OUTPUTS

assign Z = (current_state == E | current_state == I);
assign Signals = Q;
endmodule