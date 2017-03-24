`timescale 1ns / 1ps

module MAN_FSM(
	input        clk,
	input        rst,
	output [2:0] man_out
);

reg  [2:0] state;
wire [2:0] next_state;

wire a, b, c;
assign {a, b, c} = state;

always @ (posedge clk)
begin
	if(rst)
		state <= 3'd0;
	else
		state <= next_state;
end

assign next_state[2] = ~a&~c | ~a&b | b&c;
assign next_state[1] = ~a&c | ~a&b | b&~c;
assign next_state[0] = ~a&~b&c | ~a&b&~c | a&b&c | a&~b&~c;

assign man_out = state;

endmodule
