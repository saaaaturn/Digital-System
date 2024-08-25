module REGISTER_W
(
	input 	logic clk, reset, en,
	input 	logic data_in,
	output 	logic data_out
);
//
always@(posedge clk)
begin
	if (reset)
		data_out = 1'b0;
	else if (en)
		data_out = data_in;
	else
		data_out = data_out;
end
//
endmodule : REGISTER_W