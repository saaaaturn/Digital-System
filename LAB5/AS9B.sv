module AS9B	
(
	input 	logic [8:0] A,B,				//INPUT A AND B
	input 	logic op,						//INPUT OPERATOR (+/-)
	output 	logic	[8:0] as_result		//RESULT
);
//
wire [8:0] result;
wire [8:0] c; 									//CARRY OUT
//
AS1B as0( .a(A[0]), .b(B[0]^op), .cin(op), 	.s(result[0]), .cout(c[0]));
AS1B as1( .a(A[1]), .b(B[1]^op), .cin(c[0]), .s(result[1]), .cout(c[1]));
AS1B as2( .a(A[2]), .b(B[2]^op), .cin(c[1]), .s(result[2]), .cout(c[2]));
AS1B as3( .a(A[3]), .b(B[3]^op), .cin(c[2]), .s(result[3]), .cout(c[3]));
AS1B as4( .a(A[4]), .b(B[4]^op), .cin(c[3]), .s(result[4]), .cout(c[4]));
AS1B as5( .a(A[5]), .b(B[5]^op), .cin(c[4]), .s(result[5]), .cout(c[5]));
AS1B as6( .a(A[6]), .b(B[6]^op), .cin(c[5]), .s(result[6]), .cout(c[6]));
AS1B as7( .a(A[7]), .b(B[7]^op), .cin(c[6]), .s(result[7]), .cout(c[7]));
AS1B as8( .a(A[8]), .b(B[8]^op), .cin(c[7]), .s(result[8]), .cout(c[8]));

//
assign as_result = result;
//
endmodule : AS9B
/////////////////////////////////////////////////////////////////////
module AS1B
(
	input a,
	input b,
	input cin,
	output s,
	output cout
);
assign s=a^b^cin;
assign cout = (a & b)| (cin & (a ^ b));
endmodule : AS1B