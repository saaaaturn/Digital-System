module LAB1
(
	input logic clk_system,			//KEY1
	input logic rst_system,			//KEY0
	input logic [7:0] data_in,		//SW[7:0]
	output logic [7:0] data_out,	//7segments
	output logic overflow_flag,	//LEDR9
	output logic carry_flag			//LEDR8
);

wire [7:0] ff1_to_adder;
wire [7:0] adder_to_ff2;
wire adder_carry;
wire adder_overflow;
wire [7:0]out_ff2;
//Instantiate ADDER 8 bit:
ADDER_8_BIT assign_in_out
(
	.A (ff1_to_adder),
	.B (data_out),
	.Sum (adder_to_ff2),
	.Carry_out(adder_carry),
	.V_flag(adder_overflow)
);
	

//Because we have 4 D-flip flops so we need to instantiate them:
// D-flip flop no.1	----> INTO ADDER
D_FF_8B dff_inst1 			
(
	.clk (!clk_system),
	.rst (rst_system),
	.D (data_in),
	.Q (ff1_to_adder)
);

// D-flip flop no.2	----> OUTA ADDER
D_FF_8B dff_inst2
(
	.clk (!clk_system),
	.rst (rst_system),
	.D (adder_to_ff2),
	.Q (out_ff2)
);

// D-flip flop no.3	----> OVERFLOW FLAG
D_FF_1B dff_inst3
(
	.clk (!clk_system),
	.rst (rst_system),
	.D (adder_overflow),
	.Q (overflow_flag)
);	

// D-flip flop no.4	----> CARRY FLAG
D_FF_1B dff_inst4
(
	.clk (!clk_system),
	.rst (rst_system),
	.D (adder_carry),
	.Q (carry_flag)
);
assign data_out = out_ff2;
endmodule

	