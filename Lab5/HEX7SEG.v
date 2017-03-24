`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Hexa -> 7 szegmenses dekóder, inaktív tizedes ponttal
// Ponált logikában megfogalmazva
// Tisztán kombinációs hálózat, a reg típus az always blokkos viselkedési leítrás
// miatt szükséges
// Természetesen tekinthetjük ezt a logikát egy 16 bájtos olvasható memóriának is
// A 7-szegmenses szegmensképek kiolvashatók
// az alábbi ábra alapján pozitív logikában
// 76543210 bitsorrend szerint a kódvektorban
//      0          
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---      . 7
//      3
//
//////////////////////////////////////////////////////////////////////////////////
module HEX7SEG(
    input      [3:0] value,
    output reg [7:0] code
    );
    
always @ (*)
   case (value)
      4'h0: code = 8'b00111111;
      4'h1: code = 8'b00000110;
      4'h2: code = 8'b01011011;
      4'h3: code = 8'b01001111;
      4'h4: code = 8'b01100110;
      4'h5: code = 8'b01101101;
      4'h6: code = 8'b01111101;
      4'h7: code = 8'b00000111;
      4'h8: code = 8'b01111111;
      4'h9: code = 8'b01101111;
      4'hA: code = 8'b01110111;
      4'hb: code = 8'b01111100;
      4'hC: code = 8'b00111001;
      4'hd: code = 8'b01011110;
      4'hE: code = 8'b01111001;
      4'hF: code = 8'b01110001;
   endcase   

endmodule
