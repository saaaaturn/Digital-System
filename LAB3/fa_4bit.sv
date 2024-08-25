module fa_4bit (
	input logic [3:0] A,
	input logic [3:0] B,
	input logic Cin,
	output logic [3:0] Sum,
	output logic Cout,
	output logic [4:0] value
);
logic [3:0] carry;

fulladder fa0 (.Sum(Sum[0]), .A(A[0]), .B(B[0]^Cin), .Cin(Cin), .Cout(carry[0]));
fulladder fa1 (.Sum(Sum[1]), .A(A[1]), .B(B[1]^Cin), .Cin(carry[0]), .Cout(carry[1]));
fulladder fa2 (.Sum(Sum[2]), .A(A[2]), .B(B[2]^Cin), .Cin(carry[1]), .Cout(carry[2]));
fulladder fa3 (.Sum(Sum[3]), .A(A[3]), .B(B[3]^Cin), .Cin(carry[2]), .Cout(carry[3]));

assign Cout = carry[3] ^ Cin;
assign value = {Cout, Sum[3:0]};
endmodule : fa_4bit