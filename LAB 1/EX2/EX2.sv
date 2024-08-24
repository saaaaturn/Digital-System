module EX2 (
	input logic [7:0] A0,
	input logic clk, rst, cin,
	output logic [0:0] overflow, Carry,
	output logic [7:0] sum
);

wire [7:0] wire1, wire2;
wire [0:0] V, cout;

D_FF8b dff8b0 
(
	.clk(clk), 
	.rst(rst), 
	.data_i(A0), 
	.data_o(wire1)
);
FA8b fa8b1 
(
	.sum(sum), 
	.a(wire2), 
	.b(wire1), 
	.cin(cin), 
	.cout(cout), 
	.V(V)
);
D_FF8b dff8b1 
(
	.clk(clk), 
	.rst(rst), 
	.data_i(sum), 
	.data_o(wire2)
);
D_FF dff0 
(
	.clk(clk), 
	.rst(rst), 
	.data_i(V), 
	.data_o(overflow)
);
D_FF dff1 
(
	.clk(clk), 
	.rst(rst), 
	.data_i(cout), 
	.data_o(Carry)
);

endmodule 