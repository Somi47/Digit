`timescale 1ns / 1ps

module Lab1(
    input  [7:0] sw,
    output [7:0] ld
);

// assign<jel>=<kifejezés>
// jel: csak wire
assign ld = ~sw + 8'd1;


endmodule
