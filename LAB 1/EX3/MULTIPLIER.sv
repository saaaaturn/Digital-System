module MULTIPLIER
(
	input logic [7:0] A,
	input logic [7:0] B,
	output logic [15:0] Result
);
wire [15:0] Temp;
wire [7:0] sum0,sum1,sum2,sum3,sum4,sum5,sum6,sum7;
wire co0,co1,co2,co3,co4,co5,co6,co7;
wire [7:0] A0,A1,A2,A3,A4,A5,A6,A7;
BIG_AND_GATE AND_ING
(
	.big_a(A),
	.big_b(B),
	.outa_AND_0(A0),
	.outa_AND_1(A1),
	.outa_AND_2(A2),
	.outa_AND_3(A3),
	.outa_AND_4(A4),
	.outa_AND_5(A5),
	.outa_AND_6(A6),
	.outa_AND_7(A7)
);

ADDER_8_BIT ADDER_N0
(
	.A	(A0),		
	.B	(0),	
	.Prev_CO (0),		
	.Sum (sum0),
	.Carry_out(co0)
);

ADDER_8_BIT ADDER_N1
(
	.A	(A1),		
	.B	(sum0[7:1]),	
	.Prev_CO (co0),		
	.Sum (sum1),
	.Carry_out(co1)
);

ADDER_8_BIT ADDER_N2
(
	.A	(A2),		
	.B	(sum1[7:1]),	
	.Prev_CO (co1),		
	.Sum (sum2),
	.Carry_out(co2)
);

ADDER_8_BIT ADDER_N3
(
	.A	(A3),		
	.B	(sum2[7:1]),	
	.Prev_CO (co2),		
	.Sum (sum3),
	.Carry_out(co3)
);

ADDER_8_BIT ADDER_N4
(
	.A	(A4),		
	.B	(sum3[7:1]),	
	.Prev_CO (co3),		
	.Sum (sum4),
	.Carry_out(co4)
);

ADDER_8_BIT ADDER_N5
(
	.A	(A5),		
	.B	(sum4[7:1]),	
	.Prev_CO (co4),		
	.Sum (sum5),
	.Carry_out(co5)
);

ADDER_8_BIT ADDER_N6
(
	.A	(A6),		
	.B	(sum5[7:1]),	
	.Prev_CO (co5),		
	.Sum (sum6),
	.Carry_out(co6)
);

ADDER_8_BIT ADDER_N7
(
	.A	(A7),		
	.B	(sum6[7:1]),	
	.Prev_CO (co6),		
	.Sum (sum7),
	.Carry_out(co7)
);

always_comb 
begin 
	Temp = 16'b0;
	Temp = Temp + sum0[0] + (sum1[0]<<(1)) + (sum2[0]<<(2)) + (sum3[0]<<(3)) + (sum4[0]<<(4)) + (sum5[0]<<(5)) + (sum6[0]<<(6)) + (sum7[0]<<(7)) + (co7<<(15));
end
assign Result = Temp;
endmodule