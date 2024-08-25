module REGISTER
(
	input 	logic clk, reset, en,
	input 	logic [8:0] data_in,
	output 	logic [8:0] data_out
);
//
always@(posedge clk)
begin
	if (reset)
		data_out = 9'b0;
	else if (en)
		data_out = data_in;
	else
		data_out = data_out;
end
//
endmodule : REGISTER