`timescale 1ns / 1ps

module STD_FSM(
	input        clk,
	input        rst,
	output [2:0] std_out
);

localparam START = 3'd0;
localparam A     = 3'd4;
localparam B     = 3'd1;
localparam C     = 3'd3;
localparam D     = 3'd6;
localparam E     = 3'd2;
localparam F     = 3'd7;
localparam G     = 3'd5;

reg [2:0] state, next_state;

always @ (posedge clk)
begin
	if(rst)
		state <= 3'd0;
	else
		state <= next_state;
end

always @ (*)
begin
	case(state)
		START  : next_state <= A;
		A      : next_state <= B;
		B      : next_state <= C;
		C      : next_state <= D;
		D      : next_state <= E;
		E      : next_state <= F;
		F      : next_state <= G;
		G      : next_state <= START;
		default: next_state <= START;
	endcase
end

assign std_out = state;

endmodule
