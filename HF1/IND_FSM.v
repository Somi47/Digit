`timescale 1ns / 1ps

module IND_FSM(
	input        clk,
	input        rst,
	output [2:0] ind_out
);

reg [2:0]cnt, out;


always @ (posedge clk)
begin
	if(rst)
		cnt <= 3'd0;
	else
		cnt <= cnt + 1;
end


always @ (*)
begin
	case(cnt)
		3'd0   : out <= 3'd0;
		3'd1   : out <= 3'd4;
		3'd2   : out <= 3'd1;
		3'd3   : out <= 3'd3;
		3'd4   : out <= 3'd6;
		3'd5   : out <= 3'd2;
		3'd6   : out <= 3'd7;
		3'd7   : out <= 3'd5;
		default: out <= 3'd0;
	endcase
end

assign ind_out = out;

endmodule
