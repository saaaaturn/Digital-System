module STORE_IR
(
	input		logic [8:0] IR,
	input 	logic en,
	output 	logic [8:0] instruction
);
//
reg [8:0] value;
//
always@(*)
begin
	if	(en)
		value = IR;
	else 
		value = value;
end
//
assign instruction = value;
endmodule : STORE_IR