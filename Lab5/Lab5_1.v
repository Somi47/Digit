`timescale 1ns / 1ps

module Lab5_1(
	input  wire       clk,
	input  wire       rst,
	input  wire       mosi,
	output wire       miso,
	input  wire [7:0] sw,
	output wire [7:0] ld
);

//8 bites register

reg  [7:0] q;
wire [7:0] d    = sw;
wire       load = rst;
wire       en   = mosi;

always @ (posedge clk)
begin
	if( load )
		q <= d;
	else
		if( en )
			q <= {q[6:0], 1'b0};
end

assign ld = q;
assign miso = 1'b0;


endmodule
