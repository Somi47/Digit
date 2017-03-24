`timescale 1ns / 1ps

module SIM_MODUL;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] man_out;
	wire [2:0] std_out;
	wire [2:0] ind_out;

	// Instantiate the Unit Under Test (UUT)
	HF1 uut (
		.clk(clk), 
		.rst(rst), 
		.man_out(man_out), 
		.std_out(std_out), 
		.ind_out(ind_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#110 rst = 1;
		
		#100 rst = 0;

	end
      
	always
	begin
		#50 clk = ~clk;
	end
endmodule

