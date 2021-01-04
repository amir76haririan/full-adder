module test_bench;

 // Inputs
 reg clk;
 reg rst_n;

 // Instantiate the Unit Under Test (UUT)
 riscv_top riscvtest (
  .clk(clk),
  .rst_n(rst_n)
   );

 initial 
  begin
   clk =0;
	rst_n=0;
	#5;
	rst_n=1;
   $finish;
  end

 always 
  begin
   #5 clk = ~clk;
  end
endmodule
