`timescale 1ns / 1ns
/*
 * Design: ECE 274 - Clock Divider generating 1 Hz clock output from 50 MHz input clock
 * Author: Roman Lysecky 
 * Copyright 2008, All Rights Reserved
 *
 * Date: August 19, 2008
 *
 */
module clockdivider(Clk, ClkOut);
   input Clk;
   output reg ClkOut;
  
   parameter DivVal = 25000000; //25000000;
   reg[24:0] DivCnt;
   reg ClkInt;
	
   always @(posedge Clk) begin
		if( DivCnt == DivVal ) begin
			ClkOut <= ~ClkInt;
         ClkInt <= ~ClkInt;
         DivCnt <= 0;
      end
      else begin
			ClkOut <= ClkInt;
         ClkInt <= ClkInt;
         DivCnt <= DivCnt + 1;
      end
   end
endmodule
