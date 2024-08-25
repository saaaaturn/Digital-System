module MyROM
#(parameter intFile = "inst_mem.mif")
(
 input logic [8:0] data_in, 
 input logic [6:0] addr,
 input logic clk,
 input logic Enable_W, 
 output  [8:0] data_out
 //reset
);
/*
if(reset) begin
  for(i = 0; i <127; i++) begin
  mem[i] = 0;
  end
  end
*/
  integer i;
  reg [8:0] mem [127:0];
  initial begin
$readmemb(intFile,mem);
  end
always @(posedge clk) begin

 if(Enable_W == 1'b1) begin
 mem[addr] = data_in;
 end
 else begin
 data_out <= mem[addr];
 end
end
endmodule : MyROM

