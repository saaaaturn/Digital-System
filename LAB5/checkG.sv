module checkG
(
	input		logic en,
	input		logic [8:0] G_data,
	output	logic checked
);
always_comb
if (!en)
	checked = 1'b0;
else if (en && G_data != 9'b0)
	checked = 1'b1;
else
	checked = 1'b0;
//
endmodule : checkG