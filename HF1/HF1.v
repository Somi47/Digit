`timescale 1ns / 1ps

module HF1(
	input clk,
	input rst,
	output [2:0] man_out,
	output [2:0] std_out,
	output [2:0] ind_out
);

MAN_FSM MAN(
	.clk(clk),
	.rst(rst),
	.man_out(man_out)
);

STD_FSM STD(
	.clk(clk),
	.rst(rst),
	.std_out(std_out)
);

IND_FSM IND(
	.clk(clk),
	.rst(rst),
	.ind_out(ind_out)
);

endmodule
