module Larger_Smaller (
	input logic [7:0] A, B,
	output logic [2:0] bigger_exp,
	output logic [3:0] exp_diff,
	output logic [4:0] fract_diff,
	output logic [3:0] Bigger_fract, Smaller_fract,
	output logic [5:0] Shifted_fract,
	output logic [6:0] total_bigger_fract, total_smaller_fract,
	output logic choose, sign_big, sign_small, sign1, sign2
);

assign sign1 = A[7];
assign sign2 = B[7];

// find exp_diff
logic [3:0] N, N1;
fa_3bit exp_diff1 (
	.A(A[6:4]),
	.B(B[6:4]),
	.Cin(1'b1),
	.value(N)
);

// find fract_diff
fa_4bit fract_diff1 (
	.A(A[3:0]),
	.B(B[3:0]),
	.Cin(1'b1),
	.value(fract_diff)
);

// check MSB of exp_diff
always @(*) begin
	if (N == 4'b0000) begin
		if (fract_diff[4] == 1'b0) begin
			Bigger_fract = A[3:0];
			Smaller_fract = B[3:0];
			bigger_exp = A[6:4];
			choose = 1'b0;
//			sign_big = A[7];
//			sign_small = B[7];
			end
		else if (fract_diff[4] == 1'b1) begin
			Bigger_fract = B[3:0];
			Smaller_fract = A[3:0];
			bigger_exp = B[6:4];
			choose = 1'b1;
//			sign_big = B[7];
//			sign_small = A[7];
			
			end
	end
	else if (N != 4'b0000) begin
		if (N[3] == 1'b0) begin
			Bigger_fract = A[3:0];
			Smaller_fract = B[3:0];
			bigger_exp = A[6:4];
			choose = 1'b0;
//			sign_big = A[7];
//			sign_small = B[7];
			end
		else if (N[3] == 1'b1) begin
			Bigger_fract = B[3:0];
			Smaller_fract = A[3:0];
			bigger_exp = B[6:4];
			choose = 1'b1;
//			sign_big = B[7];
//			sign_small = A[7];
			end
	end
end


//determine amount to right shift
always_comb begin
	if (N == 4'b0000) begin
		exp_diff = 4'b0000;
		end
	else if (N[3] == 1'b0) begin
		exp_diff = N;
		end
			else
				exp_diff = ~N + 1;
end

assign N1 = exp_diff - 1;
//Right shift fraction value of the smaller operand
logic [5:0] Sf, n_Sf, X, Y, Z;
assign X = {Smaller_fract, 2'b00};
always@(*) begin
	if (N == 4'b0000) begin
		Sf = X;
		total_smaller_fract = {1'b1, Sf};
		end
	else if (N != 4'b0000) begin
		n_Sf = ~X;
		Y = n_Sf >> 1;
		Z = ~Y;
		Sf = Z >> N1;
		total_smaller_fract = {1'b0, Sf};
		end
end 

assign total_bigger_fract = {1'b1, Bigger_fract, 2'b00};
assign Shifted_fract = Sf;

endmodule : Larger_Smaller