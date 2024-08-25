module MyROM
#(parameter int unsigned width = 9,
parameter int unsigned depth = 32,
parameter intFile = "inst_mem.mif",
parameter int unsigned addrBits = 5)
(
	input logic clk,
	input logic [addrBits-1:0] ADDRESS,
	output logic [0:width-1] DATAOUT
);
logic [width-1:0] rom [0:depth-1];
// initialize ROM contents
initial begin
$readmemb(intFile,rom);
end
always_ff @ (posedge clk)
begin
	DATAOUT <= rom[ADDRESS];
end
endmodule : MyROM

