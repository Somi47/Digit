`timescale 1ns / 1ps

module Lab3_2(
	input  wire       clk,
	input  wire [7:0] sw,
	output wire [7:0] seg_n,
	output wire [3:0] dig_n,
	output wire [4:0] col_n
 );
 
 //MUX
 wire [3:0] mux_out = ( clk ) ? sw[7:4] : sw[3:0];
 
 reg [6:0] dec_out;
 
 //7 szegmenses kijelzo
    always @(*)
      case (mux_out)
          4'b0001 : dec_out = 7'b1111001;   // 1
          4'b0010 : dec_out = 7'b0100100;   // 2
          4'b0011 : dec_out = 7'b0110000;   // 3
          4'b0100 : dec_out = 7'b0011001;   // 4
          4'b0101 : dec_out = 7'b0010010;   // 5
          4'b0110 : dec_out = 7'b0000010;   // 6
          4'b0111 : dec_out = 7'b1111000;   // 7
          4'b1000 : dec_out = 7'b0000000;   // 8
          4'b1001 : dec_out = 7'b0010000;   // 9
          4'b1010 : dec_out = 7'b0001000;   // A
          4'b1011 : dec_out = 7'b0000011;   // b
          4'b1100 : dec_out = 7'b1000110;   // C
          4'b1101 : dec_out = 7'b0100001;   // d
          4'b1110 : dec_out = 7'b0000110;   // E
          4'b1111 : dec_out = 7'b0001110;   // F
          default : dec_out = 7'b1000000;   // 0
      endcase

assign seg_n = {1'b1, dec_out};
assign dig_n = {2'b11, clk, ~|clk};
assign col_n = {5'b11111};

endmodule
