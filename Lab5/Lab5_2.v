`timescale 1ns / 1ps

module Lab5_2(
	input  wire       clk,
	input  wire       clk16M,
	input  wire       rst,
	input  wire       rstbt,
	input  wire       mosi,
	output wire       miso,
	input  wire [7:0] sw,
	input  wire [4:0] bt,
	output wire [7:0] seg_n,
	output wire [3:0] dig_n,
	output wire [4:0] col_n
);

reg [15:0] q = 16'd0;

wire tc0;

CNT4 cnt0(
	.clk(clk),
	.rst(rstbt),
	.load(bt[0]),
	.en(rst),
	.dir(mosi),
	.d(sw[3:0]),
	.q(q[3:0]),
	.tc(tc0)
);

wire tc1;

CNT4 cnt1(
	.clk(clk),
	.rst(rstbt),
	.load(bt[0]),
	.en(tc0),
	.dir(mosi),
	.d(sw[3:0]),
	.q(q[7:3]),
	.tc(tc1)
);

wire tc2;

CNT4 cnt2(
	.clk(clk),
	.rst(rstbt),
	.load(bt[0]),
	.en(tc1),
	.dir(mosi),
	.d(sw[3:0]),
	.q(q[11:7]),
	.tc(tc2)
);

CNT4 cnt3(
	.clk(clk),
	.rst(rstbt),
	.load(bt[0]),
	.en(tc2),
	.dir(mosi),
	.d(sw[3:0]),
	.q(q[15:11]),
	.tc(miso)
);

LIP_4digit LIP_4digit(
            .clk16M(clk16M),                   	// 16MHz frekvenciájú órajel
            .rst(rstbt),                         // Szinkron RESET jel
            .number(q),               // 16 bites szám bemenet
            .dp(4'b0000),                   // Tizedes pontok
            .seg(seg),                  // Szegmens kimenetek
            .dig(dig)               // Digit kimenetek
);

assign seg_n = ~seg;
assign dig_n = ~dig;
assign coln  = 4'b1111;

endmodule
