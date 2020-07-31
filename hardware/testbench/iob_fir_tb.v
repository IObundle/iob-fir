`timescale 1ns / 1ps

module iob_fir_tb;

   reg clk=1, rst=1;

   always #10 clk = ~clk;

   initial #100 begin
      $dumpfile("fir.vcd");
      $dumpvars;
      
      rst = 0;
      #1000 $finish;
      
   end
   wire [12:0] data_out;
   
   iob_fir for0 (
                 .clk(clk),
                 .rst(rst),
                 .data_in(2'b01),
                 .data_out(data_out)
                 );
                 
endmodule // iob_fir_tb
