`timescale 1ns / 1ps

//*****************************************************************************
//* Legnagyobb közös osztó (GCD) számító modul.                               *
//*****************************************************************************
module gcd(
   input  wire       clk,
   input  wire       rst,
   input  wire       start,
   input  wire [7:0] ai,
   input  wire [7:0] bi,
   output wire       ready,
   output reg  [7:0] ao,
   output reg  [7:0] bo
);

//*****************************************************************************
//* Adatstruktúra                                                             *
//*****************************************************************************


// A kivonás eredménye

wire [7:0] diff;

// A operandushoz tartozó multifunkciós reg
wire ld_a;
wire upd_a;

always @ (posedge clk)
begin
	if( ld_a )
		ao <= ai;
	else
	 if(upd_a)
		ao <= diff;
end

// B operandushoz tartozó multifunkciós reg
wire ld_b;
wire upd_b;

always @ (posedge clk)
begin
	if( ld_b )
		bo <= bi;
	else
	 if(upd_b)
		bo <= diff;
end

// Cserét elvégzo mux
wire exch;
wire [7:0]a_mux = exch ? bo : ao;
wire [7:0]b_mux = exch ? ao : bo;

// Kivonó
assign diff = a_mux - b_mux;


// Komparátor
wire a_gt_b = ao > bo;
wire b_gt_a = bo > ao;

//*****************************************************************************
//* Vezérlo állapotgép                                                        *
//*****************************************************************************

localparam WAIT = 3'd0;
localparam LOAD = 3'd1;
localparam CHK  = 3'd2;
localparam SUB  = 3'd3;
localparam RSUB = 3'd4;
localparam DONE = 3'd5;

reg [2:0] state;

always @ (posedge clk)
begin
	if(rst)
		state = WAIT;
	else
		case( state )
			WAIT: if( start ) 
						state <= LOAD;
					else
						state <= WAIT;
			LOAD: state <= CHK;
			CHK:  if( a_gt_b )
						state <= SUB;
					else
						if( b_gt_a )
							state <= RSUB;
						else
							state <= DONE;
			SUB:  state <= CHK;
			RSUB: state <= CHK;
			DONE: state <= WAIT;
			default: state <= WAIT;
		endcase
end

assign ld_a  = state == LOAD;
assign upd_a = state == SUB;

assign ld_b  = state == LOAD;
assign upd_b = state == RSUB;

assign exch  = state == RSUB;

assign ready = state == DONE;

endmodule
