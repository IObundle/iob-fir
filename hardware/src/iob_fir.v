`timescale 1ns / 1ps

module iob_fir
# (
   parameter DATA_IN_W = 8,
   parameter DATA_OUT_W = 8,
   parameter COEFF_W = 8,
   parameter COEFF_FILE = "",
   parameter LENGTH = 32,
   parameter LENGTH_W = 5
   )
   (
    input                          clk,
    input                          rst,
    input signed [DATA_IN_W-1:0]   data_in,
    output reg signed [DATA_OUT_W-1:0] data_out
    );

   //read data into shift register
   integer                                               j;   
   reg signed [DATA_IN_W-1:0]                            shift_reg[LENGTH-1:0];

   
   always@(posedge clk, posedge rst)
     if(rst)
      for(j=0; j<LENGTH; j=j+1)
        shift_reg[j] <= 0;
     else begin
        shift_reg[0] <= data_in;
        for(j=1; j<LENGTH; j=j+1)
          shift_reg[j] <= shift_reg[j-1];
     end

   // init coeff memory
   reg signed [COEFF_W-1:0]  h[LENGTH/2-1:0];
   initial $readmemh(COEFF_FILE, h, 0, LENGTH/2-1);

   wire [15:0]               watch_coeff = h[1];
   

   //compute convolution                      
   integer                   k;
 
   always@* begin
      data_out = 0;
      for(k=0; k<LENGTH/2; k=k+1)
        data_out = data_out + (shift_reg[k] + shift_reg[LENGTH-1-k])*h[k];
   end
   
endmodule

