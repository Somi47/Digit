`timescale 1ns / 1ps

//*****************************************************************************
//* A legnagyobb közös osztó (GCD) számító egység top-level modulja.          *
//*****************************************************************************
module gcd_calculator(
   input  wire       clk,
   input  wire       clk16M,
   input  wire       rst,
   input  wire       mosi,
   output wire       miso,
   input  wire [1:0] bt,
   input  wire [7:0] sw,
   output wire [7:0] seg_n,
   output wire [3:0] dig_n,
   output wire [4:0] col_n
);

//*****************************************************************************
//* Operandus regiszterek.                                                    *
//*****************************************************************************
//Regiszter az A operandus tárolásához.
reg [7:0] op_a;

always @(posedge clk)
begin
   if (rst)
      op_a <= 8'd0;
   else
      if (bt[0])
         op_a <= sw;
end

//Regiszter a B operandus tárolásához.
reg [7:0] op_b;

always @(posedge clk)
begin
   if (rst)
      op_b <= 8'd0;
   else
      if (bt[1])
         op_b <= sw;
end


//*****************************************************************************
//* Legnagyobb közös osztó (GCD) számító modul.                               *
//*****************************************************************************
wire [7:0] a_out;
wire [7:0] b_out;

gcd gcd(
   .clk(clk),
   .rst(rst),
   .start(mosi),
   .ai(op_a),
   .bi(op_b),
   .ready(miso),
   .ao(a_out),
   .bo(b_out)
);


//*****************************************************************************
//* Kijelzõ vezérlés.                                                         *
//*****************************************************************************
wire [7:0] seg;
wire [3:0] dig;

LIP_4digit LIP_4digit(
   .clk16M(clk16M),                    // 16MHz frekvenciájú órajel
   .rst(rst),                          // Szinkron RESET jel
   .number({b_out, a_out}),            // 16 bites szám bemenet
   .dp(4'b0100),                       // Tizedes pontok
   .seg(seg),                          // Szegmens kimenetek
   .dig(dig)                           // Digit kimenetek
);

assign seg_n = ~seg;
assign dig_n = ~dig;
assign col_n = 5'b11111;

endmodule
