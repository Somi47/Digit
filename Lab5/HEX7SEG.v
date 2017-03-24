`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Hexa -> 7 szegmenses dek�der, inakt�v tizedes ponttal
// Pon�lt logik�ban megfogalmazva
// Tiszt�n kombin�ci�s h�l�zat, a reg t�pus az always blokkos viselked�si le�tr�s
// miatt sz�ks�ges
// Term�szetesen tekinthetj�k ezt a logik�t egy 16 b�jtos olvashat� mem�ri�nak is
// A 7-szegmenses szegmensk�pek kiolvashat�k
// az al�bbi �bra alapj�n pozit�v logik�ban
// 76543210 bitsorrend szerint a k�dvektorban
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
