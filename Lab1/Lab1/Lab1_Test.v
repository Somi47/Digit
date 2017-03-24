`timescale 1ns / 1ps

module Lab1_Test;

	// Inputs
	reg [7:0] sw;

	// Outputs
	wire [7:0] ld;

	// Instantiate the Unit Under Test (UUT)
	Lab1 uut (
		.sw(sw), 
		.ld(ld)
	);
	
	integer i;


	initial begin
		// Initialize Inputs
		// sw = 0;

		// Wait 100 ns for global reset to finish
		// #100;
        
		// Add stimulus here
		
		// Konstans megadása
		// <bitszám>'<számrendszer><konstans>;
		// számrendszer:
		// 	b = bin(2)
		// 	o = oktális(8)
		// 	d = decimalis(10)
		// 	h = hexa(16)
		
		// sw = 8'h55;
		// #100;
		// sw = 8'haa;
		// #100;
		// sw = 8'h0f;
		// #100;
		// sw = 8'hf0;
		
		// For Ciklus
		// integer <ciklusvált>;
		// for( i=0; i < 256; i = i + 1 );
		// begin
		// ...
		// end
		
		for(i = 0; i<265; i=i+1)
		begin
		sw = i;
		#100;
		end
		

	end
      
endmodule

