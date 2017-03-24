`timescale 1ns / 1ps

module Lab2_1b(
    input [3:0] sw,
    output [4:0] ld
    );

wire error;
assign error = sw > 4'd9;
					
					
assign ld[0] = sw[0] | error;
assign ld[1] = sw[1] | error;
assign ld[2] = sw[2] | error;
assign ld[3] = sw[3] | error;
assign ld[4] = error;

endmodule
