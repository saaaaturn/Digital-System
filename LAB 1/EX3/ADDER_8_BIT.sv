module ADDER_8_BIT	
(	
	input logic [7:0]A,		//INPUT A
	input logic [6:0]B,		//INPUT B
	input logic Prev_CO,			//INPUT PREVIOUS CARRY OUT
	output logic [7:0]Sum, 	//RESULT
	output logic Carry_out //FINAL CARRY OUT
);
	
wire c1,c2,c3,c4,c5,c6,c7,c8; //CARRY OUT

ADDER_1_BIT add0( .a(A[0]), .b(B[0]),.cin(0), .s(Sum[0]), .cout(c1));
ADDER_1_BIT add1( .a(A[1]), .b(B[1]),.cin(c1), .s(Sum[1]), .cout(c2));
ADDER_1_BIT add2( .a(A[2]), .b(B[2]),.cin(c2), .s(Sum[2]), .cout(c3));
ADDER_1_BIT add3( .a(A[3]), .b(B[3]),.cin(c3), .s(Sum[3]), .cout(c4));
ADDER_1_BIT add4( .a(A[4]), .b(B[4]),.cin(c4), .s(Sum[4]), .cout(c5));
ADDER_1_BIT add5( .a(A[5]), .b(B[5]),.cin(c5), .s(Sum[5]), .cout(c6));
ADDER_1_BIT add6( .a(A[6]), .b(B[6]),.cin(c6), .s(Sum[6]), .cout(c7));
ADDER_1_BIT add7( .a(A[7]), .b(Prev_CO),.cin(c7), .s(Sum[7]), .cout(c8));
assign Carry_out= c8;
endmodule

module ADDER_1_BIT
(
	input logic a,
	input logic b,
	input logic cin,
	output logic s,
	output logic cout
);
assign s=a^b^cin;
assign cout = a&b;
endmodule