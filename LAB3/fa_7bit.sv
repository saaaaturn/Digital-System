module fa_7bit (
	input logic [6:0] A,
	input logic [6:0] B,
	input logic Cin,
	output logic [7:0] Sum,
	output logic Cout,
	output logic [8:0] value
);
logic [6:0] carry;

fulladder fa0 (.Sum(Sum[0]), .A(A[0]), .B(B[0]^Cin), .Cin(Cin), .Cout(carry[0]));
fulladder fa1 (.Sum(Sum[1]), .A(A[1]), .B(B[1]^Cin), .Cin(carry[0]), .Cout(carry[1]));
fulladder fa2 (.Sum(Sum[2]), .A(A[2]), .B(B[2]^Cin), .Cin(carry[1]), .Cout(carry[2]));
fulladder fa3 (.Sum(Sum[3]), .A(A[3]), .B(B[3]^Cin), .Cin(carry[2]), .Cout(carry[3]));
fulladder fa4 (.Sum(Sum[4]), .A(A[4]), .B(B[4]^Cin), .Cin(carry[3]), .Cout(carry[4]));
fulladder fa5 (.Sum(Sum[5]), .A(A[5]), .B(B[5]^Cin), .Cin(carry[4]), .Cout(carry[5]));
fulladder fa6 (.Sum(Sum[6]), .A(A[6]), .B(B[6]^Cin), .Cin(carry[5]), .Cout(carry[6]));


assign Cout = carry[6] ^ Cin;
assign value = {Cout, Sum[6:0]};
endmodule : fa_7bit