`timescale 1ns / 1ps

module EncoderInvalidSignalCheck(
	input  wire [7:0] in_to_check,
	input  wire       en,
	output wire       invalid
);

assign invalid = ~en | ( in_to_check != 8'b1000_0000 &&
								 in_to_check != 8'b0100_0000 &&
								 in_to_check != 8'b0010_0000 &&
								 in_to_check != 8'b0001_0000 &&
								 in_to_check != 8'b0000_1000 &&
								 in_to_check != 8'b0000_0100 &&
								 in_to_check != 8'b0000_0010 &&
								 in_to_check != 8'b0000_0001  );

endmodule
