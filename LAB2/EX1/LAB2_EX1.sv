module LAB2_EX1
(
	input logic sys_clk,
	input logic sys_reset,
	input logic W,
	output logic Z,
	output logic [8:0]State
);
wire [8:0]D;
wire [8:0]Q;
initial begin
	D = 9'b000000001;
end
// instatiate 9 flipflops

D_FF no8
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[8]),
	.Q(Q[8])
);

D_FF no7
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[7]),
	.Q(Q[7])
);

D_FF no6
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[6]),
	.Q(Q[6])
);

D_FF no5
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[5]),
	.Q(Q[5])
);

D_FF no4
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[4]),
	.Q(Q[4])
);

D_FF no3
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[3]),
	.Q(Q[3])
);

D_FF no2
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[2]),
	.Q(Q[2])
);

D_FF no1
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[1]),
	.Q(Q[1])
);

D_FF_Y0 no0
(
	.clk(sys_clk),
	.rst(sys_reset),
	.D(D[0]),
	.Q(Q[0])
);
always_ff @(posedge sys_clk or negedge sys_reset)
	begin
 D[0] = 1'b0;
 D[1] = (Q[0] | Q[5] | Q[6] | Q[7] | Q[8] ) & ~W;
 D[2] = Q[1] & ~W;
 D[3] = Q[2] & ~W;
 D[4] = (Q[4] | Q[3] ) & ~W;
 D[5] = (Q[4]|Q[3]|Q[2]|Q[1]|Q[0])&W;
 D[6] = Q[5]&W;
 D[7] = Q[6]&W;
 D[8] = (Q[7]|Q[8])&W;
	end

assign Z = (Q[4] | Q[8]);
assign State = Q;
endmodule