module BIG_AND_GATE
(
	input logic [7:0] big_a,
	input logic [7:0] big_b,
	output logic [7:0] outa_AND_0,outa_AND_1,outa_AND_2,outa_AND_3,outa_AND_4,outa_AND_5,outa_AND_6,outa_AND_7
);

SMALL_AND_GATE and0 (.small_a(big_a),.small_b({8{big_b[0]}}),.after_AND_GATE(outa_AND_0));
SMALL_AND_GATE and1 (.small_a(big_a),.small_b({8{big_b[1]}}),.after_AND_GATE(outa_AND_1));
SMALL_AND_GATE and2 (.small_a(big_a),.small_b({8{big_b[2]}}),.after_AND_GATE(outa_AND_2));
SMALL_AND_GATE and3 (.small_a(big_a),.small_b({8{big_b[3]}}),.after_AND_GATE(outa_AND_3));
SMALL_AND_GATE and4 (.small_a(big_a),.small_b({8{big_b[4]}}),.after_AND_GATE(outa_AND_4));
SMALL_AND_GATE and5 (.small_a(big_a),.small_b({8{big_b[5]}}),.after_AND_GATE(outa_AND_5));
SMALL_AND_GATE and6 (.small_a(big_a),.small_b({8{big_b[6]}}),.after_AND_GATE(outa_AND_6));
SMALL_AND_GATE and7 (.small_a(big_a),.small_b({8{big_b[7]}}),.after_AND_GATE(outa_AND_7));
endmodule

module SMALL_AND_GATE
(
	input logic [7:0] small_a,
	input logic [7:0] small_b,
	output logic [7:0] after_AND_GATE
);
assign after_AND_GATE = small_a & small_b;
endmodule