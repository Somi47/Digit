`timescale 1ns / 1ps

module Lab3_1(
	input  wire [7:0] sw,
	input  wire [3:0] bt,
	output wire [7:0] ld
 );
 
// DEC3_8 kutyus(
//	.in ( sw[2:0] ),
//	.en ( sw[3]),
//	.out( ld )
// );

PRIE8_3 cicus(
	.in(sw),
	.en(bt[0]),
	.out(ld[2:0]),
	.invalid(ld[7])
);

assign ld[6:3] = 4'b0000;


endmodule
