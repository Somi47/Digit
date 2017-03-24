`timescale 1ns / 1ps

module CNT4(
	input  wire       clk,
	input  wire       rst,
	input  wire       load,
	input  wire       en,
	input  wire       dir,
	input  wire [4:0] d,
	output reg  [4:0] q,
	output wire       tc
);

always @ (posedge clk)
begin
	if(rst)
		q <= 4'd0;
	else
		if(load)
			q <= d;
		else
			if(en)
				if(dir)
					q <= q - 4'd1;
				else
					q <= q + 4'd1;
end

assign tc = (dir ? q == 4'b0000 : q == 4'b1111) & en;

endmodule
