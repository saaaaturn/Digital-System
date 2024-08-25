//1 bit fulladder
module fulladder (
	input logic A,B,
	input logic Cin,
	output logic Sum,
	output logic Cout
);
assign Sum = A ^ B ^ Cin;
assign Cout = (A & B)|((A ^ B)&Cin);
endmodule : fulladder