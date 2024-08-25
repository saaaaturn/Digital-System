//compute
module compute (
	input logic [7:0] in,
	input logic Cin, EA, EB, clk, rst,
	output logic [7:0] ff, ff1, ff2,
	output logic [7:0] totalAB, totalBA,
	output logic [2:0] shift_counter,
	output logic [3:0] final_fract,
	output logic final_sign,
	output logic [2:0] Final_exp,
	output logic overflow, zero
);
logic [6:0] temp1, temp2;
logic choose;
logic [3:0] Exp_diff;
logic [4:0] Fract_diff;
logic [2:0] Bigger_exp;
logic sign_A, sign_B;
logic [7:0] A, B;

//Input A, B
D_FF (.clk(clk), .rst(rst), .E(EA), .data_i(in), .data_o(A));
D_FF (.clk(clk), .rst(rst), .E(EB), .data_i(in), .data_o(B));
//
Larger_Smaller (.A(A), .B(B), .choose(choose), .exp_diff(Exp_diff), .fract_diff(Fract_diff), .total_bigger_fract(temp1), .total_smaller_fract(temp2), .bigger_exp(Bigger_exp), .sign1(sign_A), .sign2(sign_B));

//compute A + B or A - B (A > B)
fa_7bit (.A(temp1), .B(temp2), .Cin(1'b0), .value(ff1));	//A + B or B + A
fa_7bit (.A(temp1), .B(temp2), .Cin(1'b1), .value(ff2));	//A - B 



//select value
totalAB (.Cin(Cin), .a(sign_A), .b(sign_B), .choose(choose), .ffAB(ff1), .ffBA(ff2), .out(ff), .final_sign(final_sign));	//ff is final fraction

//shift_counter of final fraction
encoder (.i(ff), .y(shift_counter));

//normal fraction
shifter_left (.enable(ff[7]), .sel(shift_counter), .ff(ff), .normal_fract(final_fract));

//normal exponent
normal_exp (.bigger_exp(Bigger_exp), .e(ff[7]), .shift_counter(shift_counter), .final_exp(Final_exp));

//Overflow and Zero
overflow (.Exp(Final_exp), .overflow(overflow));
Zero (.sign_A(A[7]), .sign_B(B[7]), .Cin(Cin), .exp_diff(Exp_diff), .fract_diff(Fract_diff), .Z(zero));
/*
//find final sign
always @(*) begin
	if (Exp_diff != 4'b0000 && Exp_diff[3] == 1'b1) begin
		final_sign = sign_B;
		end
	else if (Exp_diff != 4'b0000 && Exp_diff[3] == 1'b0) begin
		final_sign = sign_A;
		end
	else if (Exp_diff == 4'b0000 && Fract_diff[4] == 1'b1) begin
		final_sign = sign_B;
		end
	else if (Exp_diff == 4'b0000 && Fract_diff[4] == 1'b0) begin
		final_sign = sign_A;
		end
end
*/

endmodule : compute