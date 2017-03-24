`timescale 1ns / 1ps

module DEC3_8(
	input wire [2:0] in,
	input wire       en,
	output reg [7:0] out
);

always @ (*) // ( in, en )
begin
	if( en == 0 )
		out = 8'b0000_0000;
	else
		case( in )
		3'd0: out = 8'b0000_0001;
		3'd1: out = 8'b0000_0010;
		3'd2: out = 8'b0000_0100;
		3'd3: out = 8'b0000_1000;
		3'd4: out = 8'b0001_0000;
		3'd5: out = 8'b0010_0000;
		3'd6: out = 8'b0100_0000;
		3'd7: out = 8'b1000_0000;
		endcase
end

endmodule
