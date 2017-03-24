`timescale 1ns / 1ps

module PRIE8_3(
	input  wire [7:0] in,
	input  wire       en,
	output reg  [2:0] out,
	output wire       invalid
);
always @ (*)
begin
	if( en == 0 )
		out = 3'd0;
	else
		casex( in )
			8'b1xxx_xxxx: out = 3'd7;
			8'b01xx_xxxx: out = 3'd6;
			8'b001x_xxxx: out = 3'd5;
			8'b0001_xxxx: out = 3'd4;
			8'b0000_1xxx: out = 3'd3;
			8'b0000_01xx: out = 3'd2;
			8'b0000_001x: out = 3'd1;
			8'b0000_000x: out = 3'd0;
		endcase
end

assign invalid = ( in == 8'd0 ) & en;

endmodule
