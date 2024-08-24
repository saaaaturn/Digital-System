module EX3
(
	input logic clk_system,			//KEY
	input logic rst_system,			//KEY
	input logic [7:0] A,B,			//SW
	input logic EA,EB,
	output logic [15:0] data_out	//LED
);

wire [7:0] ff1_to_multiplier;
wire [7:0] ff2_to_multiplier;
wire [15:0] multiplier_to_ff3;
//Instantiate MULTIPLIER 8 bit:
MULTIPLIER Multiply_8bits
(
	.A(ff1_to_multiplier),
	.B(ff2_to_multiplier),
	.Result(multiplier_to_ff3)
);
	

//Because we have 3 D-flip flops so we need to instantiate them:
// D-flip flop no.1	
D_FF_8B dff_inst1 			
(
	.clk (clk_system),
	.rst (rst_system),
	.E_gate(EA),
	.D (A),
	.Q (ff1_to_multiplier)
);

// D-flip flop no.2
D_FF_8B dff_inst2
(
	.clk (clk_system),
	.rst (rst_system),
	.E_gate(EB),
	.D (B),
	.Q (ff2_to_multiplier)
);

// D-flip flop no.3	
D_FF_16B dff_inst3
(
	.clk (clk_system),
	.rst (rst_system),
	.D (multiplier_to_ff3),
	.Q (data_out)
);	

endmodule

	