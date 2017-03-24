`timescale 1ns / 1ps

module Lab2_1a(
    input [3:0] sw,
    output [3:0] ld
    );

	// Bitenk�nti oper�torok:
	// VAGY: |, �S: &, NOT: ~, XOR: ^
	// Bitredukci�s oper�torok:
	// assign b = &a ("a" bitjeit �ssze�seli)
	
	//ld0: AND
	//ld1: OR
	//ld2: XOR
	//ld3: NOR
	
	assign ld[0] =  &sw; // sw[0] & sw[1] & sw[2] & sw[3]
	assign ld[1] =  |sw;
	assign ld[2] =  ^sw;
	assign ld[3] = ~|sw;

endmodule
